package BusinessCase {
	part businessCase {
		doc /*The Mining Corporation operates fleets of mining frigates to extract valuable ore from asteroid belts 
		 * and wormholes, process it onboard, and deliver it to stations for resale or further refinement. 
		 * The primary objectives are: 
		 * Maximize Profitability: 
		 * Extract the most valuable ores. Optimize mining efficiency and reduce operational costs. 
		 * Ensure Operational Safety: 
		 * Protect mining frigates, pilots, and assets from hostile threats. Minimize downtime caused by losses or disruptions. 
		 * Sustain Long-Term Operations: 
		 * Maintain a steady flow of resources. Minimize interruptions by ensuring resupply efficiency and equipment durability.
		 */
	}
}
package ConceptOfOperations {
	part <ConOps> condeptOfOperations {
		doc /*Overview: 
		 * The Mining Corporation's fleet of mining frigates operates in High-Security (High Sec), Low-Security (Low Sec), 
		 * Null-Security (Null Sec), and Wormhole Space (W-Space). Operations are coordinated from a central command, with pilots 
		 * executing mining tasks and returning ore to stations or Player-Owned Structures (POS) for processing or resale.
		 * Operational Workflow Deployment: 
		 * Mining frigates are dispatched to asteroid belts or wormholes based on the availability of resources and risk levels. 
		 * Mining Operations:
		 * Frigates extract ore using mining lasers, refine it onboard (if applicable), and store it in their cargo holds. 
		 * Threat Detection and Mitigation:
		 * Sensor arrays detect hostile ships, and defensive systems (drones, turrets) are used to neutralize threats. 
		 * Ore Transport and Resupply:
		 * Processed ore is delivered to nearby stations or POS for storage or sale. Frigates resupply fuel and life support systems 
		 * before redeployment. 
		 * Fleet Maintenance and Coordination:
		 * Central command ensures that mining frigates are adequately maintained, optimized, and allocated to maximize coverage 
		 * and profitability.
		 */
	}
}
package BusinessRequirements {
	
	private import Domain::*;
	private import ScalarValues::*;
	private import StakeholderConcerns::*;
	    
	// Business Requirements Definition.
    requirement def <BUS01> ProfitabilityRequirement {
        doc /* The mining organization shall guarantee a profitability of 25.000 ISK/hour in order to provide 
         * suficcient incentive to pilots to work for the corporation.
         */      
        subject miningFCorporation : Domain::MiningCorporation;
        attribute profitability : Real;
        require constraint { profitability >= 25000 } 
        
        frame concern ProfitabilityConcern;
    }
    requirement <BUS01_1> profitabilityRequirement : ProfitabilityRequirement {
    	subject miningCorporation : Domain::MiningCorporation;
    	attribute :>> profitability = miningCorporation.minimumProfit ;
    }
}