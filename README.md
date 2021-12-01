# clinical-trial-matching-service-template

Template which streamlines the process of writing a server for clinical trial matching system.

For more information on the architecture and data schemas of the clinical trial matching system, please visit the clinical-trial-matching-engine [wiki](https://github.com/mcode/clinical-trial-matching-engine/wiki).

These steps give an overview of steps you need to take to get the template into a running server that will send requests to the underlying matching service.

## Basic Steps:

1. Open `src/query.ts`. This file contains a stub implementation of the query mapper - the function that receives a FHIR Bundle of patient data and uses it to look up matching clinical trials.
    - The `createClinicalTrialLookup()` function creates the underlying function used. It creates a closure over the necessary configuration information, and handles creating a new `APIQuery` object based on patient data and then calling `sendQuery()` to send the actual query.
    - Edit `APIQuery` to pull any necessary information out of the patient data and its `toQuery()` function to generate an appropriate query. Learn more about the patient bundle that will be sent [in the matching engine wiki](https://github.com/mcode/clinical-trial-matching-engine/wiki/Data-Model).
    - Fill out your `QueryResponse` and `QueryTrial` types to match what the service returns.
    - Modify `QueryErrorResponse` and `sendQuery()` to handle errors returned by the service.
2. Open `src/researchstudy-mapping.ts`. This file contains a single function: `convertToResearchStudy` function, which handles converting individual trials as returned from the underlying service into FHIR ResearchStudy objects. While the stub is small, the bulk of additional code is likely to be in here.
3. Open `src/server.ts`. This contains the code to start the service, as well as load configuration data. The default is very simplistic, it simply loads configuration via `configFromEnv()` and passes it off to the `createClinicalTrialLookup()` function. The default implementation uses [dotenv-flow](https://github.com/kerimdzhanov/dotenv-flow) to load configuration from local `.env` files - see the dotenv-flow documentation for more details about how it decides which files and in what order to load from. It may be worth changing the environment variable used to set the environment (defaults to `NODE_ENV`) and the default environment that is used (defaults to `"development"`).

    Note that the function exported from this module is used by `start.js` to start the server. While additional optional arguments will be called, the implementation of invoking it in `start.js` expects it to work when called with no arguments and to return a Promise. The Promise is used solely to catch errors - if the Promise is rejected, the error is printed using `console.error`, but nothing is done when the Promise resolves successfully as in that case the server should now be running in the background.

You may need to further tweek the code stubs provided, and there are other ways to implement a service implemenation. (For example, you could simply extend `ClinicalTrialMatchingService` and pass it a matcher that invokes a method on the generated class.) However the steps above should provide the basic stubs necessary to generate an implementation of a matching service.

# Requirements

The ResearchStudy object passed back by this server must be [FHIR-compliant](https://www.hl7.org/fhir/researchstudy.html) and satisfy several requirements. It must contain:
- Title
- Summary
- Site location
- Phase
- Contact Information i.e. sponsor email, phone number
- Study Type
- Inclusion/ Exclusion criteria

# Running the Server

1. Run `npm install`
2. Run `npm start`
3. The service will now be running at http://localhost:3000/

# Testing

A validation test is provided to validate the ResearchStudy created via this service. Put an example response object in `spec/data/trial_object.json` and this object will be loaded and validated by the test in `spec/validate.spec.ts`.

For this test to produce meaningful results, you must have:

1. Placed appropriate test data in `spec/data/trial_object.json` (the default is an empty object)
2. Properly implemented `convertToResearchStudy` in `src/researchstudy-mapping.ts`

The test will always output any messages from the FHIR validator, even if the result is valid, so you may see warning messages displayed in the test output.
