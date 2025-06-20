 package MiningFrigate {
 
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
	private import OperationalUseCaseActions::*;
	private import Domain::*;
    private import StakeholderConcerns::*;
	 
	part def MiningFrigate :> Domain::Spaceship {

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
        part warpCoreStabilizer: WarpCoreStabilizer [0..*]; // Optional defense modules
        ref part cargo : Domain::CargoContainer [0..*];
        ref part charge : Domain::Power;
        ref part drone : Domain::Drone [0..5];
        
        port controlPort : ~Domain::PodPort;
        port dockingPort : ~Domain::DockingPort;
        port defensePort : ~Domain::ThreatPort;
        port asteroidOrePort : ~Domain::AsteroidOrePort;
        port droneControlPort: ~Domain::DroneControllerPort;          	
	}
    part miningFrigate : MiningFrigate{
        // State Definition for the Mining Frigate
        state miningFrigatesStates {
            
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
                accept pilotPodUndockCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action undockFromStation : UndockFromStation {in undockCommand = pilotPodUndockCommandSig;}
                then InGrid;  		
                
            transition inGrid_to_docked
                first InGrid
                accept pilotPodDockCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action dockToStation : DockToStation {in dockCommand = pilotPodDockCommandSig;}
                then Docked;
                
            transition inGrid_to_onWarp
                first InGrid
                accept warpCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action executeWarpDrive: ExecuteWarpDrive {in warpCommand = warpCommandSig;}
                then OnWarp;
        
            transition onWarp_to_inGrid
                first OnWarp
                accept when miningFrigate.warpBubbleEnd
                then InGrid;     	
            
            //Internal transitions
            transition unloadCargo 
                first Docked
                accept unloadCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action transferOre : TransferOre {in unloadCommand = unloadCommandSig;}
                then Docked;
            
            transition cycleMining 
                first InGrid
                accept miningCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action activateMiningLaser : ActivateMiningLaser
                then InGrid;
                
            transition scanThreats
                first InGrid
                accept scanCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action scanForThreats : ScanForThreats {in scanCommand = scanCommandSig;}
                then InGrid;

            transition prioritizeThreat
                first InGrid
                accept threatSignatureSig : Domain::ScanSignature via miningFrigate.controlPort
                do action prioritizeThreats : PrioritizeThreats {in detectedThreats = threatSignatureSig;}
                then InGrid;

            transition deployDrones
                first InGrid
                accept droneCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action selectDronesForDeployment : SelectDronesForDeployment {in droneCommand = droneCommandSig;}
                then InGrid;

            transition navigation
                first InGrid
                accept destinationCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action acceptDestination : AcceptDestination {in destinationCommand = destinationCommandSig;}
                then InGrid;

            transition coursePlot
                first InGrid
                accept courseCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action plotOptimalCourse : PlotOptimalCourse
                then InGrid;

            transition engagingPropulsion
                first InGrid
                accept propulsionCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action engagePropulsion : EngagePropulsion { in engagePropulsion = propulsionCommandSig;}
                then InGrid;

            transition adjustingCourse
                first InGrid
                accept courseCorrectionSig : Domain::ShipCommand via miningFrigate.controlPort
                do action monitorAndAdjustCourse : MonitorAndAdjustCourse
                then InGrid;

            transition cargoVerification
                first Docked
                accept warehouseStatusCommandSig : Domain::StationCommand via miningFrigate.controlPort
                do action verifyCargoTransfer : VerifyCargoTransfer {in warehouseStatusCommand = warehouseStatusCommandSig;}
                then Docked;

            transition detectingThreat
                first InGrid
                accept threatScanCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action detectThreat : DetectThreat {in scanCommand = threatScanCommandSig;}
                then InGrid;

            transition engagingDefenses
                first InGrid
                accept defenseCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action engageDefenses : EngageDefenses {in engageCommand = defenseCommandSig;}
                then InGrid;

            transition resupplying
                first Docked
                accept shipStatusCommandSig : Domain::ShipCommand via miningFrigate.controlPort
                do action verifyResupply : VerifyResupply
                then Docked;
        }

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

    part def NavigationModule {
        attribute agilityBonus : Real; // Improves ship align time
        attribute warpSpeedBonus : Real; // Boost to warp speed
    }

    part def WarpCoreStabilizer {
        attribute warpCoreStrenght : Real; // Improves ship align time
    }
 }