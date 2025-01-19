package HVACSystemRequirements {

    import eVehicleLibrary::*;

    requirement def TemperatureRegulationReqDef {
        doc /* The HVAC system shall regulate the cabin temperature based on user settings. */

        attribute setTemperature : Temperature;
        attribute actualTemperature : Temperature;

        require constraint { abs(actualTemperature - setTemperature) <= 1 }
    }

    requirement def CoolingFunctionReqDef {
        doc /* The HVAC system shall reduce the cabin temperature to the set value when cooling is required. */

        attribute setCoolingTemperature : Temperature;
        attribute actualCoolingTemperature : Temperature;

        require constraint { actualCoolingTemperature <= setCoolingTemperature }
    }

    requirement def HeatingFunctionReqDef {
        doc /* The HVAC system shall increase the cabin temperature to the set value when heating is required. */

        attribute setHeatingTemperature : Temperature;
        attribute actualHeatingTemperature : Temperature;

        require constraint { actualHeatingTemperature >= setHeatingTemperature }
    }

    requirement def DefrostingReqDef {
        doc /* The HVAC system shall defrost the windshield and windows when activated. */

        attribute defrostTime : Time;
        attribute maxDefrostTime : Time;

        require constraint { defrostTime <= maxDefrostTime }
    }

    requirement def AirQualityControlReqDef {
        doc /* The HVAC system shall filter and maintain cabin air quality by removing pollutants and controlling humidity. */

        attribute particleFiltrationEfficiency : Percentage;
        attribute humidityLevel : Percentage;
        attribute minFiltrationEfficiency : Percentage;
        attribute minHumidity : Percentage;
        attribute maxHumidity : Percentage;

        require constraint { 
            particleFiltrationEfficiency >= minFiltrationEfficiency &&
            humidityLevel >= minHumidity &&
            humidityLevel <= maxHumidity
        }
    }

    requirement def UserInterfaceReqDef {
        doc /* The HVAC system shall provide an intuitive user interface for setting temperature, fan speed, and other preferences. */

        attribute userInteractions : Integer;
        attribute maxInteractions : Integer;

        require constraint { userInteractions <= maxInteractions }
    }

    requirement def PerformanceReqDef {
        doc /* The HVAC system shall respond to user inputs within 1 second. */

        attribute responseTime : Time;
        attribute maxResponseTime : Time;

        require constraint { responseTime <= maxResponseTime }
    }

    requirement def ReliabilityReqDef {
        doc /* The HVAC system shall operate reliably under all specified conditions without failure for at least 5 years or 100,000 kilometers. */

        attribute operationalYears : Integer;
        attribute operationalDistance : Distance;
        attribute minOperationalYears : Integer;
        attribute minOperationalDistance : Distance;

        require constraint { 
            operationalYears >= minOperationalYears &&
            operationalDistance >= minOperationalDistance
        }
    }

    requirement def PowerConsumptionReqDef {
        doc /* The HVAC system shall minimize power consumption to not adversely affect vehicle fuel efficiency. */

        attribute powerConsumption : Power;
        attribute maxPowerConsumption : Power;

        require constraint { powerConsumption <= maxPowerConsumption }
    }

    requirement def NoiseLevelsReqDef {
        doc /* The HVAC system shall operate with noise levels below 40 dB under normal conditions. */

        attribute noiseLevel : Decibel;
        attribute maxNoiseLevel : Decibel;

        require constraint { noiseLevel <= maxNoiseLevel }
    }

    requirement def ElectricalSystemInterfaceReqDef {
        doc /* The HVAC system shall interface with the car's electrical system for power and control signals. */

        attribute interfaceStatus : Boolean;

        require constraint { interfaceStatus == true }
    }

    requirement def EngineInterfaceReqDef {
        doc /* The HVAC system shall interface with the car's engine to utilize waste heat for heating functions. */

        attribute heatingEfficiency : Percentage;
        attribute minHeatingEfficiency : Percentage;

        require constraint { heatingEfficiency >= minHeatingEfficiency }
    }

    requirement def UserInterfaceAccessibilityReqDef {
        doc /* The HVAC system shall provide a user interface accessible from the car's dashboard or central console. */

        attribute uiAccessibility : Boolean;

        require constraint { uiAccessibility == true }
    }

    requirement def TestingReqDef {
        doc /* The HVAC system shall undergo rigorous testing to verify all functional and non-functional requirements. */

        attribute testingStatus : Boolean;

        require constraint { testingStatus == true }
    }

    requirement def UserFeedbackReqDef {
        doc /* The HVAC system shall be evaluated through user feedback to ensure usability and satisfaction. */

        attribute userFeedbackScore : Percentage;
        attribute minUserFeedbackScore : Percentage;

        require constraint { userFeedbackScore >= minUserFeedbackScore }
    }

    requirement def GlossaryReqDef {
        doc /* Glossary definitions for HVAC system. */

        attribute glossaryTerms : String;

        require constraint { glossaryTerms != "" }
    }

    requirement def ReferencesReqDef {
        doc /* Industry standards for automotive HVAC systems. Manufacturer specifications for compatible car models. */

        attribute referenceDocuments : String;

        require constraint { referenceDocuments != "" }
    }
}
