package MiningFrigateHull {
    
    private import Domain::*;
    private import MiningFrigate::*;
    private import ScalarValues::*;
    private import COTS::*;
    private import StdPortsAndInterfaces::*;
    private import FrigateRollupAnalysis::*;
    private import MiningFrigateActions_logical::*;

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
       
        perform activateMiningLaser_logical.activateLaserTurret;
        //perform action manageEnergy : MiningFrigateHullActions::ManageEnergy;
        //perform action detectThreat : MiningFrigateHullActions::DetectThreat;
        //perform action engageDefenses : MiningFrigateHullActions::EngageDefenses;
        //perform action navigateToDestination : MiningFrigateHullActions::NavigateToDestination;
        //perform action reportToPilot : MiningFrigateHullActions::ReportToPilot;
        //perform action transferOre : MiningFrigateHullActions::TransferOre;
        //perform action dockToStation : MiningFrigateHullActions::DockToStation;
        //perform action checkAsteroidStatus : MiningFrigateHullActions::CheckAsteroidStatus;
        //perform action resupplyCapacitor : MiningFrigateHullActions::ResupplyCapacitor;

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
}