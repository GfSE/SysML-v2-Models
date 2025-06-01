package StdPortsAndInterfaces {
	
	private import ScalarValues::*;
	
	// **Port Definitions**
    port def HighSlotPort {
        in power : PowerSupply;
        in control : HighSlotCommand;
    }

    port def MediumSlotPort {
        in power : PowerSupply;
        in control : MediumSlotCommand;
    }

    port def LowSlotPort {
        in control : LowSlotCommand;
    }
	// **Power and Control Interfaces**
    item def PowerSupply {
        attribute energyTransfer : Real;
    }

    item def HighSlotCommand {
        attribute activation : Boolean;
    }

    item def MediumSlotCommand {
        attribute activation : Boolean;
    }

    item def LowSlotCommand {
        attribute activation : Boolean;
    }
    
    // **High Slot Interface (Power + Activation Command)**
    interface def HighSlotInterface {
        end hullPort : HighSlotPort;
        end modulePort : ~HighSlotPort;

        flow of PowerSupply from hullPort.power to modulePort.power;
        flow of HighSlotCommand from hullPort.control to modulePort.control;
    }

    // **Medium Slot Interface (Power + Activation Command)**
    interface def MediumSlotInterface {
        end hullPort : MediumSlotPort;
        end modulePort : ~MediumSlotPort;

        flow of PowerSupply from hullPort.power to modulePort.power;
        flow of MediumSlotCommand from hullPort.control to modulePort.control;
    }

    // **Low Slot Interface (Activation Command Only)**
    interface def LowSlotInterface {
        end hullPort : LowSlotPort;
        end modulePort : ~LowSlotPort;

        flow of LowSlotCommand from hullPort.control to modulePort.control;
    }
}