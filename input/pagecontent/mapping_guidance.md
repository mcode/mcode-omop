### Mapping Guidance

#### General

##### Date Handling

##### Mapping to OMOP Concepts

The OMOP Ontology is an amalgamation of multiple standard and non-standard concepts that are normalized to an overarching OMOP concept. OMOP creates separate fields dedicated to the OMOP concept id, and to other supported terminologies.

#### Mapping Primary Cancer Diagnoses

mCODE and the OMOP CDM Oncology Extension differ in their representation of primary cancer diagnoses:

* mCODE aligns with EHRs which capture primary cancers as a problem or diagnosis list as ICD-10 or SNOMED-CT codes. The topography and histology characteristics of a tumor are represented as separate data elements within the PrimaryCancerCondition FHIR profile.
* The OMOP "base" CDM can accept both ICD-10-CM, SNOMED-CT, and ICD-O-3 for representing conditions.
* The OMOP Oncology extension Cancer Diagnosis ontology only aligns with ICD-O-3 and combines both the topography and histology as one OMOP concept and record in the CONDITION_OCCURENCE table.

Given these difference, multiple logical conversions might be required to convert an mCODE PrimaryCancerCondition FHIR instance to the OMOP Oncology Extension representation for Cancer Diagnosis. 

The logic for an example conversion is illustrated in the diagram below:

<object data="mCODE-OMOP-PrimaryCancerConditionVocab.svg" type="image/svg+xml"></object>
<br/>

#### Mapping to OMOP Cancer Modifiers

**TBD**
