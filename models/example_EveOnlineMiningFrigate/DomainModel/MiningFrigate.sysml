 package MiningFrigate {
 
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
	private import OperationalUseCaseActions::*;
	private import Domain::*;
	 
	part def MiningFrigate :> Spaceship {

        attribute miningRate : Real;          // Volume of ore mined per second (m³/s)
        attribute droneCapacity : Integer; // Number, the maximum number of drones deployable (STRQ04)
        attribute threatDetectionRange : Real; // AU, the range for detecting threats (STRQ0)
        attribute fleetSize : Integer; // Number, the maximum size of a mining fleet the frigate can coordinate (STRQ09)
        
        // Consolidated Non-Configurable System*
        part coreSystem: CoreSystem; 
        
        //parts declaration
        part miningLaser: MiningLaser [1..2];  // Configurable mining module
        part shieldModule: ShieldModule;       // Configurable shield generator
        part propulsionModule: PropulsionModule; // Configurable propulsion system
        part sensorModule: SensorModule;       // Configurable sensor array
        part oreHoldExpander: OreHoldExpander [0..2]; // Optional cargo expander module
        part capacitorBooster: CapacitorBooster [0..1]; // Configurable capacitor booster
        part defenseTurret: DefenseTurret [0..*]; // Optional defense modules
        ref part cargo : CargoContainer [0..*];
        ref part charge : Power;
        ref part drone : Drone [0..5];
        
        port controlPort : ~PodPort;
        port dockingPort : ~DockingPort;
        port DefensePort : ~ThreatPort;
        port asteroidOrePort : ~AsteroidOrePort;
        port droneControlPort: ~DroneControllerPort;
        
        //actions declaration
	    action activateMiningLaser : ActivateMiningLaser {
	    }  
           	
	}
	// State Definition for the Mining Frigate
    state miningFrigatesStates {
    	in miningFrigates : MiningFrigate;
        
    	entry;
    	then Docked; //boarding a ship is not modeled.

	 	state Packaged {
	 		doc /* The mining frigate is packaged inside a station and can be cargoed. */
	 	}	 	
	 	state Parked {
	 		doc /* The mining frigate is parked inside a station, but not boarded by a pod. */
	 	}	 	
	 	state Docked {
	    	doc /* The mining frigate is inside a station, available for refitting, resupply, or cargo transfer. */
	    }
	    state InGrid {
	        doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
	    }
	 	state OnWarp {
	        doc /* The mining frigate is in warp, traveling between locations. */
	    }
 		
 		transition docked_to_inGrid
	    	first Docked
	    	accept pilotPodUndockCommand : ShipCommand via miningFrigates.controlPort
	    	do action undockFromStation : UndockFromStation {in undockCommand = pilotPodUndockCommand;}
	    	then InGrid;  		
	        
	    transition inGrid_to_docked
	    	first InGrid
	    	accept pilotPodDockCommand : ShipCommand via miningFrigates.controlPort
	    	do action dockToStation : DockToStation {in dockCommand = pilotPodDockCommand;}
	    	then Docked;
	        
		transition inGrid_to_onWarp
	    	first InGrid
	    	accept warpCommand : ShipCommand via miningFrigates.controlPort
	    	do action executeWarpDrive : ExecuteWarpDrive
	    	then OnWarp;
	
	    transition onWarp_to_inGrid
	    	first OnWarp
	    	accept when miningFrigates.warpBubbleEnd
	    	then InGrid;     	
   		
   		//Internal transitions
   	    transition unloadCargo 
	    	first Docked
	    	accept unloadCommand : ShipCommand via miningFrigates.controlPort
	    	do action transferOre : TransferOre
	    	then Docked;
	    
	    transition cycleMining 
	    	first InGrid
	    	accept miningCommand : ShipCommand via miningFrigates.controlPort
	    	do action activateMiningLaser : ActivateMiningLaser
	    	then InGrid;
	    	
		transition scanThreats
            first InGrid
            accept scanCommand : ShipCommand via miningFrigates.controlPort
            do action scanForThreats : ScanForThreats
            then InGrid;

        transition prioritizeThreat
            first InGrid
            accept threatSignature : ScanSignature via miningFrigates.controlPort
            do action prioritizeThreats : PrioritizeThreats
            then InGrid;

        transition deployDrones
            first InGrid
            accept droneCommand : ShipCommand via miningFrigates.controlPort
            do action selectDronesForDeployment : SelectDronesForDeployment
            then InGrid;

        transition navigation
            first InGrid
            accept destinationCommand : ShipCommand via miningFrigates.controlPort
            do action acceptDestination : AcceptDestination
            then InGrid;

        transition coursePlot
            first InGrid
            accept courseCommand : ShipCommand via miningFrigates.controlPort
            do action plotOptimalCourse : PlotOptimalCourse
            then InGrid;

        transition engagePropulsion
            first InGrid
            accept propulsionCommand : ShipCommand via miningFrigates.controlPort
            do action engagePropulsion : EngagePropulsion
            then InGrid;

        transition adjustCourse
            first InGrid
            accept courseCorrection : ShipCommand via miningFrigates.controlPort
            do action monitorAndAdjustCourse : MonitorAndAdjustCourse
            then InGrid;

        transition cargoVerification
            first Docked
            accept warehouseStatusCommand : StationCommand via miningFrigates.controlPort
            do action verifyCargoTransfer : VerifyCargoTransfer
            then Docked;

        transition detectThreat
            first InGrid
            accept threatScanCommand : ShipCommand via miningFrigates.controlPort
            do action detectThreat : DetectThreat
            then InGrid;

        transition engageDefense
            first InGrid
            accept defenseCommand : ShipCommand via miningFrigates.controlPort
            do action engageDefenses : EngageDefenses
            then InGrid;

        transition resupply
            first Docked
            accept shipStatusCommand : ShipCommand via miningFrigates.controlPort
            do action verifyResupply : VerifyResupply
            then Docked;
	}
    
     // Definitions for individual parts of the mining frigate
    part def SpaceshipModule {
    	attribute mass : Real;
    	attribute powerGrid : Integer;
    	attribute capacitorSurge : Integer;
    }
    

    // **Consolidated Core System (Non-Configurable)**
    part def CoreSystem {
        
    }

    // **Configurable Modules**
    part def MiningLaser {
        attribute miningPower : Real; // Mining power of the laser
        attribute cycleTime : Real; // Time per mining cycle
    }

    part def ShieldModule {
        attribute shieldStrength : Real; // Hitpoints of the shield
        attribute rechargeRate : Real; // Recharge rate of the shield
    }

    part def PropulsionModule {
        attribute maxVelocity : Real; // Speed of the ship
        attribute warpSpeed : Real; // Warp speed in AU/s
    }

    part def SensorModule {
        attribute scanResolution : Real; // Locking speed
        attribute targetingRange : Real; // Max target range
    }

    part def OreHoldExpander {
        attribute capacityBonus : Real; // Increase in cargo capacity
    }

    part def CapacitorBooster {
        attribute capacitorRecharge : Real; // Boost to capacitor energy
    }

    part def DefenseTurret {
        attribute firepower : Real; // DPS output
        attribute optimalRange : Real; // Optimal engagement range
    }

    part def DroneBay {
        attribute maxDrones : Integer; // Maximum drones stored
    }

    part def NavigationModule {
        attribute agilityBonus : Real; // Improves ship align time
        attribute warpSpeedBonus : Real; // Boost to warp speed
    } 
}	    