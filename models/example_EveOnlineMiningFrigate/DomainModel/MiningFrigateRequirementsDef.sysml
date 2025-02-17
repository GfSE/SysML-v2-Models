package MiningFrigateRequirementsDef {

    private import Domain::*;
    private import ScalarValues::*;
    private import StakeholderConcerns::*;
    private import MiningFrigate::*;
    
    // Stakeholder Requirements Definition. These are a managed as a Configuration item.
    requirement def <MFRQ01> OreExtractionEfficiencyRequirement {
        doc /* The Mining Frigate shall extract ore at a minimum rate of 20 m³/minute in High Sec 
              and 50 m³/minute in Low Sec, Null Sec, and Wormhole operations. */      
        subject miningFrigate : MiningFrigate;
        attribute miningRateLS : Real;
        require constraint { miningRateLS >= 50.0 } // Low Sec, Null Sec, Wormhole (m³/min)
        
        frame concern OreYieldConcern;
    }

    requirement def <MFRQ02> CargoCapacityRequirement {
        doc /* The Mining Frigate shall have a cargo capacity of at least 5,000 m³ (expandable by modules). */
        subject miningFrigate : MiningFrigate;
        attribute cargoCapacity : Real;
        require constraint { cargoCapacity >= 5000.0 } // m³
        
        frame concern TotalProfitabilityConcern;
    }

    requirement def <MFRQ03> SurvivabilityRequirement {
        doc /* The Mining Frigate shall withstand at least 200 DPS in High Sec and 400 DPS 
              in Low Sec, Null Sec, and Wormhole operations. */
		subject miningFrigate : MiningFrigate;
        attribute shieldStrengthHS : Real;
        attribute shieldStrengthLS : Real;
        require constraint { shieldStrengthHS >= 200.0 } // High Sec (DPS)
        require constraint { shieldStrengthLS >= 400.0 } // Low Sec, Null Sec, Wormhole (DPS)
        
        frame concern SecurityConcern ;
        frame concern SurvivabilityConcern;
    }

    requirement def <MFRQ04> DroneOperationsRequirement {
        doc /* The Mining Frigate shall support the deployment of at least 5 drones for 
              mining and combat operations. */
        subject miningFrigate : MiningFrigate;
        attribute droneCapacity : Real;
        require constraint { droneCapacity >= 5 } // Minimum number of drones
        
        frame concern ThreatNeutralizationConcern;
        frame concern OreYieldConcern;
    }

    requirement def <STRQ05> ThreatDetectionRequirement {
        doc /* The Mining Frigate shall detect incoming threats within a range of 20 AU. */
        subject miningFrigate : MiningFrigate;
        attribute threatDetectionRange : Real;
        require constraint { threatDetectionRange >= 20.0 } // AU
        
        frame concern SecurityConcern;
        frame concern ThreatNeutralizationConcern;
    }

    requirement def <MFRQ06> TravelEfficiencyRequirement {
        doc /* The Mining Frigate shall have a warp speed of at least 5 AU/second 
              and an align time of less than 3 seconds. */
        subject miningFrigate : MiningFrigate;
        attribute warpSpeed: Real;
        attribute alignTime: Real;
        require constraint { warpSpeed >= 5.0 } // Warp speed (AU/second)
        require constraint { alignTime <= 3.0 } // Align time (seconds)
        
        frame concern DeploymentEfficiencyConcern;
    }

    requirement def <MFRQ07> MiningTargetRequirement {
        doc /* The Mining Frigate shall lock and mine up to 3 asteroid targets simultaneously. */
        subject miningFrigate : MiningFrigate;
        attribute lockedTargets : Real;
        require constraint { lockedTargets <= 3 } // Maximum asteroid targets
        
        frame concern OreYieldConcern;
    }

    requirement def <MFRQ08> DockingRequirement {
        doc /* The Mining Frigate shall dock and offload ore at stations or POS within 1 minute. */
        subject miningFrigate : MiningFrigate;
        attribute dockingTime : Real;
        require constraint { dockingTime <= 60.0 } // Seconds
        
        frame concern OreDeliveryEfficiencyConcern;
    }

    requirement def <MFRQ09> FleetCoordinationRequirement {
        doc /* The Fleet Commander shall coordinate mining fleets of up to 10 frigates. */
        subject fleetCommander : PilotPod;
        attribute fleetSize : Real;
        require constraint { fleetSize <= 10 } // Maximum fleet size
        
        frame concern FleetDeploymentEfficiencyConcern;
        frame concern ScalabilityConcern;
    }
    requirement def <MFRQ10> OreCompressionRequirement {
        doc /* The Rorqual shall support onboard ore compression to reduce ore volume 
              by a factor of 10. */
        subject rorqual : Rorqual;      
        attribute compressionFactor : Real;
        require constraint { compressionFactor == 10.0 } // Compression factor
        
        frame concern TotalProfitabilityConcern;
    }
}