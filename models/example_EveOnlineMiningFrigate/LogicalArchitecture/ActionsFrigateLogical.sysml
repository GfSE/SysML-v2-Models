package MiningFrigateActions_logical {
    
    //import packages
    private import Domain::*;
	private import ScalarValues::*;
    private import OperationalUseCaseActions::*;
    private import COTS::*;

    //action parameters are inherited
    
    //Activate Mining Laser
    action def PowerupHighPowerModule {in activateMiningLaser : Domain::ShipCommand; out highPowerSupply : Real; }
    action def ActivateLaserTurret {in highPowerSupply : Real; in miningLaserTarget : COTS::ModuleCommand; out minigLaserReport : COTS::ModuleReport; }
    action def ManageReports {in moduleReport : COTS::ModuleReport; out shipReport : Domain::ShipReport;}
    action def ActivateMiningLaser_logical :> OperationalUseCaseActions::ActivateMiningLaser;
    action activateMiningLaser_logical : ActivateMiningLaser_logical {
        bind powerupHighPowerModule.activateMiningLaser = activateMiningLaser;
        action powerupHighPowerModule : PowerupHighPowerModule {in activateMiningLaser : Domain::ShipCommand; out highPowerSupply; }
        flow powerupHighPowerModule.highPowerSupply to activateLaserTurret.highPowerSupply;
        action activateLaserTurret : ActivateLaserTurret {in highPowerSupply; in miningLaserTarget; out miningLaserReport; }
        flow activateLaserTurret.miningLaserReport to manageLaserTurretReport.laserModuleReport;
        action manageLaserTurretReport : ManageReports {in laserModuleReport : COTS::ModuleReport; out shipMiningReport : Domain::ShipReport;}
        bind manageLaserTurretReport.shipMiningReport = miningCycleReport;
    }

    action def UndockFromStation_logical :> OperationalUseCaseActions::UndockFromStation;
    action def DockToStation_logical :> OperationalUseCaseActions::DockToStation;
    action def ExecuteWarpDrive_logical :> OperationalUseCaseActions::ExecuteWarpDrive;
    action def TransferOre_logical :> OperationalUseCaseActions::TransferOre;
    action def ScanForThreats_logical :> OperationalUseCaseActions::ScanForThreats;
    action def PrioritizeThreats_logical :> OperationalUseCaseActions::PrioritizeThreats;
    action def SelectDronesForDeployment_logical :> OperationalUseCaseActions::SelectDronesForDeployment;
    action def AcceptDestination_logical :> OperationalUseCaseActions::AcceptDestination;
    action def PlotOptimalCourse_logical :> OperationalUseCaseActions::PlotOptimalCourse;
    action def EngagePropulsion_logical :> OperationalUseCaseActions::EngagePropulsion;
    action def MonitorAndAdjustCourse_logical :> OperationalUseCaseActions::MonitorAndAdjustCourse;
    action def VerifyCargoTransfer_logical :> OperationalUseCaseActions::VerifyCargoTransfer;
    action def DetectThreat_logical :> OperationalUseCaseActions::DetectThreat;
    action def EngageDefenses_logical :> OperationalUseCaseActions::EngageDefenses;
    action def VerifyResupply_logical :> OperationalUseCaseActions::VerifyResupply;

}