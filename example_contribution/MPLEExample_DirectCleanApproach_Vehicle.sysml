package MPLEExample_DirectCleanApproach_Vehicle {
    
    //
    // Shared Assets
    //
    part def Vehicle {
        variation roof : Roof {
            variant part standardRoof : StandardRoof;
            variant part skyRoof : SkyRoof;
            variant part convertibleRoof : ConvertibleRoof;
        }
    }
    
    part def Roof;
    part def StandardRoof :> Roof;
    part def SkyRoof :> Roof;
    part def ConvertibleRoof :> Roof;

    //
    // Member Products
    //
    part convertibleVehicle : Vehicle {
        :>> roof = roof::convertibleRoof;
    }
    part standardVehicle : Vehicle {
        :>> roof = roof::standardRoof;
    }

}