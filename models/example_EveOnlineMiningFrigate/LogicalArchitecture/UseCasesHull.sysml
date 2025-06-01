package MiningFrigateHullUseCasesUsage {

    private import MiningFrigateHullUseCasesDef::*;
    private import Domain::*;

    // **Use Case Usage: Withstand Incoming Damage**
    use case withstandIncomingDamage : WithstandIncomingDamage {
        first start;

        then include use case detectThreat : DetectThreat {
            actor :>> pilotPod = withstandIncomingDamage::pilotPod;
        }

        then include use case engageDefenses : EngageDefenses {
            actor :>> pilotPod = withstandIncomingDamage::pilotPod;
            actor :>> hostileShip = withstandIncomingDamage::hostileShip;
        }

        then done;
    }

    // **Use Case Usage: Navigate and Warp to Destinations**
    use case navigateAndWarp : NavigateAndWarp {
        first start;

        then include use case navigateToDestination : NavigateToDestination {
            actor :>> pilotPod = navigateAndWarp::pilotPod;
        }

        then done;
    }

    // **Use Case Usage: Store and Transfer Mined Ore**
    use case storeAndTransferOre : StoreAndTransferOre {
        first start;

        then include use case transferOre : TransferOre {
            actor :>> pilotPod = storeAndTransferOre::pilotPod;
            actor :>> station = storeAndTransferOre::station;
        }

        then done;
    }

    // **Use Case Usage: Dock and Undock from Stations**
    use case dockAndUndock : DockAndUndock {
        first start;

        then include use case dockAtStation : DockAtStation {
            actor :>> pilotPod = dockAndUndock::pilotPod;
            actor :>> station = dockAndUndock::station;
        }

        then done;
    }

    // **Use Case Usage: Manage Energy Supply and Recharge**
    use case manageEnergy : ManageEnergy {
        first start;

        then include use case resupplyCapacitor : ResupplyCapacitor {
            actor :>> pilotPod = manageEnergy::pilotPod;
            actor :>> smallCapBatteryI = manageEnergy::smallCapBatteryI;
        }

        then done;
    }

    // **Use Case Usage: Support High, Medium, and Low Slot Modules**
    use case supportModuleFitting : SupportModuleFitting {
        first start;

        then include use case activateMiningLaser : ActivateMiningLaser {
            actor :>> miningLaser = supportModuleFitting::miningLaser;
        }

        then done;
    }
}


package MiningFrigateHullUseCasesDef {

    private import MiningFrigateSolutionSpace::*;
    private import Domain::*;
    private import COTS::*;

    // **Use Case: Withstand Incoming Damage**
    use case def WithstandIncomingDamage {
        subject hull : MiningFrigateHull;
        actor hostileShip : Domain::HostileShip;
        actor pilotPod : Domain::PilotPod;

        objective {
            doc /*
            * The Mining Frigate Hull shall sustain damage from hostile ships while ensuring pilot safety.
            */
        }
    }

    // **Use Case: Navigate and Warp to Destinations**
    use case def NavigateAndWarp {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;

        objective {
            doc /*
            * The Mining Frigate Hull shall navigate between celestial bodies using its onboard navigation system.
            */
        }
    }

    // **Use Case: Store and Transfer Mined Ore**
    use case def StoreAndTransferOre {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor station : Domain::Station;

        objective {
            doc /*
            * The Mining Frigate Hull shall store extracted ore in its ore hold 
            * and transfer it to a station or fleet hauler when required.
            */
        }
    }

    // **Use Case: Dock and Undock from Stations**
    use case def DockAndUndock {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor station : Domain::Station;

        objective {
            doc /*
            * The Mining Frigate Hull shall support docking and undocking operations at stations or other docking structures.
            */
        }
    }

    // **Use Case: Manage Energy Supply and Recharge**
    use case def ManageEnergy {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor smallCapBatteryI : SmallCapBatteryI;

        objective {
            doc /*
            * The Mining Frigate Hull shall ensure energy balance through capacitor recharge mechanisms.
            */
        }
    }

    // **Use Case: Support High, Medium, and Low Slot Modules**
    use case def SupportModuleFitting {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor miningLaser : MinerI;

        objective {
            doc /*
            * The Mining Frigate Hull shall host configurable module slots for different mission profiles.
            */
        }
    }

    // **Use Case Definition: Detect Threat**
    use case def DetectThreat {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;

        objective {
            doc /*
            * The Mining Frigate Hull shall scan for incoming threats using onboard sensors 
            * and provide a warning to the pilot.
            */
        }
    }

    // **Use Case Definition: Engage Defenses**
    use case def EngageDefenses {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor hostileShip : Domain::HostileShip;

        objective {
            doc /*
            * The Mining Frigate Hull shall activate defensive systems to mitigate threats, 
            * including shield hardeners, warp core stabilizers, or evasive maneuvers.
            */
        }
    }

    // **Use Case Definition: Navigate to Destination**
    use case def NavigateToDestination {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;

        objective {
            doc /*
            * The Mining Frigate Hull shall navigate between waypoints or target destinations 
            * using the ship’s navigation system.
            */
        }
    }

    // **Use Case Definition: Transfer Ore**
    use case def TransferOre {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor station : Domain::Station;

        objective {
            doc /*
            * The Mining Frigate Hull shall transfer stored ore to a station or hauler for processing or sale.
            */
        }
    }

    // **Use Case Definition: Dock at Station**
    use case def DockAtStation {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor station : Domain::Station;

        objective {
            doc /*
            * The Mining Frigate Hull shall dock at a station or structure to enable refueling, 
            * maintenance, and ore transfer.
            */
        }
    }

    // **Use Case Definition: Resupply Capacitor**
    use case def ResupplyCapacitor {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor smallCapBatteryI : SmallCapBatteryI;

        objective {
            doc /*
            * The Mining Frigate Hull shall replenish its capacitor charge using passive recharge or capacitor boosters.
            */
        }
    }

    // **Use Case Definition: Activate Mining Laser**
    use case def ActivateMiningLaser {
        subject hull : MiningFrigateHull;
        actor pilotPod : Domain::PilotPod;
        actor miningLaser : MinerI;

        objective {
            doc /*
            * The Mining Frigate Hull shall activate its mining laser to extract ore from asteroids.
            */
        }
    }
}
