package MiningFrigateHullHighLevelActions {

    private import MiningFrigateHullIncludedActions::*;
    private import Domain::*;
    private import MiningFrigateSolutionSpace::*;

    // **Action: Withstand Incoming Damage**
    action def WithstandIncomingDamage { 
        in scanCommand : Domain::ShipCommand; 
        out defenseStatus : Domain::ShipReport;

        bind detectThreat.scanCommand = scanCommand;
        action detectThreat : DetectThreat { in scanCommand; out scanReport; }
        flow from detectThreat.scanReport to engageDefenses.engageCommand;
        first detectThreat then engageDefenses;
        action engageDefenses : EngageDefenses { in engageCommand; out defenseStatus; }
        bind engageDefenses.defenseStatus = defenseStatus;
    }

    // **Action: Navigate and Warp to Destinations**
    action def NavigateAndWarp { 
        in destinationCommand : Domain::ShipCommand; 
        out navigationStatus : Domain::ShipReport;

        bind navigate.destinationCommand = destinationCommand;
        action navigate : NavigateToDestination { in destinationCommand; out navigationStatus; }
        bind navigate.navigationStatus = navigationStatus;
    }

    // **Action: Store and Transfer Mined Ore**
    action def StoreAndTransferOre { 
        in transferCommand : Domain::ShipCommand; 
        out transferStatus : Domain::ShipReport;

        bind transferOre.transferCommand = transferCommand;
        action transferOre : TransferOre { in transferCommand; out transferStatus; }
        bind transferOre.transferStatus = transferStatus;
    }

    // **Action: Dock and Undock from Stations**
    action def DockAndUndock { 
        in dockingCommand : Domain::ShipCommand; 
        out dockingStatus : Domain::ShipReport;

        bind dock.dockingCommand = dockingCommand;
        action dock : DockAtStation { in dockingCommand; out dockingStatus; }
        bind dock.dockingStatus = dockingStatus;
    }

    // **Action: Manage Energy Supply and Recharge**
    action def ManageEnergy { 
        in rechargeCommand : Domain::ShipCommand; 
        out rechargeStatus : Domain::ShipReport;

        bind resupplyCapacitor.rechargeCommand = rechargeCommand;
        action resupplyCapacitor : ResupplyCapacitor { in rechargeCommand; out rechargeStatus; }
        bind resupplyCapacitor.rechargeStatus = rechargeStatus;
    }

    // **Action: Support High, Medium, and Low Slot Modules**
    action def SupportModuleFitting { 
        in miningCommand : Domain::ShipCommand; 
        out miningStatus : Domain::ShipReport;

        bind activateMiningLaser.miningCommand = miningCommand;
        action activateMiningLaser : ActivateMiningLaser { in miningCommand; out miningStatus; }
        bind activateMiningLaser.miningStatus = miningStatus;
    }
}


package MiningFrigateHullIncludedActions {

    private import Domain::*;
    private import MiningFrigateSolutionSpace::*;
    
    // **Action: Detect Threat**
    action def DetectThreat { 
        in scanCommand : Domain::ShipCommand; 
        out scanReport : Domain::ShipReport; 
    }

    // **Action: Engage Defenses**
    action def EngageDefenses { 
        in engageCommand : Domain::ShipCommand; 
        out defenseStatus : Domain::ShipReport; 
    }

    // **Action: Navigate to Destination**
    action def NavigateToDestination { 
        in destinationCommand : Domain::ShipCommand; 
        out navigationStatus : Domain::ShipReport; 
    }

    // **Action: Transfer Ore**
    action def TransferOre { 
        in transferCommand : Domain::ShipCommand; 
        out transferStatus : Domain::ShipReport; 
    }

    // **Action: Dock at Station**
    action def DockAtStation { 
        in dockingCommand : Domain::ShipCommand; 
        out dockingStatus : Domain::ShipReport; 
    }

    // **Action: Resupply Capacitor**
    action def ResupplyCapacitor { 
        in rechargeCommand : Domain::ShipCommand; 
        out rechargeStatus : Domain::ShipReport; 
    }

    // **Action: Activate Mining Laser**
    action def ActivateMiningLaser { 
        in miningCommand : Domain::ShipCommand; 
        out miningStatus : Domain::ShipReport; 

        bind checkAsteroidStatus.miningCommand = miningCommand;
        
        action checkAsteroidStatus : CheckAsteroidStatus { 
            in miningCommand;
            out asteroidStatus;
        }

        decide;
        	if checkAsteroidStatus.asteroidStatus == "depleted" then reportDepletion;
        	else continueMining;
            
        action continueMining : ExtractOre {
            in miningCommand;
            out miningStatus;
            }
            
        action reportDepletion : ReportToPilot {
            in asteroidStatus;
            out report : Domain::ShipReport;}

        bind continueMining.miningStatus = miningStatus;
    }

    // **Action: Check Asteroid Status**
    action def CheckAsteroidStatus { 
        in miningCommand : Domain::ShipCommand; 
        out asteroidStatus : Domain::ShipReport; 
    }

    // **Action: Extract Ore (Standard Mining)**
    action def ExtractOre { 
        in miningCommand : Domain::ShipCommand; 
        out miningStatus : Domain::ShipReport; 
    }

    // **Action: Report Asteroid Depletion to Pilot**
    action def ReportToPilot { 
        in asteroidStatus : Domain::ShipReport; 
        out report : Domain::ShipReport; 
    }
}
