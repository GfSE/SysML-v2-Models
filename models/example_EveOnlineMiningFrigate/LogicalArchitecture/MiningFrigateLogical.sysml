package MiningFrigateSolutionSpace {

    private import Domain::*;
    private import MiningFrigate::*;
    private import ScalarValues::*;
    private import COTS::*;
    private import StdPortsAndInterfaces::*;
    private import ParametersOfInterestMetadata::*;
    private import FrigateRollupAnalysis::*;
    private import MiningFrigateHullActions::*;
    private import MiningFrigateActions_logical::*;
    
    //The LogicalMiningFrigate is a spezialisation of the MiningFrigate and inherits all its features
    abstract part def LogicalMiningFrigateConfiguration :> CompositeFrigateComponent, MiningFrigate::MiningFrigate {
        doc /* The Mining Frigate consists of a fixed hull structure with modular (COTS) components 
         * that can be replaced or upgraded depending on operational needs. */

        part logicalHull : LogicalMiningFrigateHull :> MiningFrigate::miningFrigate.coreSystem ;

        //The parts of the LogicalMiningFrigate are a subset of the parts of the MiningFrigate 
        // COTS Modules (Ref Parts - Exchangeable)
        //the mining laser is available in three variants
        variation ref part miningLaser : MinerModule[2] :> MiningFrigate::miningFrigate.miningLaser {
            variant 'Mining Laser EP-S Gaussian Scoped';
            variant 'Mining Laser Particle Bore Compact';
            variant minerI : MinerI;
        }             
        ref part propulsionModule : Afterburner[0..1] :> MiningFrigate::miningFrigate.propulsionModule; 
        ref part shieldModule : SmallShieldExtenderI[0..1] :> MiningFrigate::miningFrigate.shieldModule; 
        ref part capacitorModule : SmallCapBatteryI[0..1] :> MiningFrigate::miningFrigate.capacitorBooster;  
        ref part sensorModule : SurveyScannerI[0..1] :> MiningFrigate::miningFrigate.sensorModule;  
        ref part warpCoreStabilizer : WarpCoreStabilizerI[0..2] :> MiningFrigate::miningFrigate.warpCoreStabilizer; 
        
        //internal conexions between parts of the LogicalMiningFrigateConfiguration
        interface highSlotInterface1 : HighSlotInterface connect
        	hullPort ::> logicalHull.highSlot1 to
        	modulePort ::> miningLaser.highSlot;

	    interface highSlotInterface2 : HighSlotInterface connect
	        hullPort ::> logicalHull.highSlot2 to
	        modulePort ::> miningLaser.highSlot;
	
	    interface mediumSlotInterface1 : MediumSlotInterface connect
	        hullPort ::> logicalHull.mediumSlot1 to
	        modulePort ::> propulsionModule.mediumSlot;
	
	    interface mediumSlotInterface2 : MediumSlotInterface connect
	        hullPort ::> logicalHull.mediumSlot2 to
	        modulePort ::> shieldModule.mediumSlot;
	
	    interface lowSlotInterface1 : LowSlotInterface connect
	        hullPort ::> logicalHull.lowSlot1 to
	        modulePort ::> warpCoreStabilizer.lowSlot; 
        
        //the ports of the LogicalMiningFrigateConfiguration are bound to the ports of the LogicalMiningFriagteHull
        //the external ports of LogicalMiningFrigateConfiguration are not redefined because they must be same as the ones at the problem space.
        bind controlPort = logicalHull.hullControlPort;
        bind dockingPort = logicalHull.hullDockingPort;
        bind defensePort = logicalHull.hullDefensePort;
        bind droneControlPort = logicalHull.hullDroneControlPort;
  
    }

    //Three different configurations of mining frigatte are defined here that base on an abstract frigate
    abstract part logicalMiningFrigateConfiguration : LogicalMiningFrigateConfiguration {

        //the state of the LogicalMiningFrigateConfiguration is redefined from the problem space
        state logicalMiningFrigateStates :>> MiningFrigate::miningFrigate.miningFrigatesStates {
            
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
                accept pilotPodUndockCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action undockFromStation_logical : UndockFromStation_logical {in undockCommand = pilotPodUndockCommandSig;}
                then InGrid;  		
                
            transition inGrid_to_docked
                first InGrid
                accept pilotPodDockCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action dockToStation_logical : DockToStation_logical {in dockCommand = pilotPodDockCommandSig;}
                then Docked;
                
            transition inGrid_to_onWarp
                first InGrid
                accept warpCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action executeWarpDrive_logical : ExecuteWarpDrive_logical {in warpCommand = warpCommandSig;}
                then OnWarp;
        
            transition onWarp_to_inGrid
                first OnWarp
                accept when logicalMiningFrigateConfiguration.warpBubbleEnd
                then InGrid;     	
            
            //Internal transitions
            transition unloadCargo 
                first Docked
                accept unloadCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action transferOre_logical : TransferOre_logical {in unloadCommand = unloadCommandSig;}
                then Docked;
            
            transition cycleMining 
                first InGrid
                accept miningCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action activateMiningLaser_logical : ActivateMiningLaser_logical
                then InGrid;
                
            transition scanThreats
                first InGrid
                accept scanCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action scanForThreats_logical : ScanForThreats_logical {in scanCommand = scanCommandSig;}
                then InGrid;

            transition prioritizeThreat
                first InGrid
                accept threatSignatureSig : Domain::ScanSignature via logicalMiningFrigateConfiguration.controlPort
                do action prioritizeThreats_logical : PrioritizeThreats_logical {in detectedThreats = threatSignatureSig;}
                then InGrid;

            transition deployDrones
                first InGrid
                accept droneCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action selectDronesForDeployment_logical : SelectDronesForDeployment_logical {in droneCommand = droneCommandSig;}
                then InGrid;

            transition navigation
                first InGrid
                accept destinationCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action acceptDestination_logical : AcceptDestination_logical {in destinationCommand = destinationCommandSig;}
                then InGrid;

            transition coursePlot
                first InGrid
                accept courseCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action plotOptimalCourse_logical : PlotOptimalCourse_logical
                then InGrid;

            transition engagingPropulsion
                first InGrid
                accept propulsionCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action engagePropulsion_logical : EngagePropulsion_logical { in engagePropulsion = propulsionCommandSig;}
                then InGrid;

            transition adjustingCourse
                first InGrid
                accept courseCorrectionSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action monitorAndAdjustCourse_logical : MonitorAndAdjustCourse_logical
                then InGrid;

            transition cargoVerification
                first Docked
                accept warehouseStatusCommandSig : Domain::StationCommand via logicalMiningFrigateConfiguration.controlPort
                do action verifyCargoTransfer_logical : VerifyResupply_logical {in warehouseStatusCommand = warehouseStatusCommandSig;}
                then Docked;

            transition detectingThreat
                first InGrid
                accept threatScanCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action detectThreat_logical : DetectThreat_logical {in scanCommand = threatScanCommandSig;}
                then InGrid;

            transition engagingDefenses
                first InGrid
                accept defenseCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action engageDefenses_logical : EngageDefenses_logical {in engageCommand = defenseCommandSig;}
                then InGrid;

            transition resupplying
                first Docked
                accept shipStatusCommandSig : Domain::ShipCommand via logicalMiningFrigateConfiguration.controlPort
                do action verifyResupply_logical : VerifyCargoTransfer_logical
                then Docked;
        }       
        
    }

    part logicalNoviceMiningFrigatte :> logicalMiningFrigateConfiguration{
        part redefines miningLaser = miningLaser::minerI;
    }

    part logicalTrainerMiningFrigate :> logicalMiningFrigateConfiguration{
        part redefines miningLaser = miningLaser::'Mining Laser Particle Bore Compact';
    } 

    part logicalFieldMiningFrigate :> logicalMiningFrigateConfiguration{
        part redefines miningLaser = miningLaser::'Mining Laser EP-S Gaussian Scoped';
    } 
    
    //Mining Frigate Hull (Black Box with Ports)
    part def LogicalMiningFrigateHull :> SimpleFrigateComponent {
        doc /* The Venture-class Mining Frigate hull includes integrated features such as 
         * a built-in warp core stabilizer, ore hold, and base resistances. */

        attribute hullHP : Real = 400.0;
        attribute armorHP : Real = 400.0;
        attribute shieldHP : Real = 700.0;
        attribute oreHoldCapacity : Real = 5000.0;
        attribute maxVelocity : Real = 335.0;
        attribute warpSpeed : Real = 5.0;
        attribute capacitorSize : Real = 250.0;
        attribute warpCoreStrenght : Real = 2.0;
        
        //Performed actions of the hull (executed by the ship's integrated systems)
        perform action manageEnergy : MiningFrigateHullActions::ManageEnergy;
        perform action detectThreat : MiningFrigateHullActions::DetectThreat;
        perform action engageDefenses : MiningFrigateHullActions::EngageDefenses;
        perform action navigateToDestination : MiningFrigateHullActions::NavigateToDestination;
        perform action reportToPilot : MiningFrigateHullActions::ReportToPilot;
        perform action transferOre : MiningFrigateHullActions::TransferOre;
        perform action extractOre : MiningFrigateHullActions::ExtractOre;
        perform action dockToStation : MiningFrigateHullActions::DockToStation;
        perform action checkAsteroidStatus : MiningFrigateHullActions::CheckAsteroidStatus;
        perform action resupplyCapacitor : MiningFrigateHullActions::ResupplyCapacitor;
        perform action activateMiningLaser : MiningFrigateHullActions::ActivateMiningLaser;

        //Ports for COTS Modules
        port highSlot1 : HighSlotPort;
        port highSlot2 : HighSlotPort;
        port mediumSlot1 : MediumSlotPort;
        port mediumSlot2 : MediumSlotPort;
        port lowSlot1 : LowSlotPort;
        port lowSlot2 : LowSlotPort;

        //Ports bound to the LogicalMiningFrigateConfiguration
        port hullControlPort : ~Domain::PodPort;
        port hullDockingPort : ~Domain::DockingPort;
        port hullDefensePort : ~Domain::ThreatPort;
        port hullDroneControlPort: ~Domain::DroneControllerPort;
    }

    //Power and Control Interfaces Items inherited from the standardPorts items
    item def VenturePowerSupply :> PowerSupply ;
    item def VentureHighSlotCommand :> HighSlotCommand ;
    item def VentureMediumSlotCommand :> MediumSlotCommand ;
    item def VentureLowSlotCommand :> LowSlotCommand ;

}
