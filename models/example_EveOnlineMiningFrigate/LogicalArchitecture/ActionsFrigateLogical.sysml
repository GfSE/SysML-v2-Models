package MiningFrigateActions_logical {
    
    //import packages
    private import Domain::*;
	private import ScalarValues::*;
    private import OperationalUseCaseActions::*; 

    //action parameters are inherited
    action def UndockFromStation_logical :> OperationalUseCaseActions::UndockFromStation;
    action def DockToStation_logical :> OperationalUseCaseActions::DockToStation;
    action def ExecuteWarpDrive_logical :> OperationalUseCaseActions::ExecuteWarpDrive;
    action def TransferOre_logical :> OperationalUseCaseActions::TransferOre;
    action def ActivateMiningLaser_logical :> OperationalUseCaseActions::ActivateMiningLaser;
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