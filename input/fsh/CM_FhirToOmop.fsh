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


Instance: coc-store-to-us-core-birthsex
InstanceOf: ConceptMap
Usage: #definition
* url = "http://hl7.org/fhir/ConceptMap/store-sex-to-fhir-us-core-birthsex"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:7bb077cb-df16-4c75-b342-d770505aca25"
* version = "4.0.1"
* name = "STORE to US Core BirthSex"
* title = "STORE to US Core BirthSex"
* status = #draft
* experimental = true
* date = "2022-07-21"
* publisher = "HL7, Inc"
* contact.name = "mCODE Team (example)"
* contact.telecom.system = #url
* contact.telecom.value = "http://hl7.org/fhir"
* description = "A mapping between the Commission on Cancer STORE to FHIR US Core Birthsex"
* useContext.code = http://terminology.hl7.org/CodeSystem/usage-context-type#focus
* useContext.valueCodeableConcept.text = "for CoC STORE to mCODE alignment"
* jurisdiction = urn:iso:std:iso:3166#US
* purpose = "To help implementers map concepts to HL7 FHIR"
* copyright = "Creative Commons 0"
* sourceUri = "https://www.facs.org/quality-programs/cancer-programs/commission-on-cancer/CodeSystem/Sex"
* targetUri = "http://hl7.org/fhir/us/core/ValueSet/birthsex"
* group[0].source = "https://www.facs.org/quality-programs/cancer-programs/commission-on-cancer/CodeSystem/Sex"
* group[0].target = "http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender"
* group[0].element[0].code = #1
* group[0].element[=].display = "Male"
* group[0].element[=].target.code = #M
* group[0].element[=].target.display = "Male"
* group[0].element[=].target.equivalence = #equal
* group[0].element[+].code = #2
* group[0].element[=].display = "Female"
* group[0].element[=].target.code = #F
* group[0].element[=].target.display = "Female"
* group[0].element[=].target.equivalence = #equal
* group[0].element[=].target.comment = "Equal mapping"
* group[+].source = "https://www.facs.org/quality-programs/cancer-programs/commission-on-cancer/CodeSystem/Sex"
* group[=].target = "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
* group[=].element[0].code = #3
* group[=].element[0].display = "Other (intersex, disorders of sexual development/DSD)"
* group[=].element[0].target.code = #OTH
* group[=].element[0].target.display = "Other"
* group[=].element[0].target.equivalence = #equivalent
* group[=].element[0].target.comment = "Approximate mapping"
* group[=].element[+].code = #4
* group[=].element[=].display = "Transsexual, NOS"
* group[=].element[=].target.code = #OTH
* group[=].element[=].target.display = "Other"
* group[=].element[=].target.equivalence = #inexact
* group[=].element[=].target.comment = "Approximate mapping"
* group[=].element[+].code = #5
* group[=].element[=].display = "Transsexual, natal male"
* group[=].element[=].target.code = #OTH
* group[=].element[=].target.display = "Other"
* group[=].element[=].target.equivalence = #inexact
* group[=].element[=].target.comment = "Approximate mapping"
* group[=].element[+].code = #6
* group[=].element[=].display = "Transsexual, natal female"
* group[=].element[=].target.code = #OTH
* group[=].element[=].target.display = "Other"
* group[=].element[=].target.equivalence = #inexact
* group[=].element[=].target.comment = "Approximate mapping"
* group[=].element[+].code = #9
* group[=].element[=].display = "Not stated in patient record"
* group[=].element[=].target.code = #UNK
* group[=].element[=].target.display = "Unknown"
* group[=].element[=].target.equivalence = #inexact
* group[=].element[=].target.comment = "Approximate mapping"
