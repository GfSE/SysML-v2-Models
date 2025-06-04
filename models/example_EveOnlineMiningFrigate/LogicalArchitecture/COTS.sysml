 package COTS {
 	
 	private import ScalarValues::*;
 	private import StdPortsAndInterfaces::*;
 	private import FrigateRollupAnalysis::*;
 	
 // **COTS Module Definitions with Conjugated Ports**
    
    part def MinerI :> SimpleFrigateComponent {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        attribute miningYield : Real = 40.0;
        attribute cycleTime : Real = 60.0;
        attribute capacitorUsage : Real = 5.0;
        redefines mass : Real = 500.0; // Mass in kg
        redefines powerUsage = 5.0;

        port highSlot : ~HighSlotPort;
    }
    
    part def Afterburner :> SimpleFrigateComponent {
        doc /* Improves sublight speed by increasing thrust. */
        attribute velocityBonus : Real = 112.5;
        attribute activationCost : Real = 20.0;
        attribute cycleTime : Real = 10.0;
        redefines mass : Real = 1000.0; // Mass in kg
        redefines powerUsage = 20.0;

        port mediumSlot : ~MediumSlotPort;
    }

    part def SmallShieldExtenderI :> SimpleFrigateComponent {
        doc /* Increases shield capacity for additional survivability. */
        attribute shieldHPBonus : Real = 262.0;
        attribute signatureRadiusIncrease : Real = 12.0;
        redefines mass : Real = 1500.0; // Mass in kg
        redefines powerUsage = 5.0;

        port mediumSlot : ~MediumSlotPort;
    }

    part def SmallCapBatteryI :> SimpleFrigateComponent {
        doc /* Improves capacitor recharge and overall energy stability. */
        attribute capacitorBonus : Real = 125.0;
        attribute rechargeMultiplier : Real = 1.2;
        redefines mass : Real = 800.0; // Mass in kg
        redefines powerUsage = 0.0;

        port mediumSlot : ~MediumSlotPort;
    }

    part def SurveyScannerI :> SimpleFrigateComponent {
        doc /* Scans asteroids to determine ore content before mining. */
        attribute scanRange : Real = 15000.0;
        attribute cycleTime : Real = 5.0;
        redefines mass : Real = 500.0; // Mass in kg
        redefines powerUsage = 2.0;

        port mediumSlot : ~MediumSlotPort;
    }

    part def WarpCoreStabilizerI :> SimpleFrigateComponent {
        doc /* Improves resistance against warp disruption (scramblers and disruptors). */
        attribute warpCoreStrengthBonus : Integer = 1;
        attribute targetingPenalty : Real = -40.0;
        attribute scanResolutionPenalty : Real = -10.0;
        redefines mass : Real = 2000.0; // Mass in kg
        redefines powerUsage = 0.0;

        port lowSlot : ~LowSlotPort;
    }
}