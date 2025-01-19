package EIT_System_Use_Cases {

    // Define actors
    actor Doctor;
    actor EngineerTechnician;
    actor Patient;
    actor EITSystem;

    // Define use cases
    usecase ApplyElectrodeBelt;
    usecase StartMonitoring;
    usecase CollectImpedanceData;
    usecase GenerateEITImages;
    usecase AnalyzeEITImages;
    usecase CalibrateSystem;

    // Relationships between actors and use cases
    association ApplyElectrodeBeltAssoc {
        memberEnd actor: EngineerTechnician;
        memberEnd usecase: ApplyElectrodeBelt;
    }

    association StartMonitoringAssoc {
        memberEnd actor: Doctor;
        memberEnd usecase: StartMonitoring;
    }

    association CollectImpedanceDataAssoc {
        memberEnd actor: EITSystem;
        memberEnd usecase: CollectImpedanceData;
    }

    association GenerateEITImagesAssoc {
        memberEnd actor: EITSystem;
        memberEnd usecase: GenerateEITImages;
    }

    association AnalyzeEITImagesAssoc {
        memberEnd actor: Doctor;
        memberEnd usecase: AnalyzeEITImages;
    }

    association CalibrateSystemAssoc {
        memberEnd actor: EngineerTechnician;
        memberEnd usecase: CalibrateSystem;
    }

    // System boundary
    boundary EITSystemBoundary {
        include ApplyElectrodeBelt;
        include StartMonitoring;
        include CollectImpedanceData;
        include GenerateEITImages;
        include AnalyzeEITImages;
        include CalibrateSystem;
    }
}
