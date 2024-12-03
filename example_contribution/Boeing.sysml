package Boeing {

	enum def PressModel {
		enum heim;
		enum minster;
		}

	abstract  part def IndustrialPress {
		attribute id : ScalarValues::String;
		attribute name : ScalarValues::String;
		attribute model :  PressModel;
		attribute tonnage: ScalarValues::Real;
		ref item operator : PressTechnician;
		}

	part def  StraightSidePress :> IndustrialPress {
                         	attribute crank:  ScalarValues::Integer;
                             }

	individual part def press_heim_4 :>  StraightSidePress {
	       :>> id = "heim_4";
	       :>> name = "Heim S2-200-78 #4";
	       :>> model = PressModel::heim ;
	       :>> tonnage = 200;

 	       timeslice novemberOperation {
		ref individual item :>> operator : Alice ;
		}
	}

	individual part def press_minter_8 :>  StraightSidePress {
	       :>> id = "minster_8";
	       :>> name = "Minster E2-250-60-48 #8";
	       :>> model =  PressModel::minster;
	       :>> tonnage = 250;

 	       timeslice novemberOperation {
		ref individual item :>> operator : Bob ;
		}
	}

	individual part def press_minter_12 :>  StraightSidePress {
	       :>> id = "minster_12";
	       :>> name = "Minster 40-10 #12";
	       :>> model =  PressModel::minster;
	       :>> tonnage = 300;

 	       timeslice novemberOperation {
		ref individual item :>> operator : Charlie ;
		}
	}




              abstract item def Person {
		attribute name : ScalarValues::String;				
	}

	item def Technician :> Person {
	     	attribute competencyYear :  ScalarValues::Integer;
		attribute competencyType :  ScalarValues::String;
		}

	item def PressTechnician :> Technician {
	     	:>> competencyType = "Press"; 
		}

	individual item def Alice :> PressTechnician {
                      	:>> name = "Alice" ;
		:>> competencyYear = 3 ;
                   	}

	individual item def Bob :> PressTechnician {
                      	:>> name = "Bob" ;
		:>> competencyYear = 5 ;
                   	}

	individual item def Charlie :> PressTechnician {
                      	:>> name = "Charlie" ;
		:>> competencyYear = 7 ;
                   	}



}
