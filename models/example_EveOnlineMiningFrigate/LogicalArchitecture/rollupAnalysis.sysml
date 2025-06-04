package FrigateRollupAnalysis {

    private import ScalarValues::*;
    private import NumericalFunctions::*;
    private import MiningFrigateSolutionSpace::*;

    // **Base Definition for Mass and Power Rollup**
    part def FrigateComponent {
        attribute mass : Real;
        attribute totalMass : Real;
        attribute powerUsage : Real;
        attribute totalPowerUsage : Real;
    }

    // **Simple Component (Directly Contributes to Mass and Power)**
    part def SimpleFrigateComponent :> FrigateComponent {
        attribute redefines totalMass = mass;
        attribute redefines totalPowerUsage = powerUsage;
    }

    // **Composite Component (Rolls Up Mass and Power from Subcomponents)**
    part def CompositeFrigateComponent :> FrigateComponent {
        part subcomponents : FrigateComponent[*];

        attribute redefines totalMass default
            mass + sum(subcomponents.totalMass);

        attribute redefines totalPowerUsage default
            powerUsage + sum(subcomponents.totalPowerUsage);
    }

    // **Derived Calculations**
    // venture.totalMass --> Sum of hull + fitted modules
    // venture.totalPowerUsage --> Sum of all power-consuming modules
}
