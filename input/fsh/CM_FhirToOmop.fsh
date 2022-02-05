// Concept maps

Instance: condition-verification-status
InstanceOf: ConceptMap
Usage: #definition
* url = "http://hl7.org/fhir/ConceptMap/condition-ver-status"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:7bb077cb-df16-4c75-b342-d770505aca25"
* version = "4.0.1"
* name = "VerificationStatus"
* title = "Verification Status"
* status = #draft
* experimental = true
* date = "2021-12-16"
* publisher = "HL7, Inc"
* contact.name = "FHIR-OMOP Oncology Team (example)"
* contact.telecom.system = #url
* contact.telecom.value = "http://hl7.org/fhir"
* description = "A mapping between the FHIR and OMOP Condition Status Code systems"
* useContext.code = http://terminology.hl7.org/CodeSystem/usage-context-type#focus
* useContext.valueCodeableConcept.text = "for FHIR to OMOP alignment"
* jurisdiction = urn:iso:std:iso:3166#US
* purpose = "To help implementers map from HL7 FHIR to OMOP Vocabulary"
* copyright = "Creative Commons 0"
* sourceUri = "http://hl7.org/fhir/ValueSet/condition-ver-status"
* targetUri = "http://hl7.ohdsi.org/omop/ValueSet/condition-status"
* group.source = "http://terminology.hl7.org/CodeSystem/condition-ver-status"
* group.target = "http://hl7.ohdsi.org/omop/CodeSystem/condition-status"
* group.element[0].code = #confirmed
* group.element[=].display = "Confirmed"
* group.element[=].target.code = #32893
* group.element[=].target.display = "Confirmed diagnosis"
* group.element[=].target.equivalence = #equal
* group.element[+].code = #differential
* group.element[=].display = "Differential"
* group.element[=].target.code = #32899
* group.element[=].target.display = "Preliminary diagnosis"
* group.element[=].target.equivalence = #equivalent
* group.element[=].target.comment = "Approximation mapping"
* group.unmapped.mode = #fixed
* group.unmapped.code = #refuted
* group.unmapped.display = "refuted"

Instance: us-core-birthsex
InstanceOf: ConceptMap
Usage: #definition
* url = "http://hl7.org/fhir/ConceptMap/fhir-us-core-birthsex-to-omop"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:7bb077cb-df16-4c75-b342-d770505aca25"
* version = "4.0.1"
* name = "Birth Sex"
* title = "US Core Birth Sex"
* status = #draft
* experimental = true
* date = "2022-02-04"
* publisher = "HL7, Inc"
* contact.name = "FHIR-OMOP Oncology Team (example)"
* contact.telecom.system = #url
* contact.telecom.value = "http://hl7.org/fhir"
* description = "A mapping between the FHIR US Core Birthsex to OMOP concepts"
* useContext.code = http://terminology.hl7.org/CodeSystem/usage-context-type#focus
* useContext.valueCodeableConcept.text = "for FHIR to OMOP alignment"
* jurisdiction = urn:iso:std:iso:3166#US
* purpose = "To help implementers map from HL7 FHIR to OMOP Vocabulary"
* copyright = "Creative Commons 0"
* sourceUri = "http://hl7.org/fhir/us/core/ValueSet/birthsex"
* targetUri = "http://hl7.ohdsi.org/omop/ValueSet/omop-birthsex"
* group.source = "http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender"
* group.target = "http://hl7.ohdsi.org/omop/CodeSystem/omop/Gender"
* group.element[0].code = #M
* group.element[=].display = "Male"
* group.element[=].target.code = #8507
* group.element[=].target.display = "Male"
* group.element[=].target.equivalence = #equal
* group.element[+].code = #F
* group.element[=].display = "Female"
* group.element[=].target.code = #8532
* group.element[=].target.display = "Female"
* group.element[=].target.equivalence = #equal
* group.element[=].target.comment = "Equal mapping"
* group.element[+].code = #UNK
* group.element[=].display = "Unknown"
* group.element[=].target.code = #4129922
* group.element[=].target.display = "Unknown"
* group.element[=].target.equivalence = #equal
* group.element[=].target.comment = "Equal mapping"
