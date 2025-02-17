package OperationalUseCaseActions {
	
	private import Domain::*;
	private import ScalarValues::*;
	private import MiningFrigate::*; 
	
	// Operational Action Definitions for the Mining Frigate

    // Main Use Case definition : Mine Asteroids
    
    action def IdentifyDestination {
        doc /* Identify an asteroid belt or a target asteroid. */
        out targetSignature : ScanSignature;
    }
    
    action def ActivateMiningLaser {
        doc /* 
         * Main Flow:
         * 1. Receive mining command from the pilot.
         * 2. Activate mining laser on the selected asteroid.
         * 3. Extract ore and transfer it to the ship's ore hold.
         * 4. Generate a mining report and notify the pilot.
         *
         * Alternative Flows:
         * - If multiple asteroids are in range, mining lasers distribute across different targets.
         * - If mining boosts (e.g., from Orca/Rorqual) are active, adjust extraction efficiency.
         * - If the ore hold is nearly full, notify the pilot before proceeding with further extraction.
         *
         * Exception Flows:
         * - If the asteroid is depleted mid-cycle, halt mining and prompt pilot for new target.
         * - If mining lasers overheat, disable temporarily until cooldown completes.
         * - If capacitor energy is insufficient, fail to activate laser and notify the pilot.
         * - If ECM interference disrupts target lock, pause extraction until lock is re-established.
         */
    }  

    // Main Use Case definition : Detect Threats and Engage Defenses
    
    action def ScanForThreats {
        doc /* Scan the surrounding space for potential threats. */
        in scanCommand : ShipCommand;
        out detectedThreats : ScanSignature;
        out scanReport : ShipReport;
    }

    action def PrioritizeThreats {
        doc /* Evaluate detected threats and prioritize response actions. */
        in detectedThreats : ScanSignature;
        out threatPriority : String;
    }

    // Main Use Case definition : Plot Course and Navigate
    
    action def UndockFromStation {
		doc /*Undock from a station.*/
        in undockCommand : ShipCommand;
    }
    
    action def ExecuteWarpDrive {
        doc /* Engage the warp drive to travel to the destination. */
        in warpCommand : ShipCommand;
        out warpStatusReport : ShipReport;
    }

    // Main Use Case definition : Offload Ore and Resupply
    
    action def DockToStation {
		doc /*Dock into a station to make repairs, resupply capacitor and support systems.*/
        in dockCommand : ShipCommand;
		in charge : Power;
		out dockingReport : ShipReport;
    }


    // Main Use Case definition : Deploy Drones
    
    action def SelectDronesForDeployment {
        doc /* Select drones for deployment based on operational needs (mining or defense). */
        in droneCommand : ShipCommand;
        out selectedDrones : Drone;
    }

    // Included Use Case definition : Navigate to Destination
    
    action def AcceptDestination {
		doc /*Accept a destination from the pilot. */
		in destinationCommand : ShipCommand;
		out destinationReport : ShipReport;
    }

    action def PlotOptimalCourse {
		doc /*Plot the optimal course using the navigation system.*/
		out optimalCourseReport : ShipReport;
    }

    action def EngagePropulsion {
		doc /*Engage the propulsion system to travel along the plotted course.
		 * Propulsion does not use items (fuel, power) in Eve Online.
		 */
		in engagePropulsion : ShipCommand;
		out propulsionEngagedReport : ShipReport;    	
    }

    action def MonitorAndAdjustCourse {
		doc /*Continuously monitor progress and adjust the course as needed.*/
		out selectedCourseReport : ShipReport;
    }
    	
	// Included Use Case definition : Transfer Cargo	
    
    action def TransferOre {
		doc /*Transfer ore or other cargo to the appropriate storage location.*/
    	in unloadCommand : ShipCommand;
		out oreCargo : CargoContainer;
		out storageReport : ShipReport;
    }

    action def VerifyCargoTransfer {
		doc /*Verify the transfer has been completed successfully.*/
    	in warehouseStatusCommand : StationCommand;
		out warehouseReport : StationReport;    
    }
	
	// Included Use Case definition : Engage Defense Systems

    action def DetectThreat {
		doc /*Detect and classify threats using the sensor array.*/
		in scanCommand : ShipCommand;
		in threatSignature : ScanSignature;
		out scanReport : ShipReport;    
    }

    action def EngageDefenses {
		doc /*Activate defense turrets and deploy drones to neutralize threats.*/
    	in engageCommand : ShipCommand;
		out firePower: Power;
		out damageReport : ShipReport;    
    }
	
	// Included Use Case definition : Resupply Systems
	
    action def VerifyResupply {
		doc /*Verify the resupply is completed successfully.*/
        in shipStatusCommand : ShipCommand;
		out shipStatusReport : ShipReport;    
    }
}
