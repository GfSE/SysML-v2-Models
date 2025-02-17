package MiningFrigateUseCases {

    // Import the Domain package for referencing actors
    private import Domain::*;
    private import MiningFrigateRequirements::*;
    private import MiningFrigate::*;

    //Use Cases of the Mining Frigate
    
    //Main Use Case Mining Asteroid
    use case mineAsteroids : MineAsteroids {
    	first start;
    	then include use case navigateToDestination : NavigateToDestination {
    		actor :>> pilotPod = navigateToDestination::pilotPod;
    	}
    	then include use case transferCargo : TransferCargo {
    		actor :>> pilotPod = transferCargo::pilotPod;
    	}
    	then done;   
    }
    
    // Main Use Case: Detect Threats and Engage Defenses
    use case detectThreatsAndEngageDefenses : DetectThreatsAndEngageDefenses {
        first start;
        then include use case engageDefenseSystems : EngageDefenseSystems {
            actor :>> pilotPod = engageDefenseSystems::pilotPod;
            actor :>> hostileShip = engageDefenseSystems::hostileShip;
        }
        then done;
    }

    // Main Use Case: Plot Course and Navigate
    use case plotCourseAndNavigate : PlotCourseAndNavigate {
        first start;
        then include use case navigateToDestination : NavigateToDestination {
            actor :>> pilotPod = navigateToDestination::pilotPod;
        }
        then done;
    }

    // Main Use Case: Offload Ore and Resupply
    use case offloadOreAndResupply : OffloadOreAndResupply {
        first start;
        then include use case transferCargo : TransferCargo {
            actor :>> pilotPod = transferCargo::pilotPod;
        }
        then include use case resupplySystems : ResupplySystems {
            actor :>> station = resupplySystems::station;
        }
        then done;
    }

    // Main Use Case: Deploy Drones
    use case deployDrones : DeployDrones {
        first start;
        then include use case engageDefenseSystems : EngageDefenseSystems {
            actor :>> pilotPod = engageDefenseSystems::pilotPod;
            actor :>> hostileShip = engageDefenseSystems::hostileShip;
        }
        then done;
    }

}    
    
    // Included Use Case definition : Navigate to Destination
    use case def NavigateToDestination {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor pilotPod : Domain::PilotPod;

        objective {
            doc /* Main Flow:
                  * 1. Accept a destination from the pilot.
                  * 2. Plot the optimal course using the navigation system.
                  * 3. Engage the propulsion system to travel along the plotted course.
                  * 4. Continuously monitor progress and adjust the course as needed.
                  *
                  * Alternate Flows:
                  * - If docked, undock.
                  * 
                  * Exception Flows:
                  * - If the propulsion system fails, suspend navigation and alert the pilot.
                  * - If the navigation system loses connection to the destination, revert to manual control and notify the pilot.
                  */
        }
    }

    // Included Use Case definition : Transfer Cargo
    use case def TransferCargo {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor pilotPod : Domain::PilotPod;

        objective {
            doc /* Main Flow:
                  * 1. Transfer ore or other cargo to the appropriate storage location.
                  * 2. Verify the transfer has been completed successfully.
                  *
                  * Exception Flows:
                  * - If the cargo transfer system fails, alert the pilot and suspend operations.
                  */
        }
    }

    // Included Use Case definition : Engage Defense Systems
    use case def EngageDefenseSystems {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor hostileShip : Domain::HostileShip;
        actor pilotPod : Domain::PilotPod;
        objective {
            doc /* Main Flow:
                  * 1. Detect and classify threats using the sensor array.
                  * 2. Activate defense turrets and deploy drones to neutralize threats.
                  *
                  * Exception Flows:
                  * - If a turret fails, redirect drones to cover the defense gap.
                  * - If drones cannot be deployed, rely solely on turrets for defense.
                  */
        }
    }

    // Included Use Case definition : Resupply Systems
    use case def ResupplySystems {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor station : Domain::Station;

        objective {
            doc /* Main Flow:
                  * 1. Connect to a station to resupply fuel and life support systems.
                  * 2. Verify the resupply is completed successfully.
                  *
                  * Exception Flows:
                  * - If the resupply system fails, alert the pilot and recommend limited travel.
                  */
        }
    }

    // Main Use Case definition : Mine Asteroids
    use case def MineAsteroids {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor pilotPod : Domain::PilotPod;
        actor asteroidBelt : Domain::AsteroidBelt;
        objective {
            doc /* Main Flow:
                  * 1. Identify an asteroid belt and select a target asteroid.
                  * 2. Navigate to the asteroid using the included NavigateToDestination use case.
                  * 3. Activate mining lasers to extract ore.
                  * 4. Transfer the extracted ore to the cargo hold using the included TransferCargo use case.
                  *
                  * Alternate Flows:
                  * - If the pilot selects a different asteroid belt during mining, update the navigation system to move to the new asteroid belt.
                  * - If multiple asteroids are in proximity, allow switching between targets.
                  *
                  * Exception Flows:
                  * - If the mining laser malfunctions, halt mining operations and alert the pilot.
                  * - If the cargo hold is full, suspend mining and notify the pilot to return to a station for offloading.
                  */
        }
    }

    // Main Use Case definition : Detect Threats and Engage Defenses
    use case def DetectThreatsAndEngageDefenses {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor hostileShip : Domain::HostileShip;
        actor pilotPod : Domain::PilotPod;

        objective {
            doc /* Main Flow:
                  * 1. Detect threats using the sensor array.
                  * 2. Engage defense systems using the included EngageDefenseSystems use case.
                  *
                  * Alternate Flows:
                  * - If the threat is minor, recommend to the pilot that manual intervention is unnecessary.
                  * - If there are multiple threats, prioritize based on classification.
                  *
                  * Exception Flows:
                  * - If the defense turret fails, redirect the drones to focus entirely on the hostile ships.
                  * - If the frigate sustains critical damage, override the defense system and initiate retreat.
                  */
        }
    }

    // Main Use Case definition : Plot Course and Navigate
    use case def PlotCourseAndNavigate {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor pilotPod : Domain::PilotPod;
        actor station : Domain::Station;

        objective {
            doc /* Main Flow:
                  * 1. Accept a destination from the pilot (e.g., a station or asteroid belt).
                  * 2. Plot and follow the course using the included NavigateToDestination use case.
                  *
                  * Alternate Flows:
                  * - If the pilot modifies the destination mid-journey, recalculate the course and notify the pilot of the updated arrival time.
                  * - If an asteroid field is encountered en route, reroute the ship to avoid collisions.
                  *
                  * Exception Flows:
                  * - If the propulsion system fails, suspend navigation and alert the pilot.
                  * - If the navigation system loses connection to the destination, revert to manual control and notify the pilot.
                  */
        }
    }

    // Main Use Case definition : Offload Ore and Resupply
    use case def OffloadOreAndResupply {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor station : Domain::Station;

        objective {
            doc /* Main Flow:
                  * 1. Establish a docking connection with the station.
                  * 2. Transfer processed ore to the station using the included TransferCargo use case.
                  * 3. Resupply fuel tank and life support systems using the included ResupplySystems use case.
                  *
                  * Alternate Flows:
                  * - If the station has limited docking capacity, queue the docking request and notify the pilot of the wait time.
                  * - If the station requests specific cargo configurations, adjust the offloading process accordingly.
                  *
                  * Exception Flows:
                  * - If the docking system fails, abort the docking process and notify the pilot.
                  * - If the station cannot accept ore due to storage limits, store the ore until another station is found.
                  * - If resupply operations fail, alert the pilot and recommend limited operational travel.
                  */
        }
    }

    // Main Use Case definition : Deploy Drones
    use case def DeployDrones {
        subject miningFrigate : MiningFrigate::MiningFrigate;
        actor pilotPod : Domain::PilotPod;
        actor hostileShip : Domain::HostileShip;

        objective {
            doc /* Main Flow:
                  * 1. Select drones for deployment based on the operation type (mining or defense).
                  * 2. Engage defense systems using the included EngageDefenseSystems use case.
                  *
                  * Alternate Flows:
                  * - If the pilot overrides drone operation, update drone tasks accordingly.
                  * - If the pilot decides to switch from mining to defense or vice versa, reconfigure drone roles dynamically.
                  *
                  * Exception Flows:
                  * - If a drone is destroyed during operation, log the loss and notify the pilot.
                  * - If the drone bay malfunctions, suspend drone operations and notify the pilot.
                  * - If the hostile ships neutralize all drones during defense, fallback to the defense turret.
                  */
        }
    }
