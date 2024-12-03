package DroneModelLogical{

    library package Drone_SharedAssetsSuperset {


        package Drone {

            import DroneBattery::**;
            import DroneEngine::**;
            import DroneBody::**;
            import DroneFlightControl::**;  

            abstract part def Drone {

                // Attributes
                attribute massActual : ISQ::MassValue;


                // Spatial extent
                item :>> shape = body.shape;
                item boundingBox :> boundingShapes = body.boundingBox;

                // Timeslices            
                timeslice parking {
                    snapshot startCharging {
                        // model some start charging conditions
                    }
                    then snapshot stopCharging;
                }
                then timeslice flying {
                    :>> battery[1];
                }

                // States
                state droneStates {
                    entry; then off;

                    state off;
                    accept SigSwitchOn then standBy;
                    state standBy;
                    accept SigSwitchOff then off;
                    transition standBy_charging
                        first standBy
                        accept SigStartCharging
                        then charging;
                    transition standBy_ready 
                        first standBy
                        accept SigActivate
                        then ready;
                    state charging;
                        transition charging_standBy
                            first charging
                            accept SigStopCharging
                            then standBy;
                    state ready;
                    accept SigDeactivate then standBy;
                    transition ready_flying
                        first ready
                        accept SigStartFlying 
                        then flying;

                    state flying;    
                    accept SigStopFlying then ready;
                }

                // Signals
                attribute def SigStartCharging;
                attribute def SigStopCharging;
                attribute def SigSwitchOn;
                attribute def SigSwitchOff;
                attribute def SigActivate;
                attribute def SigDeactivate;
                attribute def SigStartFlying;
                attribute def SigStopFlying;

                // Power
                part battery : DroneBatteryVariation;
                message notifyBatteryLow of SigBatteryLow from battery.batteryManagementSystem to flightControl;

                part charger;
                part powerManagementModule {
                    port ctrlPort {
                        out attribute status : BatteryCapacityKind;
                    }

                    perform action checkStatus {
                        out attribute status : BatteryCapacityKind;

                        first start;
                        then action getBatteryStatus;
                        then action analyseStatus;
                        then done;
                    } 
                }

                // Engines
                variation attribute numberOfEnginesVariation : ScalarValues::Integer {
                    variant attribute fourEngines = 4;
                    variant attribute sixEngines = 6;
                }
                part engines[numberOfEnginesVariation] : DroneEngine;

                // Body
                part body : DroneBodyVariation;

                // Flight Control System
                part flightControl : FlightControlVariation;
                part droneControlUnit {
                    port powerCtrlPort {
                        in attribute batteryStatus : BatteryCapacityKind;
                    }
                }

                part safetyModule[*];
                part autonomousFlightModules[*];

                part gpsModule;
                part inertialMeasurementUnit;
                part barometer;         

                // Communication System
                part radioTransmitter;
                part radioReceiver;
                part antenna;

                // Sensors
                part camera;
                part obstacleAvoidanceSensor;

                // Connections
                connect droneControlUnit.powerCtrlPort to powerManagementModule.ctrlPort;
                connect battery to powerManagementModule;
            }


        }

        //
        // Drone Engine Shared Assets
        //
        package DroneEngine {

            package DroneEngine_StakeholderRequirements {

                import DroneEngine_Parts::*;

                variation requirement droneEngineStakeholderRequirements {
                    variant requirement droneEngineStandardStakeholderRequirements {

                        subject engine : DroneEngine;

                        requirement power : Power;
                        requirement efficiency : Efficiency;
                        requirement durability : Durability;
                        requirement reliability : Reliability;
                        requirement lightweight : Lightweight;
                        requirement control : Control;
                        requirement compatibility : Compatibility;
                        requirement safety : Safety;
                        requirement costEffective : CostEffective;
                    }
                    variant requirement droneEngineLowNoiseStakeholderRequirements :> droneEngineStandardStakeholderRequirements {
                        requirement lowNoise : LowNoise;
                    }
                }

                requirement def <'DE-REQ-1'> Power {
                    doc /*
                        * The engine shall provide enough power to lift the drone off the ground and keep it in the air. 
                        * The power output shall be appropriate for the size and weight of the drone.
                        */
                }
                requirement def <'DE-REQ-2'> Efficiency {
                    doc /*
                        * The engine shall be efficient, allowing the drone to fly for an extended period on a single charge. 
                        * The engine shall be designed to minimize energy loss through friction and heat.
                        */
                }
                requirement def <'DE-REQ-3'> Durability {
                    doc /*
                        * The engine shall be able to withstand the stress of continuous use and exposure to the elements. 
                        * It shall be able to operate in a wide range of temperatures and weather conditions.
                        */
                }
                requirement def <'DE-REQ-4'> Reliability {
                    doc /*
                        * The engine shall be reliable, with minimal downtime or maintenance requirements. 
                        * It shall be designed with high-quality components and undergo rigorous testing before deployment.
                        */
                }
                requirement def <'DE-REQ-5'> LowNoise {
                    doc /*
                        * The engine shall produce minimal noise to avoid disturbing the environment or attracting unwanted attention.
                        */
                }
                requirement def <'DE-REQ-6'> Lightweight {
                    doc /*
                        * The engine shall be lightweight, allowing for maximum payload capacity and longer flight times.
                        */
                }
                requirement def <'DE-REQ-7'> Control {
                    doc /*
                        * The engine shall be easy to control, allowing for precise maneuverability and responsiveness to commands.
                        */
                }
                requirement def <'DE-REQ-8'> Compatibility {
                    doc /*
                        * The engine shall be compatible with the drone's power supply and electronic components.
                        */
                }
                requirement def <'DE-REQ-9'> Safety {
                    doc /*
                        * The engine should be designed with safety in mind, minimizing the risk of injury or damage in case of malfunction. 
                        * It should have fail-safe mechanisms to prevent accidents and minimize damage in case of emergency.
                        */
                }
                requirement def <'DE-REQ-10'> CostEffective {
                    doc /*
                        * The engine shall be cost-effective, balancing performance and quality with affordability. 
                        * It shall provide value for money, with a low cost of ownership and maintenance.            
                        */
                }            
            }

            package DroneEngine_Parts {
                part def DroneEngine {
                    enum propKind : PropKind;

                    enum def PropKind {
                        enum clockwise;
                        enum counterclockwise;
                    }            
                }
            }                        
        }

        //
        // Drone Body Shared Assets
        //
        package DroneBody {

            package DroneBody_Parts {

                import DroneBody_Domain::*;

                variation part def DroneBodyVariation :> DroneBody {
                    variant part droneBody4Engines : DroneBody {
                        // to be done: redefines size
                        :>> rotors[4];
                        :>> arms[4];
                    }
                    variant part droneBody6Engines : DroneBody {
                        // to be done: redefines size
                        :>> rotors[6];
                        :>> arms[6];
                    }
                }            

                abstract part def DroneBody {
                    // Spatial extent
                    item :>> shape : ShapeItems::Cylinder {
                        :>> height = 20 [SI::cm];
                        :>> base.shape : ShapeItems::Circle {
                            :>> radius = 60 [SI::cm];
                        }
                    }
                    item boundingBox : ShapeItems::Box [1] :> boundingShapes {
                        :>> length = 120 [SI::cm];
                        :>> width  = 120 [SI::cm];
                        :>> height = 20 [SI::cm];
                    }            

                    // BodyColorKind is an enumeration definition which is already a kind of variation
                    attribute bodyColor : BodyColorKind {
                        enum redColor redefines red {
                        }
                        enum whiteColor redefines white {
                        }
                        enum blueColor redefines blue {
                        }
                        enum blackColor redefines black {
                        }
                    }    

                    part rotors[*];
                    part arms[*];
                    part landingGear;
                }
            }

            package DroneBody_Domain {            
                enum def BodyColorKind {
                    enum red;
                    enum white;
                    enum blue;
                    enum black;
                }
            }
        }


        //
        // Drone Flight Control Software Shared Assets
        //
        package DroneFlightControl {

            variation part def FlightControlVariation :> DroneFlightControl {
                variant part droneFlightControl4Engines : DroneFlightControl {
                }
                variant part droneFlightControl6Engines : DroneFlightControl {
                }
            }
            abstract part def DroneFlightControl;
        }

        //
        // Drone Battery Shared Assets
        //     
        package DroneBattery {

            package DroneBattery_Domain {
                attribute def SigBatteryLow {
                    attribute capacity : ISQElectromagnetism::ElectricChargeValue;
                }
            }

            package DroneBattery_Parts {

                variation part def DroneBatteryVariation :> DroneBattery {
                    variant part standardBattery : StandardDroneBattery {
                    }
                    variant part longDistanceBattery : LongDistanceDroneBattery {
                    }
                }            

                abstract part def DroneBattery {
                    // Attributes
                    attribute weight : ISQBase::MassValue; 
                    attribute maxCapacity : ISQElectromagnetism::ElectricChargeValue;
                    enum currentCapacityLevel : BatteryCapacityKind;
                    enum def BatteryCapacityKind :> ScalarValues::Integer {
                        enum full = 100;
                        enum medium = 50;
                        enum low = 30;
                        enum critical = 15;
                    }

                    // Parts
                    part batteryCells {
                        doc /* The battery cells are the main components of the drone battery 
                             * that store the electrical energy. These cells are usually Lithium Polymer (LiPo) 
                             * or Lithium-Ion (Li-Ion) cells.
                            */
                    }
                    part batteryManagementSystem {
                        doc /* The Battery Management System (BMS) is a control unit that manages the charging and 
                             * discharging of the battery cells. It ensures that the cells are charged and discharged 
                             * correctly and safely.
                             */
                    }
                    part protectionCircuit {
                        doc /* The protection circuit is a safety mechanism that protects the battery from overcharging, 
                             * over-discharging, and short circuits.
                            */
                    }
                    part powerConnector {
                        doc /* The power connector is the interface that connects the battery to the drone's power system. 
                            * It delivers the electrical energy from the battery to the drone.
                            */
                    }
                    part chargingInterface {
                        doc /* The charging interface is the interface that connects the battery to the charger. 
                             * It allows the battery to be charged safely and efficiently.
                            */
                    }
                    part batteryIndicator {
                        doc /* The battery indicator is a component that displays the remaining battery charge. 
                             * It allows the pilot to monitor the battery level and plan flight time accordingly.
                            */
                    }
                    part communicationInterface {
                        doc /* The communication interface is a component that allows the battery to communicate 
                             * with the drone's flight controller. It provides important battery information such 
                             * as voltage, current, and temperature to the flight controller.
                            */
                        }
                    part firmware {
                        doc /* The firmware is the software that runs on the battery management system. 
                             * It controls the charging and discharging of the battery cells and ensures 
                             * that the battery operates safely and efficiently.
                            */
                    }
                }

                part def StandardDroneBattery :> DroneBattery {
                    :>> weight = 275[SI::g];
                    :>> maxCapacity = 13680[SI::'C'];
                }
                part def LongDistanceDroneBattery :> DroneBattery {
                    :>> weight = 315[SI::g];
                    :>> maxCapacity = 18000[SI::'C'];
                }
            }

        }    
    }


    package ForestFireObservationDrone {

        import Drone_SharedAssetsSuperset::**;

        part forestFireObservationDrone : Drone {

            //
            // Variant selections
            //

            // numberOfEngines
            :>> numberOfEnginesVariation = numberOfEnginesVariation::sixEngines;
            :>> body = DroneBodyVariation::droneBody6Engines {
                :>> bodyColor = bodyColor.redColor;
            }
            :>> flightControl = FlightControlVariation::droneFlightControl4Engines;

            // Battery
            :>> battery = DroneBatteryVariation::longDistanceBattery;       

            // safetyFeatures
            // autonomousFlight

            // Engine
            part engine1 :> engines {
                :>> propKind = PropKind::clockwise;
            }
            part engine2 :> engines {
                :>> propKind = PropKind::counterclockwise;
            }
            part engine3 :> engines {
                :>> propKind = PropKind::clockwise;
            }        
            part engine4 :> engines {
                :>> propKind = PropKind::counterclockwise;
            }

            // Connections
            connect powerManagementModule to engine1;
            connect powerManagementModule to engine2;
            connect powerManagementModule to engine3;
            connect powerManagementModule to engine4;                    
        }
    }

}

