package MiningFrigateSolutionSpace {

    private import Domain::*;
    private import ScalarValues::*;
    private import COTS::*;
    private import StdPortsAndInterfaces::*;
    private import ParametersOfInterestMetadata::*;
    private import FrigateRollupAnalysis::*;
    private import MiningFrigateHullHighLevelActions::*;

    // **Mining Frigate as the Core System**
    part def MiningFrigate :> CompositeFrigateComponent {
        doc /* The Mining Frigate consists of a fixed hull structure with modular (COTS) components 
         * that can be replaced or upgraded depending on operational needs. */

        part hull : MiningFrigateHull;

        // **COTS Modules (Ref Parts - Exchangeable)**
        ref part miningLaser : MinerI[2];              
        ref part propulsionModule : Afterburner[0..1]; 
        ref part shieldModule : SmallShieldExtenderI[0..1]; 
        ref part capacitorModule : SmallCapBatteryI[0..1];  
        ref part sensorModule : SurveyScannerI[0..1];  
        ref part defensiveModule : WarpCoreStabilizerI[0..2]; 
    
    	interface highSlotInterface1 : HighSlotInterface connect
        	hullPort ::> hull.highSlot1 to
        	modulePort ::> miningLaser.highSlot;

	    interface highSlotInterface2 : HighSlotInterface connect
	        hullPort ::> hull.highSlot2 to
	        modulePort ::> miningLaser.highSlot;
	
	    interface mediumSlotInterface1 : MediumSlotInterface connect
	        hullPort ::> hull.mediumSlot1 to
	        modulePort ::> propulsionModule.mediumSlot;
	
	    interface mediumSlotInterface2 : MediumSlotInterface connect
	        hullPort ::> hull.mediumSlot2 to
	        modulePort ::> shieldModule.mediumSlot;
	
	    interface lowSlotInterface1 : LowSlotInterface connect
	        hullPort ::> hull.lowSlot1 to
	        modulePort ::> defensiveModule.lowSlot;
	
	    interface lowSlotInterface2 : LowSlotInterface connect
	        hullPort ::> hull.lowSlot2 to
	        modulePort ::> defensiveModule.lowSlot;
    }

    // **Mining Frigate Hull (Black Box with Ports)**
    part def MiningFrigateHull :> SimpleFrigateComponent {
        doc /* The Venture-class Mining Frigate hull includes integrated features such as 
         * a built-in warp core stabilizer, ore hold, and base resistances. */

        attribute hullHP : Real = 400.0;
        attribute armorHP : Real = 400.0;
        attribute shieldHP : Real = 700.0;
        attribute oreHoldCapacity : Real = 5000.0;
        attribute maxVelocity : Real = 335.0;
        attribute warpSpeed : Real = 5.0;
        attribute capacitorCapacity : Real = 250.0;
        
        // Performed actions of the hull (executed by the ship's integrated systems)
        perform action scanForThreats;
        perform action engageDefenses;
        perform action acceptDestination;
        perform action plotOptimalCourse;
        perform action engagePropulsion;
        perform action monitorAndAdjustCourse;
        perform action transferOre;
        perform action verifyCargoTransfer;
        perform action dockToStation;
        perform action undockFromStation;
        perform action resupplyCapacitor;
        perform action activateMiningLaser;

        // **Ports for COTS Modules**
        port highSlot1 : HighSlotPort;
        port highSlot2 : HighSlotPort;
        port mediumSlot1 : MediumSlotPort;
        port mediumSlot2 : MediumSlotPort;
        port lowSlot1 : LowSlotPort;
        port lowSlot2 : LowSlotPort;
    }

    // **Power and Control Interfaces Items inherited from the standardPorts items**
    item def VenturePowerSupply :> PowerSupply ;
    item def VentureHighSlotCommand :> HighSlotCommand ;
    item def VentureMediumSlotCommand :> MediumSlotCommand ;
    item def VentureLowSlotCommand :> LowSlotCommand ;

}
