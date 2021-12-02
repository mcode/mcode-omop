
This FHIR implementation guide (IG) is a mapping analysis from the Minimum Common Oncology Data Elements (mCODE) and the Observational Medical Outcomes Partnership (OMOP) Common Data Model (CDM) oncology data elements. 

## Background

The [Common Data Model Harmonization (CDMH) FHIR IG](https://build.fhir.org/ig/HL7/cdmh/) aims to develop a common data architecture to create user driven queries of the following four common data model (CDMs) of four networks (Sentinel, i2b2/ACT, OMOP and PCORnet). There are limitations in its scope are insufficient for the oncology use case. These include:

* a unidirectional mapping from OMOP to FHIR; our analysis is from FHIR to OMOP
* a structural mapping based on OMOP v5.2 and is outdated in certain fields.
* insufficient guidance of semantic harmonization between the OMOP Ontology and FHIR.

## Scope and Assumptions

* Initial mappings will be unidirectional from mCODE to OMOP Oncology CDM. OMOP Oncology to mCODE is currently out of scope and will be considered in the future.
* Only the minimal and required mCODE data elements will be mapped to OMOP. FHIR metadata or supportive data elements that are not relevant to OMOP will be omitted. 

### Scope

* The following data model versions will be used in the analysis:

  * [OMOP CDM v5.4](https://ohdsi.github.io/CommonDataModel/cdm54.html)
  * [OMOP Oncology Extension](https://github.com/OHDSI/OncologyWG/wiki/Cancer-Models-Representation)
  * [mCODE FHIR IG Standard for Trial Use #2 (STU2)](http://build.fhir.org/ig/HL7/fhir-mCODE-ig/branches/master/index.html)

## Systems, Actors

### Systems

* Electronic Health Record (EHR)
* FHIR Server
* OMOP Data Store
* Research Portals

### Actors

* Providers
* Researchers

## Data Flow

<object data="mCODE-to-OMOP.svg" type="image/svg+xml"></object>
<br/>
