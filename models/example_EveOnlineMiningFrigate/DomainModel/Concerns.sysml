package StakeholdersDef {

    // Stakeholder Definitions
    part def MiningCEO {
        doc /* The Mining CEO is responsible for ensuring profitability, managing overall 
               corporate strategy, and balancing operational risks with rewards. */
    }

    part def OperationsManager {
        doc /* The Operations Manager is responsible for minimizing operational costs, 
               optimizing deployment efficiency, and ensuring smooth ore delivery processes. */
    }

    part def FleetCommander {
        doc /* The Fleet Commander is responsible for managing fleet operations, ensuring 
               scalability, fleet survivability, and neutralizing threats in hostile environments. */
    }

    part def ShipEngineer {
        doc /* The Ship Engineer focuses on ship survivability, performance optimization, 
               and ensuring Mining Frigates can handle hostile environments effectively. */
    }

    part def MarketAnalyst {
        doc /* The Market Analyst monitors ore market prices, adapts operations to maximize 
               revenue, and advises the corporation on market trends and responses. */
    }    
}
package StakeholderConcerns {

    private import ScalarValues::*;
    private import ISQ::*;
    private import Domain::*;
    private import StakeholdersDef::*;
    private import MiningFrigate::*;

    // The concerns are directly declared without definition, beacuse they aren't going to be reused in the scope of this model.
    // Concerns Derived from the Business Case

    concern ProfitabilityConcern {
        subject miningCorporation : Domain::MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall ensure that mining operations generate sufficient ISK/hour 
                   to justify investments in mining frigates, fleets, and operational costs. */
        }

        stakeholder miningCEO : MiningCEO;
    }

    concern OperationalCostsConcern {
        subject miningCorporation : Domain::MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall minimize operational costs (e.g., ship replacements, 
                   upgrades, maintenance) to maximize net profitability. */
        }

        stakeholder operationsManager : OperationsManager;
    }

    concern ScalabilityConcern  {
        subject miningCorporation : Domain::MiningCorporation;

        assume constraint {
            doc /* The Mining Corporation assumes that mining operations can scale effectively with 
                   fleet size and deployment in multiple regions. */
        }

        stakeholder fleetCommander : FleetCommander;
    }

    concern MarketResponsivenessConcern  {
        subject miningCorporation : Domain::MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall adapt mining operations to fluctuating market demands 
                   for specific ores and minerals. */
        }

        stakeholder marketAnalyst : MarketAnalyst;
    }

    // Concerns Derived from the ConOps

    concern SecurityConcern  {
        subject miningFrigate : MiningFrigate::MiningFrigate;

        require constraint {
            doc /* The Mining Frigate shall ensure safety and survivability in hostile environments 
                   (e.g., Low Sec, Null Sec, Wormholes). */
        }

        stakeholder fleetCommander : FleetCommander;
        stakeholder shipEngineer : ShipEngineer;
    }

    concern ResourceAvailabilityConcern  {
        subject miningCorporation : Domain::MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall ensure sufficient access to high-value asteroids, 
                   ore belts, and gas clouds in different operational areas. */
        }

        stakeholder fleetCommander : FleetCommander;
    }

    concern DeploymentEfficiencyConcern  {
        subject miningFrigate : MiningFrigate::MiningFrigate;

        require constraint {
            doc /* The Mining Frigate shall ensure rapid and efficient movement between resource 
                   sites and markets. */
        }

        stakeholder operationsManager : OperationsManager;
    }

    concern ThreatNeutralizationConcern  {
        subject miningFrigate : MiningFrigate::MiningFrigate;

        require constraint {
            doc /* The Mining Frigate shall mitigate risks from NPC pirates and hostile players 
                   during mining operations. */
        }

        stakeholder fleetCommander : FleetCommander;
        stakeholder shipEngineer : ShipEngineer;
    }

    // Concerns Derived from the MoEs

    concern TotalProfitabilityConcern  {
        subject miningCorporation : Domain::MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall maximize the total ISK/hour generated from mining 
                   operations while minimizing costs and losses. */
        }

        stakeholder miningCEO : MiningCEO;
    }

    concern OreYieldConcern  {
        subject miningFrigate : MiningFrigate::MiningFrigate;

        require constraint {
            doc /* The Mining Frigate shall maximize ore yield per frigate or fleet while avoiding 
                   resource depletion. */
        }

        stakeholder operationsManager : OperationsManager;
    }

    concern SurvivabilityConcern  {
        subject miningFrigate : MiningFrigate::MiningFrigate;

        require constraint {
            doc /* The Mining Frigate shall ensure high survivability in hostile or dangerous environments. */
        }

        stakeholder fleetCommander : FleetCommander;
        stakeholder shipEngineer : ShipEngineer;
    }

    concern FleetDeploymentEfficiencyConcern  {
        subject miningCorporation : Domain::MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall ensure optimal fleet deployment to maximize ore extraction 
                   and minimize operational downtime. */
        }

        stakeholder fleetCommander : FleetCommander;
        stakeholder operationsManager : OperationsManager;
    }

    concern OreDeliveryEfficiencyConcern  {
        subject miningFrigate : MiningFrigate::MiningFrigate;

        require constraint {
            doc /* The Mining Frigate shall ensure fast and efficient transport of mined ore to stations 
                   or POS for storage or sale. */
        }

        stakeholder operationsManager : OperationsManager;
    }

    concern RiskAdjustedProfitabilityConcern {
        subject miningCorporation : Domain::MiningCorporation;

        require constraint {
            doc /* The Mining Corporation shall balance profitability with the risks of operating in 
                   hostile environments. */
        }

        stakeholder miningCEO : MiningCEO;
        stakeholder fleetCommander : FleetCommander;
    }

    //Viewpoints
    viewpoint 'Operational profitability'{
        frame ProfitabilityConcern;

        require constraint {
            doc /*TBD*/
        }
    }
     

}
