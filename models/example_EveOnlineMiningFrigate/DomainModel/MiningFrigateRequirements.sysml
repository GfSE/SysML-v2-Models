package MiningFrigateRequirements {

    private import Domain::*;
    private import ScalarValues::*;
    private import MiningFrigateRequirementsDef::*;
    private import MiningFrigate::*;

    //Mining Frigate Requirement assertions for the Mining Frigates
    requirement <MFRQF01_1> oreExtractionEfficiencyRequirementLowSec : OreExtractionEfficiencyRequirement {
    	subject miningFrigate : MiningFrigate;
    	attribute :>> miningRateLS = miningFrigate.miningRate ;
    }
    
    requirement <MFRQF02_1> cargoCapacityRequirementLowSec : CargoCapacityRequirement {
    	subject miningFrigate : MiningFrigate;
        attribute :>> cargoCapacity = miningFrigate.cargoCapacity ;
    }

    requirement <MFRQF03_1> survivabilityRequirementLowSec : SurvivabilityRequirement {
    	subject miningFrigate : MiningFrigate;
        attribute :>> shieldStrengthLS = miningFrigate.shieldModule.shieldStrength ;
    }

    requirement <MFRQF04_1> droneOperationsRequirementLowSec : DroneOperationsRequirement {
        subject miningFrigate : MiningFrigate;
        attribute :>> droneCapacity = miningFrigate.droneCapacity ;
    }

    requirement <MFRQF05_1> threatDetectionRequirementLowSec : ThreatDetectionRequirement {
        subject miningFrigate : MiningFrigate;
        attribute :>> threatDetectionRange = miningFrigate.threatDetectionRange ;
    }

    requirement <MFRQF06_1> travelEfficiencyRequirementLowSec : TravelEfficiencyRequirement {
        subject miningFrigate : MiningFrigate;
        attribute :>> warpSpeed = miningFrigate.warpSpeed ;
        attribute :>> alignTime = miningFrigate.alignTime ;
    }

    requirement <MFRQF07_1> miningTargetRequirementLowSec : MiningTargetRequirement {
        subject miningFrigate : MiningFrigate;
        attribute :>> lockedTargets = miningFrigate.lockedTargets ;
    }

    requirement <MFRQF08_1> dockingRequirementLowSec : DockingRequirement {
        subject miningFrigate : MiningFrigate;
        attribute :>> dockingTime = miningFrigate.dockingTime ;
    }
    
   	//Stakeholder Requirement assertions for the Mining Corporation
   	requirement <MFRQC01_1> fleetCoordinationRequirementLowSec : FleetCoordinationRequirement {
   		subject fleetCommander : PilotPod;
   		attribute :>> fleetSize = fleetCommander.fleetSize ;
   	}   
	
	requirement <MFRQC02_1> oreCompressionRequirement : OreCompressionRequirement {
   		subject rorqual : Rorqual;
   		attribute :>> compressionFactor = rorqual.oreCompressionUnit.compressionFactor ;
   	}   
}