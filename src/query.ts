/**
 * Handles conversion of patient bundle data to a proper request for matching service apis.
 * Retrieves api response as promise to be used in conversion to fhir ResearchStudy
 */
import https from "https";
import { IncomingMessage } from "http";
import {
  fhir,
  ClinicalTrialsGovService,
  ServiceConfiguration,
  ResearchStudy,
  SearchSet,
} from "clinical-trial-matching-service";
import convertToResearchStudy from "./researchstudy-mapping";

export interface QueryConfiguration extends ServiceConfiguration {
  endpoint?: string;
  auth_token?: string;
}

/**
 * Create a new matching function using the given configuration.
 *
 * @param configuration the configuration to use to configure the matcher
 * @param ctgService an optional ClinicalTrialGovService which can be used to
 *     update the returned trials with additional information pulled from
 *     ClinicalTrials.gov
 */
export function createClinicalTrialLookup(
  configuration: QueryConfiguration,
  ctgService?: ClinicalTrialsGovService
): (patientBundle: fhir.Bundle) => Promise<SearchSet> {
  // Raise errors on missing configuration
  if (typeof configuration.endpoint !== "string") {
    throw new Error("Missing endpoint in configuration");
  }
  if (typeof configuration.auth_token !== "string") {
    throw new Error("Missing auth_token in configuration");
  }
  const endpoint = configuration.endpoint;
  const bearerToken = configuration.auth_token;
  return function getMatchingClinicalTrials(
    patientBundle: fhir.Bundle
  ): Promise<SearchSet> {
    // Create the query based on the patient bundle:
    const query = new APIQuery(patientBundle);
    // And send the query to the server
    return sendQuery(endpoint, query, bearerToken, ctgService);
  };
}

export default createClinicalTrialLookup;

// Generic type for the request data being sent to the server. Fill this out
// with a more complete type.
type QueryRequest = string;

/**
 * Generic type for the trials returned.
 *
 * TO-DO: Fill this out to match your implementation
 */
export interface QueryTrial extends Record<string, unknown> {
  name: string;
}

/**
 * Type guard to determine if an object is a valid QueryTrial.
 * @param o the object to determine if it is a QueryTrial
 */
export function isQueryTrial(o: unknown): o is QueryTrial {
  if (typeof o !== "object" || o === null) return false;
  // TO-DO: Make this match your format.
  return typeof (o as QueryTrial).name === "string";
}

// Generic type for the response data being received from the server.
export interface QueryResponse extends Record<string, unknown> {
  matchingTrials: QueryTrial[];
}

/**
 * Type guard to determine if an object is a valid QueryResponse.
 * @param o the object to determine if it is a QueryResponse
 */
export function isQueryResponse(o: unknown): o is QueryResponse {
  if (typeof o !== "object" || o === null) return false;

  // Note that the following DOES NOT check the array to make sure every object
  // within it is valid. Currently this is done later in the process. This
  // makes this type guard or the QueryResponse type sort of invalid. However,
  // the assumption is that a single unparsable trial should not cause the
  // entire response to be thrown away.
  return Array.isArray((o as QueryResponse).matchingTrials);
}

export interface QueryErrorResponse extends Record<string, unknown> {
  error: string;
}

/**
 * Type guard to determine if an object is a QueryErrorResponse.
 * @param o the object to determine if it is a QueryErrorResponse
 */
export function isQueryErrorResponse(o: unknown): o is QueryErrorResponse {
  if (typeof o !== "object" || o === null) return false;
  return typeof (o as QueryErrorResponse).error === "string";
}

// Generic type that represents a JSON object - that is, an object parsed from
// JSON. Note that the return value from JSON.parse is an any, this does not
// represent that.
type JsonObject = Record<string, unknown>;

// API RESPONSE SECTION
export class APIError extends Error {
  constructor(
    message: string,
    public result: IncomingMessage,
    public body: string
  ) {
    super(message);
  }
}

/**
 * This class represents a query, built based on values from within the patient
 * bundle.
 * TO-DO
 * Finish making an object for storing the various parameters necessary for the api query
 * based on a patient bundle.
 * Reference https://github.com/mcode/clinical-trial-matching-engine/wiki to see patientBundle Structures
 */
export class APIQuery {
  // The following example fields are defined by default within the matching UI
  /**
   * US zip code
   */
  zipCode: string;
  /**
   * Distance in miles a user has indicated they're willing to travel
   */
  travelRadius: number;
  /**
   * A FHIR ResearchStudy phase
   */
  phase: string;
  /**
   * A FHIR ResearchStudy status
   */
  recruitmentStatus: string;
  /**
   * A set of conditions.
   */
  conditions: { code: string; system: string }[] = [];
  // TO-DO Add any additional fields which need to be extracted from the bundle to construct query

