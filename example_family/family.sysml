package Family {
	doc
	/* This package defines a family */
	
	//Import packages
	private import ScalarValues::Natural;
	private import ScalarValues::Boolean;
	private import ISQ::mass;
	
	//attribute definitions
	attribute def SoundWave;
	attribute def SoundWaveMaxRange;
	attribute def SoundWaveMinRange;
	
	//parts definitions
	part def Person{
		attribute age : Natural;
		attribute weight :> mass;
		attribute isAdult : Boolean;
		port verbalExchange : VerbalExchange;
	}
	part def Administrative_Document;	
	
	//ports definition with nested ports
	port def VerbalInteraction {
		attribute soundWaveMinRange : SoundWaveMinRange;
		attribute soundWaveMaxRange : SoundWaveMaxRange;
		out soundWave : SoundWave;
	}
	port def VerbalExchange {
		port VerbalEmitter : VerbalInteraction;
		port VerbalReceiver : ~VerbalInteraction;
	}
	
	//Interface definition, being a conection between two ports
	interface def VerbalCommunication {
		end communicationPartnerA : VerbalExchange;
		end communicationPartnerB : ~VerbalExchange;
	}
	
	//connections definition. A connection is a part and therefore has structure. Here a Child is a part and a connection.
	connection def Child :> Person {
		end Mother : Person[1];
		end Father : Person[1];
	}
	// the connection can alternatively be modeled containing the part.
	// connection def ChildConnection {
	//	end Mother : Person[1];
	//	end Father : Person[1];
	//  part Child : Person[1];
	//}
	
	connection def Parenthood_Certificate :> Administrative_Document {
		end parent1 : Person[1];
		end parent2 : Person[1];
	}
	
	//constraints definition
	constraint minimumAgeForAdoptiveParenthood {
		attribute partyAge : Natural;
		partyAge >= 18
	}
	
	//requirements definition
	requirement def LegalParenthood {
		doc
		/* the age of a legal parent must be more than 18 years */
		attribute parentAge : Natural;
		require minimumAgeForAdoptiveParenthood {
			parentAge = partyAge;
		}
	}
	
	//Parts
	part person[*] : Person;
	part administrative_document : Administrative_Document;
	part woman[1] :> person {
		:>> isAdult = true;
	}
	part man[1] :> person {
		:>> isAdult = true;
	}
	part adoptiveParent_1[1] :> person {
		:>> isAdult = true;
	}
	part adoptiveParent_2[1] :> person {
		:>> isAdult = true;
	}
	
	//Connectors are also structural elements. In this case the connector is itself a child.
	//Reality being, that a Child consitutes a connection between two persons.
	connection child : Child {
		end biological_mother ::> woman[1];
		end biological_father ::> man[1];
	}
	
	//Interfaces connect by-directional communication and redefine the ends of the interface definition features
	interface verbalAdultCommunicationActionWoman : VerbalCommunication
		connect communicationPartnerA ::> woman.verbalExchange to communicationPartnerB ::> man.verbalExchange;
	interface verbalAdultCommunicationActionMan : VerbalCommunication
		connect communicationPartnerA ::> man.verbalExchange to communicationPartnerB ::> woman.verbalExchange;
	interface verbalParentingCommunicationActionWoman : VerbalCommunication
		connect communicationPartnerA ::> woman.verbalExchange to communicationPartnerB ::> child.verbalExchange;
	
	//three possible variants of cerificates. Depending of the variant there will be up to five persons in the package.
	variation part parenthod_certificate : Parenthood_Certificate{
		variant connection parenthood_certificate_TypeA : Parenthood_Certificate 
		connect (parent1 ::> woman[1], parent2 ::> man[1]);
		variant connection parenthood_certificate_TypeB1 : Parenthood_Certificate 
		connect (parent1 ::> woman[1], adoptive_parent_1 ::> person[1]);
		variant connection parenthood_certificate_TypeB2 : Parenthood_Certificate 
		connect (parent1 ::> man[1], adoptive_parent_1 ::> person[1]);
		variant connection parenthood_certificate_TypeC : Parenthood_Certificate 
		connect (parent1 ::> adoptiveParent_1[1], parent2 ::> adoptiveParent_2[1]);
	} 
		
	//requirements
	requirement validParenthood : LegalParenthood {
		doc
		/*the age of both adoptive parents in a parenthood certificate Type C shall be more than 18 years */
		
		subject parenthod_certificate_TypeC;
		attribute :>> adoptiveParent_1.age = parentAge;
		attribute :>> adoptiveParent_2.age = parentAge;
	}
}