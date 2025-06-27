package OperationalUseCaseActions {
	
	private import Domain::*;
	private import ScalarValues::*;
	
	// Operational Action Definitions for the Mining Frigate

    // Main Use Case definition : Mine Asteroids
    
    action def IdentifyDestination {
        doc /* Identify an asteroid belt or a target asteroid. */
        out targetSignature : Domain::ScanSignature;
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
         in activateMiningLaser : Domain::ShipCommand;
         out miningCycleReport : Domain::ShipReport;
    }  

    // Main Use Case definition : Detect Threats and Engage Defenses
    
    action def ScanForThreats {
        doc /* Scan the surrounding space for potential threats. */
        in scanCommand : Domain::ShipCommand;
        out detectedThreats : Domain::ScanSignature;
        out scanReport : Domain::ShipReport;
    }

    action def PrioritizeThreats {
        doc /* Evaluate detected threats and prioritize response actions. */
        in detectedThreats : Domain::ScanSignature;
        out threatPriority : String;
    }

    // Main Use Case definition : Plot Course and Navigate
    
    action def UndockFromStation {
		doc /*Undock from a station.*/
        in undockCommand : Domain::ShipCommand;
    }
    
    action def ExecuteWarpDrive {
        doc /* Engage the warp drive to travel to the destination. */
        in warpCommand : Domain::ShipCommand;
        out warpStatusReport : Domain::ShipReport;
    }

    // Main Use Case definition : Offload Ore and Resupply
    
    action def DockToStation {
		doc /*Dock into a station to make repairs, resupply capacitor and support systems.*/
        in dockCommand : Domain::ShipCommand;
		in charge : Domain::Power;
		out dockingReport : Domain::ShipReport;
    }


    // Main Use Case definition : Deploy Drones
    
    action def SelectDronesForDeployment {
        doc /* Select drones for deployment based on operational needs (mining or defense). */
        in droneCommand : Domain::ShipCommand;
        out selectedDrones : Domain::Drone;
    }

    // Included Use Case definition : Navigate to Destination
    
    action def AcceptDestination {
		doc /*Accept a destination from the pilot. */
		in destinationCommand : Domain::ShipCommand;
		out destinationReport : Domain::ShipReport;
    }

    action def PlotOptimalCourse {
		doc /*Plot the optimal course using the navigation system.*/
		out optimalCourseReport : Domain::ShipReport;
    }

    action def EngagePropulsion {
		doc /*Engage the propulsion system to travel along the plotted course.
		 * Propulsion does not use items (fuel, power) in Eve Online.
		 */
		in engagePropulsion : Domain::ShipCommand;
		out propulsionEngagedReport : Domain::ShipReport;    	
    }

    action def MonitorAndAdjustCourse {
		doc /*Continuously monitor progress and adjust the course as needed.*/
		out selectedCourseReport : Domain::ShipReport;
    }
    	
	// Included Use Case definition : Transfer Cargo	
    
    action def TransferOre {
		doc /*Transfer ore or other cargo to the appropriate storage location.*/
    	in unloadCommand : Domain::ShipCommand;
		out oreCargo : Domain::CargoContainer;
		out storageReport : Domain::ShipReport;
    }

    action def VerifyCargoTransfer {
		doc /*Verify the transfer has been completed successfully.*/
    	in warehouseStatusCommand : Domain::StationCommand;
		out warehouseReport : Domain::StationReport;    
    }
	
	// Included Use Case definition : Engage Defense Systems

    action def DetectThreat {
		doc /*Detect and classify threats using the sensor array.*/
		in scanCommand : Domain::ShipCommand;
		in threatSignature : Domain::ScanSignature;
		out scanReport : Domain::ShipReport;    
    }

    action def EngageDefenses {
		doc /*Activate defense turrets and deploy drones to neutralize threats.*/
    	in engageCommand : Domain::ShipCommand;
		out firePower: Domain::Power;
		out damageReport : Domain::ShipReport;    
    }
	
	// Included Use Case definition : Resupply Systems
	
    action def VerifyResupply {
		doc /*Verify the resupply is completed successfully.*/
        in shipStatusCommand : Domain::ShipCommand;
		out shipStatusReport : Domain::ShipReport;    
    }
}
