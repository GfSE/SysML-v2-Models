package causeEffect {
	
	private import Domain::MiningCorporation::miningFrigate;
	private import CauseAndEffect::*;
    private import CausationConnections::*;

	 //The cause-effect relationships
	#causation connect miningFrigate.MiningRateIncreases to miningFrigate.OreYieldIncreases;
	#causation connect miningFrigate.CargoCapacityIncreases to miningFrigate.DowntimeReduces;
	#causation connect miningFrigate.ShieldStrengthIncreases to miningFrigate.SurvivabilityEnhances;
	#causation connect miningFrigate.ThreatDetectionImproves to miningFrigate.ThreatResponseImproves;
	#causation connect miningFrigate.DroneOperationsImprove to miningFrigate.OperationalEfficiencyIncreases;
	#causation connect miningFrigate.WarpSpeedIncreases to miningFrigate.DowntimeReduces;
	#causation connect miningFrigate.FleetCoordinationImproves to miningFrigate.OperationalEfficiencyIncreases;
	
	#multicausation connection {
	    end #cause ::> miningFrigate.OreYieldIncreases;
	    end #cause ::> miningFrigate.DowntimeReduces;
	    end #effect ::> miningFrigate.OreExtractionEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> miningFrigate.SurvivabilityEnhances;
	    end #cause ::> miningFrigate.ThreatResponseImproves;
	    end #effect ::> miningFrigate.OperationalEfficiencyIncreases;
	}
	
	#multicausation connection {
	    end #cause ::> miningFrigate.OperationalEfficiencyIncreases;
	    end #cause ::> miningFrigate.OreExtractionEfficiencyIncreases;
	    end #effect ::> miningFrigate.ProfitabilityMaximizes;
	}	
}