package MiningCorporationRequirementsDecl {

    private import Domain::*;
    private import ScalarValues::*;
    private import MiningCorporationRequirementsDef::*;  

    // **Mining Corporation Requirement Declarations**
    requirement <MCR01_1> profitabilityRequirement : ProfitabilityRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> minimumProfit = miningCorporation.minimumProfit;
    }

    requirement <MCR02_1> fleetUtilizationRequirement : FleetUtilizationRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> fleetUtilization = miningCorporation.fleetUtilization;
    }

    requirement <MCR03_1> oreExtractionRequirement : OreExtractionRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> oreExtractionRate = miningCorporation.oreExtractionEfficiency;
    }

    requirement <MCR04_1> oreDeliveryEfficiencyRequirement : OreDeliveryEfficiencyRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> oreDeliveryTime = miningCorporation.oreDeliveryEfficiency;
    }

    requirement <MCR05_1> storageCapacityRequirement : StorageCapacityRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> oreStorageCapacity = miningCorporation.storageCapacityUtilization;
    }

    requirement <MCR06_1> fleetSizeRequirement : FleetSizeRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> fleetSize = miningCorporation.fleetSizeEffectiveness;
    }

    requirement <MCR07_1> defenseCapabilityRequirement : DefenseCapabilityRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> securityEscortCoverage = miningCorporation.securityCoverageEffectiveness;
    }

    requirement <MCR08_1> threatResponseTimeRequirement : ThreatResponseTimeRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> threatResponseTime = miningCorporation.threatResponseEffectiveness;
    }

    requirement <MCR09_1> operationalUptimeRequirement : OperationalUptimeRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> operationalUptime = miningCorporation.operationalUptime;
    }

    requirement <MCR10_1> deploymentEfficiencyRequirement : DeploymentEfficiencyRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> deploymentEfficiency = miningCorporation.deploymentEfficiency;
    }

    requirement <MCR11_1> operationalCostControlRequirement : OperationalCostControlRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> operationalCosts = miningCorporation.costEfficiency;
    }

    requirement <MCR12_1> marketAdaptabilityRequirement : MarketAdaptabilityRequirement {
        subject miningCorporation : MiningCorporation;
        attribute :>> marketAdaptability = miningCorporation.marketAdaptability;
    }
}
