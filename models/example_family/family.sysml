package Family {
	doc
	/* This package defines a family */
	
	//Import packages
	private import ScalarValues::Natural;
	private import ScalarValues::Boolean;
	private import ISQ::mass;
	private import SI::*;
	
	//use cases definition
	use case def 'Agree on adoption' {
		subject judge : Person[1];
		actor woman;
		actor man;
		actor adoptiveParent_1;
		actor adoptiveParent_2;
		objective {
			doc
			/*Ensure that the parties involved agree on the legal terms
			 * of the adoption certificate and assert the certificate.
			 * first a judge will ensure both adoptive parents abide by the law
			 * secondly the certificate will be asserted and issued.
			 */
		}
	}
	
	//attribute definitions
	attribute def SoundWaveMaxRange;
	attribute def SoundWaveMinRange;
	attribute def Name;
	
	//Items definitions.
	//A SoundWaveMessage is the most general type of Message used in this example. 
	item def SoundWaveMessage;
	item def ApplicableLaw :> SoundWaveMessage;
	item def Agreement :> SoundWaveMessage;
	item def AssertCertificate :> SoundWaveMessage;
	
	//parts definitions
	part def Person{
		doc 
		/* Person is the most generic part representing people */
		attribute name : Name;
		attribute age : Natural;
		attribute weight :> mass;
		attribute isAdult : Boolean;
		port verbalExchange : VerbalExchange; 
		//Person only respond to inquiries in awakake state.
		state personStates {
			entry; then asleep;
			state asleep;
			transition asleep_to_awake
				first asleep
				accept after 8[h]
				then awake;
			state awake {
				do action respondToInquiry {
					doc /*
					 * the action is triggered by any SoundWaveMessage, processes it through a called action and sends a response.
					 * the receival and sending of messages is done through the defined ports of an adult :> Person.
					 * This reults in everybody responding to everything. To avoid this, the message shall include an adressee.
					 */
					//accept incomingMessage : SoundWaveMessage via adult.verbalExchange.verbalReceiver;
					action triggerResponse accept incomingInquiry : SoundWaveMessage via adult.verbalExchange.verbalReceiver;
					action processMessage : ProcessMessage { in incomingMessage = triggerResponse.incomingInquiry; out outgoingMessage;}
					//send serializeOutputMessage.OutgoingMessage via adult.verbalExchange.verbalEmitter; 	
					action sendResponse send processMessage.outgoingMessage via adult.verbalExchange.verbalEmitter; 
				}
			}
			transition awake_to_asleep
				first awake
				accept after 16[h]
				then asleep;
		}		
	}
	
	part def Administrative_Document;	
	
	//ports definition with nested ports
	port def VerbalInteraction {
		attribute soundWaveMinRange : SoundWaveMinRange;
		attribute soundWaveMaxRange : SoundWaveMaxRange;
		out soundWave : SoundWaveMessage;
	}
	port def VerbalExchange {
		port verbalEmitter : VerbalInteraction;
		port verbalReceiver : ~VerbalInteraction;
	}
	
	//Interface definition, being a conection between two ports
	interface def VerbalCommunication {
		end communicationPartnerA : VerbalExchange;
		end communicationPartnerB : ~VerbalExchange;
	}
	
	// connections definition. A connection is a spezialisation of a part and a LinkObject(KerML) and therefore has structure. Here a Child has structure and a connection.
	// the child can have two or more timeslices.
	// two snapshots define the birth and death of child.
	connection def Child :> Person {
		end mother : Person[1];
		end father : Person[1];
		snapshot birth;
		timeslice not_adopted;
		timeslice adopted[1..*] ordered;
		first not_adopted then adopted;
		snapshot death = done;
	}
	// the connection can alternatively be modeled containing the part.
	// connection def ChildConnection {
	//	end Mother : Person[1];
	//	end Father : Person[1];
	//  part Child : Person[1];
	//}
	
	// the parenthood certificate includes both parents and the certified child. 
	// Yet the parents do not have to be the father and/or the mother of the child
	// A parenthood certificate only exists when a child is adopted.
	connection def Adoption_Certificate :> Administrative_Document {
		end parent1 : Person[1];
		end parent2 : Person[1];
		end certifiedChild : Child[1];
		timeslice adopted[1]{
			snapshot certificate_valid_from = start;
		}
	}
	// action definition
	action def ProcessMessage {
		doc /*
		 * parses an incoming message, processes it, serializes it and provides an outgoing response
		 */
		in incomingMessage;
		out outgoingMessage;
		//bind this.in with internal first action.in
		bind incomingMessage = parseIncomingMessage.incomingMessage;
		action parseIncomingMessage : ParseMessage { in incomingMessage; out parsedIncomingMessage;}
		//pass through parameteres with flow
		flow from parseIncomingMessage.parsedIncomingMessage to processResponse.parsedIncomingMessage;
		then action processResponse : Think { in parsedIncomingMessage; out parsedOutgoingMessage;}
		flow from processResponse.parsedOutgoingMessage to serializeOutputMessage.parsedOutgoingMessage;
		then action serializeOutputMessage : SerializeMessage { in parsedOutgoingMessage; out outgoingMessage;}
		//bind from the last internal action.out to this.out
		bind serializeOutputMessage.outgoingMessage = outgoingMessage;
	}
	action def ParseMessage {in incommingMessage : SoundWaveMessage; out parsedIncommingMessage;}
	action def Think { in parsedIncomingMessage; out parsedOutgoingMessage;}
	action def SerializeMessage { in parsedOutgoingMessage; out OutgoingMessage;}
	
	//constraints definition
	constraint minimumAgeForAdoptiveParenthood {
		attribute adoptingPartyAge : Natural;
		adoptingPartyAge >= 18
	}
	
	//requirements definition
	requirement def LegalAdoptionParenthood {
		doc
		/* the age of a legal adoptive parent must be more than 18 years */
		attribute parentAge : Natural;
		require minimumAgeForAdoptiveParenthood {
			parentAge = adoptingPartyAge;
		}
	}
	//Interaction for the defined use case
	occurrence def AdoptionCertification {
		part :>> socialService;
		part :>> judge;
		part :>> adoptiveParent_1;
		part :>> adoptiveParent_2;
		//interaction of the certification process with sequence and defined ports
		message Statement1 of applicableLaw : ApplicableLaw from judge.statementOfLaw to adoptiveParent_1.informationOfLaw;
		then message agreementParent1 of agreement : Agreement from adoptiveParent_1.acknowledgmentOfLaw to judge.acknowledgmentConfirmation;
		then message Statement2 of ApplicableLaw : ApplicableLaw from judge.statementOfLaw to adoptiveParent_2.informationOfLaw;
		then message agreementParent2 of agreement : Agreement from adoptiveParent_2.acknowledgmentOfLaw to judge.acknowledgmentConfirmation;
		then message Assertion of assertCertificate : AssertCertificate from judge.assertionOfCertificate to adoptiveParent_1.receivalOfCertificate;
		then message Adoption of assertCertificate : AssertCertificate from judge.assertionOfCertificate to socialService.acknowledgmentOfAdoption;
	}
	
	//Parts
	// Multiplicity [1] is default, but it is here displayed to emphasize the multiplicity.
	part adult[*] : Person {
		:>> isAdult = true;
		event occurrence informationOfLaw;
		then event occurrence acknowledgmentOfLaw;
		then event occurrence receivalOfCertificate;
	}
	part administrative_document : Administrative_Document;
	part judge[1] :> adult {
		event occurrence statementOfLaw;
		then event occurrence acknowledgmentConfirmation;
		then event occurrence assertionOfCertificate;
	}
	part woman[1] :> adult;
	part man[1] :> adult;
	part adoptiveParent_1[1] :> adult;
	part adoptiveParent_2[1] :> adult;
	part socialService :> adult {
		event occurrence acknowledgmentOfAdoption;
	}
	
	//Connectors are also structural elements. In this case the connector is itself a child.
	//Reality being, that a Child consitutes a connection between two persons.
	connection child : Child {
		end mother ::> woman[1]; 
		end father ::> man[1];
	}
	//Interfaces connect by-directional communication and redefine the ends of the interface definition features
	interface verbalAdultCommunicationActionWoman : VerbalCommunication
		connect communicationPartnerA ::> woman.verbalExchange to communicationPartnerB ::> man.verbalExchange;
	interface verbalAdultCommunicationActionMan : VerbalCommunication
		connect communicationPartnerA ::> man.verbalExchange to communicationPartnerB ::> woman.verbalExchange;
	interface verbalParentingCommunicationActionWoman : VerbalCommunication
		connect communicationPartnerA ::> woman.verbalExchange to communicationPartnerB ::> child.verbalExchange;
	
	//three possible variants of cerificates. Depending on the variant there will be up to five persons in the package.
	variation part adoption_certificate : Adoption_Certificate{
		variant connection adoption_certificate_TypeB1 : Adoption_Certificate 
		connect (parent1 ::> woman[1], adoptiveParent_1 ::> adult[1], certifiedChild ::> child[1]);
		variant connection adoption_certificate_TypeB2 : Adoption_Certificate 
		connect (parent1 ::> man[1], adoptiveParent_1 ::> adult[1], certifiedChild ::> child[1]);
		variant connection adoption_certificate_TypeC : Adoption_Certificate 
		connect (parent1 ::> adoptiveParent_1[1], parent2 ::> adoptiveParent_2[1], certifiedChild ::> child[1]);
	} 
		
	//requirements
	requirement validAdoptionParenthood : LegalAdoptionParenthood {
		doc
		/*the age of both adoptive parents in a parenthood certificate Type C shall be more than 18 years */
		
		subject adoption_certificate_TypeC;
		attribute :>> adoptiveParent_1.age = parentAge;
		attribute :>> adoptiveParent_2.age = parentAge;
	}
}