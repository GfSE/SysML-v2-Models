package Drone_BaseArchitecture {
    part def Drone;
}

package Drone_StakeholderRequirements {    
    requirement <'REQ-42'> longDistance {
        doc /* The drone shall have a sufficient range 
             * to operate at a distance of 5 km from the 
             * operator's location.
            */  
        subject drone : Drone_BaseArchitecture::Drone;
    }
}

package Drone_SystemArchitecture {
    
    part drone : Drone_BaseArchitecture::Drone {
        attribute totalMass = 750;
        part battery {
            attribute capacity = 6000;
        }        
    }
    satisfy Drone_StakeholderRequirements::longDistance by drone;  
}

package Drone_SystemRequirements {
    
    import RequirementDerivation::*;
    
    requirement <'REQ-9942'> totalMass {
        subject drone :>> Drone_SystemArchitecture::drone;        
        assert constraint {
            drone.totalMass <= 750
        }
    }
    requirement <'REQ-9943'> battery {
        subject battery :>> Drone_SystemArchitecture::drone.battery;
    }
    requirement <'REQ-9944'> maxCapacity {
        subject battery :>> Drone_SystemArchitecture::drone.battery;
        assert constraint {
            battery.capacity >= 6000
        }
    }
    #derivation connection {
        end #original ::> Drone_StakeholderRequirements::longDistance;
        end #derive ::> Drone_SystemRequirements::totalMass;
        end #derive ::> Drone_SystemRequirements::maxCapacity;
    }
}

