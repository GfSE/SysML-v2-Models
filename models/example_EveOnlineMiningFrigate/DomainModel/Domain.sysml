package Domain {
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
	private import OperationalUseCaseActions::*;
	private import MiningFrigate::*;
	private import CauseAndEffect::*;
    private import CausationConnections::*;
	

    // Root object for the domain
    part def Domain {
        part pilotPod : PilotPod;
        part asteroidBelt : AsteroidBelt;
        part asteroid : Asteroid [1..*];
        part hostileShip : HostileShip [0..*];
        part station : Station [0..*];
        part miningCorporation: MiningCorporation;
        part drone : Drone[1..*];
    }
    
    part def Spaceship {
    	#mop cargoCapacity : Real;       // Maximum ore cargo capacity (m³)
        #mop survivalProbability : Real; // Probability of surviving an operation (%)
    	attribute mass : Real;
    	attribute status : String;
    	attribute warpSpeed : Real; // AU/s, the warp speed of the frigate (STRQ06)
        attribute warpBubbleEnd : Boolean;
        attribute alignTime : Real; // seconds, the time required to align for warp (STRQ06)
        attribute lockedTargets : Integer; // Number, the maximum number of locked asteroid targets (STRQ07)
        attribute dockingTime : Real; // seconds, the time required to dock and offload ore (STRQ08)
        attribute shieldStrength : Real ; //Strength of the core shield (STRQ03)
    }

    // Definitions of domain objects
  
    part def MiningCorporation {
         #moe minimumProfit : Real {
            doc /* Definition: Total ISK/hour earned after deducting operational costs 
             * (e.g., ship losses, resupply, and maintenance). 
             * Relevance: Profitability is the ultimate measure of success for the corporation. 
             * Optimization: Operate in areas with the best risk-reward balance 
             * (e.g., High Sec for safety, Wormholes or Null Sec for high-value ores). 
             * Avoid overfitting ships in areas with high loss probability 
             * (e.g., Ventures in Wormholes or Low Sec).
             */
        }          // ISK/hour

        #moe fleetUtilization : Real {
            doc /* Definition: The percentage of operational mining frigates deployed per cycle.
             * Relevance: Higher fleet utilization ensures better efficiency and revenue. 
             * Optimization: Maintain an 80%+ utilization rate by minimizing downtime 
             * (e.g., ensure refitting cycles do not overlap with peak mining hours).
             */
        }          // %

        #moe oreExtractionEfficiency : Real {
            doc /* Definition: The amount of ore extracted per operational cycle (m³/cycle). 
             * Relevance: High extraction rates correlate with overall profitability. 
             * Optimization: Use appropriate mining lasers, max fleet bonuses, and optimize asteroid selection.
             */
        }          // m³/cycle

        #moe oreDeliveryEfficiency : Real {
            doc /* Definition: The average delivery time per batch of ore transported (seconds). 
             * Relevance: Faster deliveries reduce market price exposure and downtime. 
             * Optimization: Optimize mining locations closer to station hubs or Rorquals for compression.
             */
        }          // seconds

        #moe storageCapacityUtilization : Real {
            doc /* Definition: The percentage of ore storage capacity currently utilized.
             * Relevance: Ensures effective planning of mining operations to avoid overloading or idling. 
             * Optimization: Expand storage or increase delivery frequency based on utilization rates.
             */
        }          // %

        #moe fleetSizeEffectiveness : Real {
            doc /* Definition: Measures how effectively fleet size contributes to mining efficiency.
             * Relevance: Avoids over-scaling, which could increase operational costs.
             * Optimization: Balance fleet size with profit margins, avoiding unnecessary ship deployment.
             */
        }          // Fleet utilization metric

        #moe securityCoverageEffectiveness : Real {
            doc /* Definition: The percentage of mining operations that have security escort coverage.
             * Relevance: Essential for safe mining in Low Sec, Null Sec, and Wormholes. 
             * Optimization: Maintain at least 30% security coverage in high-risk areas.
             */
        }          // %

        #moe threatResponseEffectiveness : Real {
            doc /* Definition: The average response time to threats during mining operations (seconds).
             * Relevance: Faster response times improve fleet survivability. 
             * Optimization: Deploy scouts and maintain emergency warp-out procedures.
             */
        }          // seconds

        #moe operationalUptime : Real {
            doc /* Definition: The percentage of time the corporation is actively mining and generating revenue.
             * Relevance: Maximizing uptime directly increases profitability.
             * Optimization: Reduce transition times between mining and logistics.
             */
        }          // %

        #moe deploymentEfficiency : Real {
            doc /* Definition: The percentage of planned mining deployments that are executed successfully.
             * Relevance: Higher efficiency reduces logistical delays and improves ROI.
             * Optimization: Standardize deployment protocols and improve scheduling coordination.
             */
        }          // %

        #moe costEfficiency : Real {
            doc /* Definition: The ratio of ISK spent per ISK earned in mining operations.
             * Relevance: Determines operational sustainability and long-term growth. 
             * Optimization: Reduce unnecessary ship/module expenditures while maximizing income sources.
             */
        }          // ISK spent per ISK earned

        #moe marketAdaptability : Real {
            doc /* Definition: The corporation's ability to adapt mining operations to fluctuating ore market prices.
             * Relevance: Avoids mining low-value ores and improves revenue optimization.
             * Optimization: Adjust operations dynamically based on real-time market data.
             */
        }          // %
        
        //exhibits a predefined state
        part miningFrigate : MiningFrigate [1..*] {
        	exhibit miningFrigatesStates {
    			in miningFrigates = miningFrigate; 
    		}
    		// Cause and Effect Occurrences
	        event occurrence MiningRateIncreases;
	        event occurrence CargoCapacityIncreases;
	        event occurrence ShieldStrengthIncreases;
	        event occurrence ThreatDetectionImproves;
	        event occurrence DroneOperationsImprove;
	        event occurrence WarpSpeedIncreases;
	        event occurrence FleetCoordinationImproves;
	
	        event occurrence OreYieldIncreases;
	        event occurrence DowntimeReduces;
	        event occurrence SurvivabilityEnhances;
	        event occurrence ThreatResponseImproves;
	        event occurrence OperationalEfficiencyIncreases;
	        event occurrence OreExtractionEfficiencyIncreases;
	        event occurrence ProfitabilityMaximizes;
	         //The cause-effect relationships
		    #causation connect MiningRateIncreases to OreYieldIncreases;
		    #causation connect CargoCapacityIncreases to DowntimeReduces;
		    #causation connect ShieldStrengthIncreases to SurvivabilityEnhances;
		    #causation connect ThreatDetectionImproves to ThreatResponseImproves;
		    #causation connect DroneOperationsImprove to OperationalEfficiencyIncreases;
		    #causation connect WarpSpeedIncreases to DowntimeReduces;
		    #causation connect FleetCoordinationImproves to OperationalEfficiencyIncreases;
		
		    #multicausation connection {
		        end #cause ::> OreYieldIncreases;
		        end #cause ::> DowntimeReduces;
		        end #effect ::> OreExtractionEfficiencyIncreases;
		    }
		
		    #multicausation connection {
		        end #cause ::> SurvivabilityEnhances;
		        end #cause ::> ThreatResponseImproves;
		        end #effect ::> OperationalEfficiencyIncreases;
		    }
		
		    #multicausation connection {
		        end #cause ::> OperationalEfficiencyIncreases;
		        end #cause ::> OreExtractionEfficiencyIncreases;
		        end #effect ::> ProfitabilityMaximizes;
		    }
        }
        part rorqual : Rorqual [1..*];
        ref part pilotPod : PilotPod [1..*] ;
        part fleet : Fleet [1..*];
        
        //interactions at the enterprise level
        occurrence def MiningAsteroid {
        	doc /* Interaction from Main Use Case: Mining Asteroid */
     	    	
        	message targetSignature of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
        	then message destinationReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
        	then message miningCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
        	then message miningReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
        	
        }
        
        occurrence def PlotCourseAndNavigate {
        	doc /* Interaction from Main Use Case definition : Plot Course and Navigate */
        	
        	message undockCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
        	then message targetSignature of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
        	then message destinationReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
        	then message warpCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
        	then message warpReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
        }
        
	    occurrence def DeployDrones {
	        doc /* Interaction from Main Use Case: Deploy Drones */
	
	        message droneSelectionCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
	        then message droneSelectionReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
	        then message droneDeploymentCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
	        then message droneStatusReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
	        then message engageDefenseCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
	        then message defenseStatusReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
	    }
	
	    occurrence def OffloadOreAndResupply {
	        doc /* Interaction from Main Use Case: Offload Ore and Resupply */
	
	        message dockCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
	        then message dockingReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
	        then message unloadCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
	        then message storageReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
	        then message warehouseStatusCommand of StationCommand from pilotPod.controlPort to miningFrigate.controlPort ; //Station comms are relayerd through the ship
        	then message warehouseReport of StationReport from miningFrigate.controlPort to pilotPod.controlPort ; //Station comms are relayerd through the ship
	        then message resupplyRequest of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort ;
	        then message resupplyConfirmation of ShipReport from miningFrigate.controlPort to pilotPod.controlPort ;
	    }      
    }
    
    // parts of the domain
    part def PilotPod {
        attribute experienceLevel : String;
        attribute controlEfficiency : Real;         // Efficiency of command execution (%)
        #mop situationalAwareness : Real;      // Ability to detect threats and manage operations (%)
        attribute fleetSize: Real ;
        part controlConsole: ControlConsole;
        part lifeSupportSystem: LifeSupportSystem;
        port controlPort: PodPort;
    }

    part def ControlConsole {
        attribute interfaceType: String;
    }
    
    part def Fleet {
        ref part fleetCommander : PilotPod [1..*];
    }
    
    part def LifeSupportSystem {
        attribute oxygenLevel: Real;
        attribute temperatureControl: Boolean;
    }
    
    part def Rorqual :> Spaceship {
        #mop oreStorageCapacity : Real; //Rorquals can tractor and store storage containers
        part oreCompressionUnit : OreCompressionUnit; //Module used to compress Ores
    }
    
    part def OreCompressionUnit {
    	attribute compressionFactor : Real;      // Compression factor
    }
    
    
    part def AsteroidBelt {
    	#mop resourceAvailability : Real;      // Total available ore in the belt (m³)
        part asteroids : Asteroid [1..*];
    }

    part def Asteroid {
    	#mop oreContent : Real;                // Quantity of ore available (m³)
        #mop depletionRate : Real;             // Rate at which ore is extracted (m³/hour)
        port asteroidOrePort : AsteroidOrePort;
    }

    part def HostileShip {
    	#mop attackProbability : Real;         // Probability of engaging the mining frigate (%)
        #mop weaponStrength : Real;            // Damage potential of weapons (DPS)
        attribute threatLevel : String;
        attribute weaponType : String;
        port weaponPort : ThreatPort;
    }

    part def Station {
        attribute dockingCapacity : Integer;
        attribute location : String;
        port dockingPort: ~DockingPort;
    }
    
    part def Drone {
        attribute type : String;
        attribute size : String;
        port droneControlPort: DroneControllerPort;
    }
	
	// Port definitions
	port def PodPort {
		in item shipReport : ShipReport;
		out item command : ShipCommand;
	}
	
	port def DockingPort {
		in item charge : Power;
		out item cargo : CargoContainer;
	}
	
	port def AsteroidOrePort {
		out item ore : Ore;
	}

	port def ThreatPort {
		out item firePower : FirePower;
	}
	
	port def DroneControllerPort {
		in item droneCommand : DroneCommand;
		out item droneReport : DroneReport;
	}	
	
	// Interface definition
    interface def CommandIF {
        end controlSend : PodPort;
        end controlReceive : ~PodPort;
        //flows are defined within the interface
        flow of ShipCommand from controlSend.command to controlReceive.command;
        flow of ShipReport from controlReceive.shipReport to controlSend.shipReport;
    }
    
	interface def PowerDockIF {
        end shipDockingPort : DockingPort;
        end stationDockingPort : ~DockingPort;
        flow of Power from stationDockingPort.power to shipDockingPort.power;
        flow of CargoContainer from shipDockingPort.cargo to stationDockingPort.cargo;      
    }
	interface def AsteroidOreIF {
        end shipOrePort : ~AsteroidOrePort;
        end asteroidOrePort : AsteroidOrePort;
        flow of Ore from asteroidOrePort.ore to shipOrePort.ore;     
    }    
	interface def ThreatIF {
        end threadIncomingPort : ~ThreatPort;
        end threatOutgoingPort : ThreatPort;
        flow of FirePower from threatOutgoingPort.firePower to threadIncomingPort.firePower;     
    }
    interface def DroneIF {
        end droneControllerPort : ~DroneControllerPort;
        end droneControllPort : DroneControllerPort;
        flow of DroneCommand from droneControllerPort.droneCommand to droneControllPort.droneCommand;
        flow of DroneReport from droneControllPort.droneReport to droneControllerPort.droneReport;     
    }     
    
    
    // Items that Flow Between Domain Objects
    item def ShipCommand {
        attribute type: String;
    }
    
    item def StationCommand {
        attribute type: String;
    }
    
    item def DroneCommand :> ShipCommand {
        attribute droneID: String;
    }    

    item def Ore {
        attribute purity : Real;
        attribute quantity : Real;
    }

    item def FirePower {
        attribute type : String;
        attribute strenght : String;
    }

    item def CargoContainer {
        attribute type : String;
        attribute weight : Real;
    }

    item def Power {
        attribute type : String;
        attribute quantity : Real;
    }
    
    item def ShipReport{
    	attribute type: String;
    }
    
    item def StationReport{
    	attribute type: String;
    }
    
    item def DroneReport :> ShipReport {
    	attribute DroneID: String;
    }
    
    item def Course {
        attribute waypoints: String;
        attribute distance: Real;
    }

    item def ScanSignature {
        attribute type: String;
        attribute priority: String;
    }   
}