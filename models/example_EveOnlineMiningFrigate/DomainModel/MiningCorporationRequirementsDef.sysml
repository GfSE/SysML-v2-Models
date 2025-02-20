package MiningCorporationRequirementsDef {

    private import Domain::*;
    private import ScalarValues::*;
    private import StakeholderConcerns::*;

        // **Economic and Profitability Requirements**
        requirement def <MCRQ01> ProfitabilityRequirement {
            doc /* The mining corporation shall maintain an average profitability of at least 500M ISK per operational cycle, 
                   considering ore market value, operational costs, and risk-adjusted returns. */
            subject miningCorporation : MiningCorporation;
            attribute minimumProfit : Real;
            require constraint { minimumProfit >= 500000000.0 } // ISK
            
            frame concern TotalProfitabilityConcern;
            frame concern RiskAdjustedProfitabilityConcern;
        }

        requirement def <MCRQ02> FleetUtilizationRequirement {
            doc /* The mining corporation shall maintain a fleet utilization rate of at least 80% to ensure high operational efficiency. */
            subject miningCorporation : MiningCorporation;
            attribute fleetUtilization : Real;
            require constraint { fleetUtilization >= 80.0 } // %

            frame concern FleetDeploymentEfficiencyConcern;
        }

        // **Resource Extraction and Logistics Requirements**
        requirement def <MCRQ03> OreExtractionRequirement {
            doc /* The mining corporation shall extract at least 1,000,000 m³ of ore per operational cycle. */
            subject miningCorporation : MiningCorporation;
            attribute oreExtractionRate : Real;
            require constraint { oreExtractionRate >= 1000000.0 } // m³/cycle

            frame concern OreYieldConcern;
        }

        requirement def <MCRQ04> OreDeliveryEfficiencyRequirement {
            doc /* The mining corporation shall ensure an average ore delivery time of no more than 30 minutes per batch. */
            subject miningCorporation : MiningCorporation;
            attribute oreDeliveryTime : Real;
            require constraint { oreDeliveryTime <= 1800.0 } // seconds

            frame concern OreDeliveryEfficiencyConcern;
        }

        requirement def <MCRQ05> StorageCapacityRequirement {
            doc /* The mining corporation shall maintain a minimum ore storage capacity of 10,000,000 m³ to accommodate mining operations. */
            subject miningCorporation : MiningCorporation;
            attribute oreStorageCapacity : Real;
            require constraint { oreStorageCapacity >= 10000000.0 } // m³

            frame concern ResourceAvailabilityConcern;
        }

        // **Fleet and Security Requirements**
        requirement def <MCRQ06> FleetSizeRequirement {
            doc /* The mining corporation shall operate a fleet of at least 10 mining frigates per operational cycle. */
            subject miningCorporation : MiningCorporation;
            attribute fleetSize : Integer;
            require constraint { fleetSize >= 10 }

            frame concern ScalabilityConcern;
        }

        requirement def <MCRQ07> DefenseCapabilityRequirement {
            doc /* The mining corporation shall ensure that at least 30% of mining operations have security escort coverage in Low Sec and Null Sec. */
            subject miningCorporation : MiningCorporation;
            attribute securityEscortCoverage : Real;
            require constraint { securityEscortCoverage >= 30.0 } // %

            frame concern SecurityConcern;
        }

        requirement def <MCRQ08> ThreatResponseTimeRequirement {
            doc /* The mining corporation shall ensure that threat response time does not exceed 60 seconds in Low Sec and Null Sec. */
            subject miningCorporation : MiningCorporation;
            attribute threatResponseTime : Real;
            require constraint { threatResponseTime <= 60.0 } // seconds

            frame concern ThreatNeutralizationConcern;
        }

        // **Operational Uptime and Efficiency**
        requirement def <MCRQ09> OperationalUptimeRequirement {
            doc /* The mining corporation shall maintain an operational uptime of at least 85% per cycle. */
            subject miningCorporation : MiningCorporation;
            attribute operationalUptime : Real;
            require constraint { operationalUptime >= 85.0 } // %

            frame concern DeploymentEfficiencyConcern;
        }

        requirement def <MCRQ10> DeploymentEfficiencyRequirement {
            doc /* The mining corporation shall ensure that at least 90% of planned mining deployments are executed successfully. */
            subject miningCorporation : MiningCorporation;
            attribute deploymentEfficiency : Real;
            require constraint { deploymentEfficiency >= 90.0 } // %

            frame concern DeploymentEfficiencyConcern;
        }

        requirement def <MCRQ11> OperationalCostControlRequirement {
            doc /* The mining corporation shall minimize operational costs to improve long-term profitability. */
            subject miningCorporation : MiningCorporation;
            attribute operationalCosts : Real;
            require constraint { operationalCosts <= 2000000000.0 } // ISK per month

            frame concern OperationalCostsConcern;
        }

        requirement def <MCRQ12> MarketAdaptabilityRequirement {
            doc /* The mining corporation shall adapt its mining operations based on fluctuating ore prices. */
            subject miningCorporation : MiningCorporation;
            attribute marketAdaptability : Real;
            require constraint { marketAdaptability >= 75.0 } // %

            frame concern MarketResponsivenessConcern;
        }
    
}
    