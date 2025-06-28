package causeEffect {
	
	private import Domain::*;
	private import MiningFrigate::*;
	private import CauseAndEffect::*;

	//The cause-effect relationships
	//This section is not correctly parsed and needs further corrections
	#causation connect Domain::domain.miningCorporation.miningFrigate.miningRateIncreases to Domain::domain.asteroid.oreYieldIncreases;
	#causation connect Domain::domain.miningCorporation.miningFrigate.cargoCapacityIncreases to Domain::domain.miningCorporation.fleet.downtimeReduces;
	#causation connect Domain::domain.miningCorporation.miningFrigate.shieldStrengthIncreases to Domain::domain.miningCorporation.fleet.survivabilityEnhances;
	#causation connect Domain::domain.miningCorporation.miningFrigate.threatDetectionImproves to Domain::domain.miningCorporation.fleet.threatResponseImproves;
	#causation connect Domain::domain.miningCorporation.miningFrigate.droneOperationsImprove to Domain::domain.miningCorporation.fleet.operationalEfficiencyIncreases;
	#causation connect Domain::domain.miningCorporation.miningFrigate.warpSpeedIncreases to Domain::domain.miningCorporation.fleet.downtimeReduces;
	#causation connect Domain::domain.miningCorporation.fleet.fleetCoordinationImproves to Domain::domain.miningCorporation.fleet.operationalEfficiencyIncreases;
	
	#multicausation connection {
	    end #cause ::> Domain::domain.asteroid.oreYieldIncreases;
	    end #cause ::> Domain::domain.miningCorporation.fleet.downtimeReduces;
	    end #effect ::> Domain::domain.miningCorporation.fleet.oreExtractionEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> Domain::domain.miningCorporation.fleet.survivabilityEnhances;
	    end #cause ::> Domain::domain.miningCorporation.fleet.threatResponseImproves;
	    end #effect ::> Domain::domain.miningCorporation.fleet.operationalEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> Domain::domain.miningCorporation.fleet.operationalEfficiencyIncreases;
	    end #cause ::> Domain::domain.miningCorporation.fleet.oreExtractionEfficiencyIncreases;
	    end #effect ::> Domain::domain.miningCorporation.fleet.profitabilityMaximizes;
	}	
}