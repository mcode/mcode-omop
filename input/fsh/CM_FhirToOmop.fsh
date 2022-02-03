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
