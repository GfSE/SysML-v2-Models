 package COTS {
 	
 	private import ScalarValues::*;
 	private import StdPortsAndInterfaces::*;
 	private import FrigateRollupAnalysis::*;
 	
 // **COTS Module Definitions with Conjugated Ports**
    
    abstract part def MinerModule :> SimpleFrigateComponent {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        attribute miningYield : Real;
        attribute cycleTime : Real;
        attribute capacitorUsage : Real;
        attribute range : Real;
        redefines mass : Real; 
        redefines powerUsage;

        port highSlot : ~HighSlotPort;
    }
    part def 'EP-S Gaussian Scoped Mining Laser' :> MinerModule {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        redefines miningYield : Real = 50.0;
        redefines cycleTime : Real = 60.0;
        redefines capacitorUsage : Real = 5.0;
        redefines range : Real = 16.0;
        redefines mass : Real = 500.0; // Mass in kg
        redefines powerUsage = 3.0;
    }
    part 'Mining Laser EP-S Gaussian Scoped' : 'EP-S Gaussian Scoped Mining Laser';

    part def MinerI :> MinerModule {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        redefines miningYield : Real = 40.0;
        redefines cycleTime : Real = 60.0;
        redefines capacitorUsage : Real = 5.0;
        redefines range : Real = 10.0;
        redefines mass : Real = 500.0; // Mass in kg
        redefines powerUsage = 2.0;
    }
    part minerI : MinerI;

    part def 'Particle Bore Compact Mining Laser' :> MinerModule {
        doc /* Standard mining laser used on mining frigates for ore extraction. */
        redefines miningYield : Real = 50.0;
        redefines cycleTime : Real = 60.0;
        redefines capacitorUsage : Real = 5.0;
        redefines range : Real = 11.0;
        redefines mass : Real = 500.0; // Mass in kg
        redefines powerUsage = 2.0;
    }
    part 'Mining Laser Particle Bore Compact' : 'Particle Bore Compact Mining Laser';

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