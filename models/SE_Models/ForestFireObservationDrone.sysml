package ForestFireObservationDrone {
    
    import Drone_SharedAssetsSuperset::**;
    
    part forestFireObservationDrone : Drone {
        
        // Power System
        :>> battery = DroneBatteryVariation::longDistanceBattery;
        
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

        // Flight Control System
        part droneControlUnit {
            port powerCtrlPort {
                in attribute batteryStatus : BatteryCapacityKind;
            }
        }
        part gpsModule;
        part inertialMeasurementUnit;
        part barometer;
        
        // Drone Frame
        part body;
        part rotors[4];
        part arms[4];
        part landingGear;
        
        // Communication System
        part radioTransmitter;
        part radioReceiver;
        part antenna;
        
        // Sensors
        part camera;
        part obstacleAvoidanceSensor;
        
        // Engine
        part engine1 : DroneEngine {
            :>> propKind = PropKind::clockwise;
        }
        part engine2 : DroneEngine {
            :>> propKind = PropKind::counterclockwise;
        }
        part engine3 : DroneEngine {
            :>> propKind = PropKind::clockwise;
        }        
        part engine4 : DroneEngine {
            :>> propKind = PropKind::counterclockwise;
        }
        
        // Connections
        connect droneControlUnit.powerCtrlPort to powerManagementModule.ctrlPort;
        connect battery to powerManagementModule;
        connect powerManagementModule to engine1;
        connect powerManagementModule to engine2;
        connect powerManagementModule to engine3;
        connect powerManagementModule to engine4;                    
    }
}