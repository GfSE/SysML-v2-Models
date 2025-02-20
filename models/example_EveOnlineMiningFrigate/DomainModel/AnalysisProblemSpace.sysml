package analysisProblemSpace {
	doc /*Analysis in the contxt of the problem space */
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import Domain::*;
	private import MiningFrigate::*;
	private import BusinessRequirements::BUS01_1;

    // **General Analysis Definition: Risk-Adjusted Profitability Calculation**
    analysis def RiskAdjustedProfitability {

        subject miningcorporation : MiningCorporation;

        objective {
            doc /* Evaluates profitability across different security zones (High Sec, Low Sec, Null Sec) 
                   by considering ore value, operational costs, and survival probability.
            */
        }

        in oreYield : Real;
        in marketOrePrice : Real;           // ISK/m³
        in operationalCosts : Real;   // ISK/hour
        in survivalProbability : Real; // %

        // **Sequential Calculation Execution**
        calc computeExpectedRevenue : ComputeExpectedRevenue {
            in oreYield = oreYield;
            in orePrice = marketOrePrice;
            return expectedRevenue;
        }
        calc computeRiskFactor : ComputeRiskFactor {
            in survivalProbability = survivalProbability;
            return riskFactor;
        }
        calc riskAdjustedProfitability : ComputeRiskAdjustedProfitability {
            in expectedRevenue = computeExpectedRevenue.expectedRevenue;
            in operationalCosts = operationalCosts;
            in riskFactor = computeRiskFactor.riskFactor;
            return profitability;
        }
        
        calc def ComputeExpectedRevenue {
	        in oreYield : Real;
	        in orePrice : Real;
	        return : Real;  // ISK/hour
	
	        oreYield * orePrice
	    }
	    
	    calc def ComputeRiskFactor {
	        in survivalProbability : Real;
	        return : Real;  // Risk Adjustment Factor
	
	        (100.0 - survivalProbability) / 100.0
	    }
	    calc def ComputeRiskAdjustedProfitability {
	        in expectedRevenue : Real;
	        in operationalCosts : Real;
	        in riskFactor : Real;
	        return : Real;  // Adjusted ISK/hour
	
	        (expectedRevenue - operationalCosts) * (1.0 - riskFactor)
	    }
    }

    // **Scenario-Specific Uses of Risk-Adjusted Profitability Analysis**

    part riskAdjustedProfitabilityAnalysisContext {
    
		// **Assumptions for ore market prices based on yearly averages**
	    attribute highSecOreValue : Real = 200.0; // ISK/m³ (e.g., Veldspar, Scordite)
	    attribute lowSecOreValue : Real = 350.0;  // ISK/m³ (e.g., Kernite, Omber)
	    attribute nullSecOreValue : Real = 500.0; // ISK/m³ (e.g., Arkonor, Bistot)
	    
	    analysis HighSecProfitability : RiskAdjustedProfitability {
	        
	        subject miningFrigate = miningFrigate;
	        in oreYield = CalculateOreYield(
	        	analysisMiningCorporation.miningFrigate.miningRate, 
	        	3600.0, 
	        	analysisMiningCorporation.pilotPod.controlEfficiency
	        );
	        in marketOrePrice = highSecOreValue;
	        in operationalCosts = 100000.0;  // ISK/hour (assumed low operational costs)
	        in survivalProbability = 98.0;   // Very safe
	    }
	
	    analysis LowSecProfitability : RiskAdjustedProfitability {
	        
	        subject miningFrigate = miningFrigate;
	        in oreYield = CalculateOreYield(
	        	analysisMiningCorporation.miningFrigate.miningRate, 
	        	3600.0, 
	        	analysisMiningCorporation.pilotPod.controlEfficiency
	        );
	        in marketOrePrice = lowSecOreValue;
	        in operationalCosts = 150000.0;  // ISK/hour (higher risk, more costs)
	        in survivalProbability = 75.0;   // Increased risk of ship loss
	    }
	
	    analysis NullSecProfitability : RiskAdjustedProfitability {
	        
	        subject miningFrigate = miningFrigate;
	        in oreYield = CalculateOreYield(
	        	analysisMiningCorporation.miningFrigate.miningRate, 
	        	3600.0, 
	        	analysisMiningCorporation.pilotPod.controlEfficiency
	        );
	        in marketOrePrice = nullSecOreValue;
	        in operationalCosts = 200000.0;  // ISK/hour (high cost due to logistics, security)
	        in survivalProbability = 50.0;   // Very high risk, frequent losses
	    }
	    part analysisMiningCorporation : MiningCorporation ;
	    
	    satisfy BUS01_1 by analysisMiningCorporation;
	}
	
	// Calculations definitions for MoEs
    // Relating MoPs (Measures of Performance) to MoEs (Measures of Effectiveness)

    calc def CalculateTotalProfitability {
        in oreValue : Real;             // ISK/hour
        in operationalCosts : Real;     // ISK/hour
        in miningRate : Real = miningRate;  // MoP: Higher mining rate increases ore value.
        in cargoCapacity : Real = cargoCapacity;  // MoP: Larger capacity allows more ore to be sold before docking.
        return : Real;                  // ISK/hour
        
        // Profitability depends on ore value, operational costs, mining rate, and cargo capacity.
        (oreValue * miningRate * cargoCapacity) - operationalCosts
    }

    calc def CalculateOreYield {
        in miningRate : Real;  // MoP: Higher mining rate means more ore is collected.
        in operationalTime : Real;     // seconds
        in controlEfficiency : Real ;  // MoP: More efficient controls reduce delays and improve mining output.
        return : Real;                 // m³/hour

        // Ore yield depends on mining rate, operational time, and control efficiency.
        (miningRate * operationalTime * controlEfficiency) / 3600.0
    }

    calc def CalculateFleetSurvivability {
        in successfulMissions : Integer;
        in totalMissions : Integer;
        in survivalProbability : Real = survivalProbability;  // MoP: Higher survival probability increases mission success rate.
        in situationalAwareness : Real = situationalAwareness;  // MoP: Better situational awareness helps avoid threats.
        return : Real;                 // %

        // Fleet survivability depends on mission success rate, survival probability, and situational awareness.
        ((successfulMissions / totalMissions) * 100.0) * survivalProbability * situationalAwareness
    }

    calc def CalculateOperationalUptime {
        in activeMiningTime : Real;    // seconds
        in totalOperationTime : Real; // seconds
        in controlEfficiency : Real ;  // MoP: Higher efficiency leads to better uptime.
        return : Real;                 // %

        // Operational uptime is improved by higher control efficiency.
        ((activeMiningTime / totalOperationTime) * 100.0) * controlEfficiency
    }

    calc def CalculateFleetDeploymentEfficiency {
        in effectiveDeployments : Integer;
        in totalDeployments : Integer;
        in situationalAwareness : Real = situationalAwareness;  // MoP: Better awareness leads to smarter deployments.
        in fleetSize : Real = fleetSize;  // MoP: A larger fleet enables more deployments.
        return : Real;                 // %

        // Deployment efficiency improves with better awareness and fleet size.
        ((effectiveDeployments / totalDeployments) * 100.0) * situationalAwareness * fleetSize
    }

    calc def CalculateOreDeliveryEfficiency {
        in totalDeliveryTime : Real;  // seconds
        in numberOfDeliveries : Integer;
        in cargoCapacity : Real = cargoCapacity;  // MoP: Larger cargo capacity reduces the number of required trips.
        in miningRate : Real = miningRate;  // MoP: Faster mining requires more frequent deliveries.
        return : Real;                // seconds

        // Delivery efficiency depends on cargo size and mining rate.
        (totalDeliveryTime / numberOfDeliveries) * (miningRate / cargoCapacity)
    }

    calc def CalculateThreatNeutralizationSuccess {
        in threatsNeutralized : Integer;
        in totalThreatsEncountered : Integer;
        return : Real;                // %

        (threatsNeutralized / totalThreatsEncountered) * 100.0
    }

    
}