  /**
   * Create a new query object.
   * @param patientBundle the patient bundle to use for field values
   */
  constructor(patientBundle: fhir.Bundle) {
    for (const entry of patientBundle.entry) {
      if (!("resource" in entry)) {
        // Skip bad entries
        continue;
      }
      const resource = entry.resource;
      // Pull out search parameters
      if (resource.resourceType === "Parameters") {
        for (const parameter of resource.parameter) {
          if (parameter.name === "zipCode") {
            this.zipCode = parameter.valueString;
          } else if (parameter.name === "travelRadius") {
            this.travelRadius = parseFloat(parameter.valueString);
          } else if (parameter.name === "phase") {
            this.phase = parameter.valueString;
          } else if (parameter.name === "recruitmentStatus") {
            this.recruitmentStatus = parameter.valueString;
          }
        }
      }
      // Gather all conditions the patient has
      if (resource.resourceType === "Condition") {
        this.addCondition(resource);
      }
      // TO-DO Extract any additional resources that you defined
    }
  }

  /**
   * Handle condition data. The default implementation does nothing, your
   * implementation may pull out specific data.
   * @param condition the condition to add
   */
  addCondition(condition: fhir.Condition): void {
    for (const coding of condition.code.coding) {
      this.conditions.push(coding);
    }
  }

  /**
   * Create the information sent to the server.
   * @return {string} the api query
   */
  toQuery(): QueryRequest {
    return JSON.stringify({
      zip: this.zipCode,
      distance: this.travelRadius,
      phase: this.phase,
      status: this.recruitmentStatus,
      conditions: this.conditions,
    });
  }

  toString(): string {
    // Note that if toQuery is no longer a string, this will no longer work
    return this.toQuery();
  }
}

/**
 * Convert a query response into a search set.
 *
 * @param response the response object
 * @param ctgService an optional ClinicalTrialGovService which can be used to
 *     update the returned trials with additional information pulled from
 *     ClinicalTrials.gov
 */
export function convertResponseToSearchSet(
  response: QueryResponse,
  ctgService?: ClinicalTrialsGovService
): Promise<SearchSet> {
  // Our final response
  const studies: ResearchStudy[] = [];
  // For generating IDs
  let id = 0;
  for (const trial of response.matchingTrials) {
    if (isQueryTrial(trial)) {
      studies.push(convertToResearchStudy(trial, id++));
    } else {
      // This trial could not be understood. It can be ignored if that should
      // happen or raised/logged as an error.
      console.error("Unable to parse trial from server: %o", trial);
    }
  }
  if (ctgService) {
    // If given a backup service, use it
    return ctgService.updateResearchStudies(studies).then(() => {
      return new SearchSet(studies);
    });
  } else {
    // Otherwise, resolve immediately
    return Promise.resolve(new SearchSet(studies));
  }
}

/**
 * Helper function to handle actually sending the query.
 *
 * @param endpoint the URL of the end point to send the query to
 * @param query the query to send
 * @param bearerToken the bearer token to send along with the query to
 *     authenticate with the service
 * @param ctgService an optional ClinicalTrialGovService which can be used to
 *     update the returned trials with additional information pulled from
 *     ClinicalTrials.gov
 */
function sendQuery(
  endpoint: string,
  query: APIQuery,
  bearerToken: string,
  ctgService?: ClinicalTrialsGovService
): Promise<SearchSet> {
  return new Promise((resolve, reject) => {
    const body = Buffer.from(query.toQuery(), "utf8");

    const request = https.request(
      endpoint,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Content-Length": body.byteLength.toString(),
          Authorization: "Bearer " + bearerToken,
        },
      },
      (result) => {
        let responseBody = "";
        result.on("data", (chunk) => {
          responseBody += chunk;
        });
        result.on("end", () => {
          console.log("Complete");
          if (result.statusCode === 200) {
            let json: unknown;
            try {
              json = JSON.parse(responseBody) as unknown;
            } catch (ex) {
              reject(
                new APIError(
                  "Unable to parse response as JSON",
                  result,
                  responseBody
                )
              );
            }
            if (isQueryResponse(json)) {
              resolve(convertResponseToSearchSet(json, ctgService));
            } else if (isQueryErrorResponse(json)) {
              reject(
                new APIError(
                  `Error from service: ${json.error}`,
                  result,
                  responseBody
                )
              );
            } else {
              reject(new Error("Unable to parse response from server"));
            }
          } else {
            reject(
              new APIError(
                `Server returned ${result.statusCode} ${result.statusMessage}`,
                result,
                responseBody
              )
            );
          }
        });
      }
    );

    request.on("error", (error) => reject(error));

    request.write(body);
    request.end();
  });
}
