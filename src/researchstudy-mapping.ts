/**
 * This module exports a function for mapping a trial in the format returned by
 * the underlying service to the FHIR ResearchStudy type.
 */

import { ResearchStudy } from 'clinical-trial-matching-service';
import { QueryTrial } from './query';

export function convertToResearchStudy(json: QueryTrial, id: number): ResearchStudy {
  const result = new ResearchStudy(id);
  // Add whatever fields can be added here, for example:
  result.status = 'active';
  return result;
}

export default convertToResearchStudy;
