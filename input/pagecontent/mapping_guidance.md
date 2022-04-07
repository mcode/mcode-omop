### Mapping Guidance

#### General

##### Date Handling
OMOP generally provides two ways to express dates depending on the table:
* date
* date_time 

`start_date` and `end_date` fields are usually required while `start_date_time` and `end_date_time` are optional. 
The datatype for dates will vary with the database. In the OMOP DDL for Postgresql, `start_date` and `end_date` are of type "date" and `start_date_time` / `end_date_time` are of data type "timestamp". This could vary in the date input format.

For consistency, mCODE retain its existing format of **yyyy-mm-dd** for OMOP CDM `start_date` and `end_date` fields:
For example: _1999-01-08_

##### Handling FHIR Statuses

FHIR resources contain elements that describe statuses. Examples include `Condition.verificationStatus` and `ServiceRequest.status`. The OMOP CDM however does not have fields that describe event statuses. Instead, OMOP presumes the following:

* FHIR `Completed` statuses are recorded as end dates.
* FHIR `Active` statuses are recorded as start dates.

Subsequently, profiles which have these one of these status will require start, end, and/or "point-in-time" dates for mappings to the following mCODE-relevant OMOP tables which require one or more of these date fields:

* VISIT_OCCURRENCE
* VISIT_DETAIL
* CONDITION_OCCURRENCE
* DRUG_EXPOSURE
* PROCEDURE_OCCURRENCE
* MEASUREMENT
* OBSERVATION
* DEATH
* SPECIMEN

##### mCODE FHIR Observation mappings to OMOP MEASUREMENT or OBSERVATION

In FHIR, quantitative and qualitative measurements are handled under one common [Observation](https://www.hl7.org/fhir/observation.html) resource. OMOP differs in its approach and separates quantitative measuresments under [MEASUREMENT](https://ohdsi.github.io/CommonDataModel/cdm54.html#MEASUREMENT) and qualitative observations under [OBSERVATION](https://ohdsi.github.io/CommonDataModel/cdm54.html#OBSERVATION).

The distinction is not always clear since there are some measurements, particularly survey instruments which could be considered to be either one. An example in mCODE is [ECOGPerformanceStatus](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-ecog-performance-status.html), which is clinically an observation performed by the managing physician, but is recorded as a quantitative survey instrument with a score as an integer.
The implementer must disambiguate FHIR Observation to identify its context and determine whether the mapping is to OMOP MEASUREMENT or OBSERVATION. 

Reference the OMOP [MEASUREMENT](https://ohdsi.github.io/CommonDataModel/cdm54.html#MEASUREMENT) and [OBSERVATION](https://ohdsi.github.io/CommonDataModel/cdm54.html#OBSERVATION) table definitions for further details.

##### Handling Relationships Between Tables

FHIR models have constructs called References which relate multiple FHIR resources if needed. Examples include an observation which was performed because of a patient disease. Examples in mCODE include:  the following:

* [CancerRelatedMedicationAdministration](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-cancer-related-medication-administration.html) profile where the [MedicationAdministration.reasonReference](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-cancer-related-medication-administration-definitions.html#MedicationAdministration.reasonReference) element is a reference to the mCODE profile [PrimaryCancerCondition](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-primary-cancer-condition.html) or [SecondaryCancerCondition](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-secondary-cancer-condition.html) profile.



#### Domain-specific Mapping Guidance

##### Cancer Conditions

Examples: [PrimaryCancerCondition](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-primary-cancer-condition.html), [SecondaryCancerCondition](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-secondary-cancer-condition.html)

* if a FHIR `Condition.clinicalStatus` is _active_, then that FHIR condition SHALL existing `Condition.onsetDateTime` or `onsetPeriod.start` which will map to `CONDITION_OCCURRENCE.condition_start_date`.
* if FHIR `Condition.clinicalStatus` is _resolved_, then that condition SHALL have `Condition.onsetDateTime` or `onsetPeriod.end` which will map to the `CONDITION_OCCURRENCE.condition_end_date`.

##### Medication Statuses

Examples: [CancerRelatedMedicationAdministration](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-cancer-related-medication-administration.html)

* FHIR instances with the following `MedicationAdministration.status` values will not be sent to OMOP: _in-progress, not-done, on-hold, entered-in-error, stopped, unknown_
* FHIR instances with `MedicationAdministration.status` = _completed_ SHALL have existing `MedicationAdministration.effectiveDateTime` which is mapped to `DRUG_OCCURRENCE.drug_exposure_end_date`

##### Verification Status

FHIR `Condition.verificationStatus` is semantically equivalent to the OMOP Condition Status domain. 

##### Mapping to OMOP Vocabulary Concepts

The OMOP Ontology is an amalgamation of multiple standard and non-standard concepts that are normalized to an overarching OMOP concept. OMOP creates separate fields dedicated to the OMOP concept id, and to other supported terminologies.

##### Mapping Primary Cancer Diagnoses

mCODE and the OMOP CDM Oncology Extension differ in their representation of primary cancer diagnoses:

* mCODE aligns with EHRs which capture primary cancers as a problem or diagnosis list as ICD-10 or SNOMED-CT codes. The topography and histology characteristics of a tumor are represented as separate data elements within the [PrimaryCancerCondition](http://hl7.org/fhir/us/mcode/StructureDefinition-mcode-primary-cancer-condition.html) FHIR profile.
* The OMOP "base" CDM can accept both ICD-10-CM, SNOMED-CT, and ICD-O-3 for representing conditions.
* The OMOP Oncology extension Cancer Diagnosis ontology only aligns with ICD-O-3 and combines both the topography and histology as one OMOP concept and record in the `CONDITION_OCCURENCE` table.

Given these difference, multiple logical conversions might be required to convert an mCODE PrimaryCancerCondition FHIR instance to the OMOP Oncology Extension representation for Cancer Diagnosis. 

The logic for an example conversion is illustrated in the diagram below:

<object data="mCODE-OMOP-PrimaryCancerConditionVocab.svg" type="image/svg+xml"></object>
<br/>

##### Mapping to OMOP Cancer Modifiers

**TBD**
