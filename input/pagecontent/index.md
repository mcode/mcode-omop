
This FHIR implementation guide (IG) is a mapping analysis from the Minimum Common Oncology Data Elements (mCODE) and the Observational Medical Outcomes Partnership (OMOP) Common Data Model (CDM) oncology data elements. 

### Background

The [Common Data Model Harmonization (CDMH) FHIR IG](https://build.fhir.org/ig/HL7/cdmh/) aims to develop a common data architecture to create user driven queries of the following four common data model (CDMs) of four networks (Sentinel, i2b2/ACT, OMOP and PCORnet). There are limitations in its scope are insufficient for the oncology use case. These include:

* a unidirectional mapping from OMOP to FHIR; our analysis is from FHIR to OMOP
* a structural mapping based on OMOP v5.2 and is outdated in certain fields.
* insufficient guidance of semantic harmonization between the OMOP Ontology and FHIR.

### Scope and Assumptions

* Initial mappings will be unidirectional from mCODE to OMOP Oncology CDM. OMOP Oncology to mCODE is currently out of scope and will be considered in the future.
* Only the minimal and required mCODE data elements will be mapped to OMOP. FHIR metadata or supportive data elements that are not relevant to OMOP may be omitted. However significant gaps that apply to the either US Core or the FHIR base release will be shared with the HL7-OHDSI community if found during the analysis.

#### Scope

* The following data model versions will be used in the analysis:

  * [OMOP CDM v5.3](https://ohdsi.github.io/CommonDataModel/cdm53.html)
  * [OMOP Oncology Extension](https://github.com/OHDSI/OncologyWG/wiki/Cancer-Models-Representation)
  * [mCODE FHIR IG Standard for Trial Use #2 (STU2)](http://build.fhir.org/ig/HL7/fhir-mCODE-ig/branches/master/index.html)

### Actors and Systems

#### Actors

* Healthcare providers
* Researchers

#### Systems

* Electronic Health Record (EHR)
* FHIR Server
* OMOP Data Store
* Research Portals

### Data Flow

<object data="mCODE-to-OMOP-dataflow.svg" type="image/svg+xml"></object>
<br/>

### OMOP Common Data Model (CDM) Oncology Extension

The Cancer Diagnostic Model in the OMOP vocabulary is comprised of:

* Cancer diagnosis: a condition that is a combination of histology (morphology) and topography (anatomic site).
* Diagnostic schema: a group of cancer diagnoses with similar diagnostic features.
* Diagnostic modifiers: a set of diagnostic features that define a group of cancer diagnoses. These include stage, grade, laterality, genomic biomarkers, and other attributes.

[source: OHDSI - Cancer Models Representation](https://github.com/OHDSI/OncologyWG/wiki/Cancer-Models-Representation)

