package InternetModel_v1 {
    part def Data;
    part def Device {
        attribute connType: Connection[1.. * ];
        attribute voltageIn: Electricity[1];
    }
    part def WiFiRouter :> Device {
        attribute wirelessConnection : WirelessConnection[1..2];
        attribute ethernetConnection : CableConnection[1..*];
    }
    part def DSLRouter :> Device {
        attribute dslConnection : CableConnection[1];
        attribute ethernetConnection : CableConnection[1..*];
    }
    part def MobileDevice :> Device {
        doc /** Bluetooth, WiFi, 5G/4G ... so at least 3 wireless connections **/
        attribute wirelessConnection : WirelessConnection[1..3];
    }
    attribute def Connection {
        in item inData: Data;
        out item outData: Data;
    }
    attribute def WirelessConnection :> Connection {
        attribute frequency: SI::FrequencyUnit;
    }
    attribute def CableConnection :> Connection {
        attribute wireCount: ScalarValues::Integer;
    }
    attribute def Electricity {
        attribute voltage: ISQElectromagnetism::ElectricPotentialUnit;
        attribute ampere: ISQElectromagnetism::ElectricChargeUnit;
    }
}