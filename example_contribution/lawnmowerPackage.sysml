package lawnmowerPackage {

item def Force;
attribute def EngineMass;
attribute def DeckMass;



part lawnmower {
    doc /*This is the lawnmower model A assembly */
        
    action cutgrass {
        first start;
        then action 'Start Engine';
        then action 'Push mower';
        then action 'Shutoff mower';
        then done;
    }
    part engine : Engine {
        doc /*This is the engine usage */
        attribute redefines engineMass = 190;
    }
    part blade : Blade;
    part deck : Deck {
        attribute redefines deckMass = 50;
    }
    part frontLeftWheel[1] : Wheel;
    part frontRightWheel[1] : Wheel;
    part rearLeftWheel[1] : Wheel;
    part rearRightWheel[1] : Wheel;
    part handle;
    
    connect engine to deck;
    connect engine to blade;
    connection frontLeftPin connect deck to frontLeftWheel;
    connection frontRightPin connect deck to frontRightWheel;
    connection rearLeftPin connect deck to rearLeftWheel;
    connection rearRightPin connect deck to rearRightWheel;
    connect deck to handle;
}

port def ForcePort {
    out force : Force;
}

part def Engine {
    doc /*This is the Engine definition*/
    attribute engineMass : EngineMass;
    attribute BlockMaterial = "Iron";
    attribute MinimumOperatingTemp = 0;
    part piston : Piston {
        port pistonPort : ForcePort;
        port cylinderPort : ~ForcePort;
    }
    part connectingRod : ConnectingRod {
        port connectingRodPort : ~ForcePort;
        port connectingRodCrankPort : ForcePort;
    }
    part crankshaft {
        attribute Mass = 5;
        port crankshaftPort : ~ForcePort;
        port crankshaftBearingPort : ForcePort;
    }
    part crankshaftBearing {
        attribute Mass = 2;
        port bearingPort : ~ForcePort;
        port bearingBlockPort : ForcePort;
    }
    part engineBlock {
        attribute Mass = 6;
        port engineBlockPort : ~ForcePort;
        port cylinderPort : ForcePort;
    }
    
        

    connection e1 connect piston.pistonPort to connectingRod.connectingRodPort;
    connection e2 connect connectingRod.connectingRodCrankPort to crankshaft.crankshaftPort;
    connection e3 connect crankshaft.crankshaftBearingPort to crankshaftBearing.bearingPort;
    connection e4 connect crankshaftBearing.bearingBlockPort to engineBlock.engineBlockPort;
    connection e5 connect engineBlock.cylinderPort to piston.cylinderPort;
}

part def Wheel {
        part rim : Rim;
        part tire : Tire;
}

part def Rim {
    attribute Diameter = 5;
    attribute Width = 2;
    attribute Mass = 4;
}

part def Tire {
    attribute Tread = "standard";
    attribute Mass = 5;
}

part def Blade {
    attribute Diameter = 24;
    attribute Mass = 5;
}

part def Deck {
    attribute Color = "Blue";
    attribute deckMass : DeckMass;
}

part def ConnectingRod {
    variation part rodBolt[2] {
    variant part rodBoltA {
        attribute Mass = 2.5;
        attribute Length = 2;
        attribute Material = "Steel";
    }
    variant part rodBoltB {  
        attribute Mass = 2.0;
        attribute Length = 2;
        attribute Material = "Aluminum";
    }
    }
}

part def Piston {
    attribute Diameter = 1;
    attribute Mass = 3;
}
/*
requirement <'REQ-1234'> EngineTotalMass {
    subject engineMass :>> lawnmower.engine;        
    assert constraint {
            engine.engineMass <= 200;
        }
} */
}