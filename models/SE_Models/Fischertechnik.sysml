item def GeneralOrder {
    // How to use the simple types?
    // Could not resolve reference to Type named 'String'.
    attribute orderID : String;
    attribute orderAmount : int;
}

item def SalesOrder specializes GeneralOrder {}

item def MaterialOrder specializes GeneralOrder {}

item def ProductOrder specializes GeneralOrder {}

item def PurchaseOrder specializes GeneralOrder {}

item def Inquiry specializes GeneralOrder {}

item def OrderQuotation specializes GeneralOrder {}

item def OrderConfirmation specializes GeneralOrder {}

item def Shipment {}

item def ShippingConfirmation {}

item def Product {
    attribute productID : String;
}

item def Material {
    attribute materialID : String;
}

item def Inventory {}

item def IntermediateProduct {}

part Machine {
    attribute name : String;
    attribute secondsToProcess : int;
}

port def InventoryPortDef {
    out item inventory : Inventory;
}

port def ShippingConfirmationPortDef {
    out item shippingConfirmation : ShippingConfirmation;
}

port def ProductOrderPortDef {
    out item productOrder : ProductOrder;
}

port def SalesOrderPortDef {
    out item salesOrder : SalesOrder;
}

port def ProductPortDef {
    out item product : Product;
}

port def MaterialOrderPortDef {
    out item materialOrder : MaterialOrder;
}

port def MaterialPortDef {
    out item material : Material;
}

port def InquiryPortDef {
    out item inquiry : Inquiry;
}

port def ShipmentPortDef {
    out item shipment : Shipment;
}

port def PurchaseOrderPortDef {
    out item PurchaseOrder;
}

port def OrderQuotationPortDef {
    out item orderQuotation : OrderQuotation;
}

port def OrderConfirmationPortDef {
    out item orderConfirmation : OrderConfirmation;
}

// Parts

part factoryContext {
    part Manufacturer {
        part Production {
            part ProductionControl {
                in port materialIn : ~MaterialPortDef;
                in port productionOrderIn : ~ProductOrderPortDef;
                out port material0 : MaterialPortDef;
                out port productionOrderOut : ProductOrderPortDef;
            }
            // ProductionOrder->Production Config
            // Production config from Production Control to each machine, one port each

            part AngleProductionLine {
                in port materialIn : ~MaterialPortDef;
                out port productOut : ProductPortDef;
                in port productionOrderIn : ~ProductOrderPortDef;

                part Heating {
                    attribute temperature : float;
                    attribute duration : float;
                    in port productIn : ~MaterialPortDef;
                    out port productOut : ProductPortDef;
                }

                part Bending {
                    attribute angle;
                    in port productIn : ~ProductPortDef;
                    out port productOut : ProductPortDef;
                }

                part Cutting {
                    attribute length : float;
                    in port productIn : ~ProductPortDef;
                    out port productOut : ProductPortDef;
                }

                part Drilling {
                    attribute holeLocationsX;
                    attribute holeLocationsY;
                    in port productIn : ~ProductPortDef;
                    out port productOut : ProductPortDef;
                }

                part Grinding {
                    attribute duration : float;
                    attribute grainSize : int;
                    in port productIn : ~ProductPortDef;
                    out port productOut : ProductPortDef;
                }

                part Polishing {
                    attribute grainSize : int;
                    attribute duration : float;
                    in port productIn : ~ProductPortDef;
                    out port productOut : ProductPortDef;
                }

                connect materialIn to Heating.productIn;
                connect Heating.productOut to Bending.productIn;
                connect Bending.productOut to Cutting.productIn;
                connect Cutting.productOut to Drilling.productIn;
                connect Drilling.productOut to Grinding.productIn;
                connect Grinding.productOut to Polishing.productIn;
                connect Polishing.productOut to productOut;
            }

            connect ProductionControl.productionOrderOut to AngleProductionLine.productionOrderIn;

            in port productionOrderIn : ~ProductOrderPortDef;
            out port productOut : ProductPortDef;
            out port materialOrderOut : MaterialOrderPortDef;
            in port materialIn : ~MaterialPortDef;

            connect AngleProductionLine.productOut to productOut;
        }

        part Storage {
            in port materialOrderIn : ~MaterialOrderPortDef;
            in port materialIn : ~MaterialPortDef;

            out port inventory : InventoryPortDef;
            out port materialOut : MaterialPortDef;
        }

        part Sales {
            out port salesOrderOut : SalesOrderPortDef;
            out port orderQuotationOut : OrderQuotationPortDef;

            in port orderConfirmationIn : ~OrderConfirmationPortDef;
            in port inquiryIn : ~InquiryPortDef;
            in port shippingConfirmationIn : ~ShippingConfirmationPortDef;
            out port shippingConfirmationOut : ShippingConfirmationPortDef;
        }

        part Procurement {
            in port salesOrderIn : ~SalesOrderPortDef;
            out port purchaseOrderOut : MaterialOrderPortDef;
        }

        part ProductionScheduling {
            in port salesOrderIn : ~SalesOrderPortDef;
            out port productionOrderOut : ProductOrderPortDef;
        }

        part Dispatch {
            in port productIn : ~ProductPortDef;
            in port salesOrderIn : ~SalesOrderPortDef;

            out port shippingConfirmationOut : ShippingConfirmationPortDef;
            out port shipmentOut : ShipmentPortDef;
        }

        connect Sales.salesOrderOut to ProductionScheduling.salesOrderIn;
        connect Sales.salesOrderOut to Dispatch.salesOrderIn;

        connect ProductionScheduling.productionOrderOut to Production.productionOrderIn;
        connect Production.materialOrderOut to Storage.materialOrderIn;
        connect Production.AngleProductionLine.productOut to Dispatch.productIn;

        connect Storage.materialOut to Production.materialIn;
    }

    part Customer {
        out port inquiryOut : InquiryPortDef;
        out port orderConfirmationOut : OrderConfirmationPortDef;

        in port orderQuotationIn : ~OrderQuotationPortDef;
        in port shipmentIn : ~ShipmentPortDef;
        in port shippingConfirmationIn : ~ShippingConfirmationPortDef;
    }

    part Supplier {
        out port materialOut : MaterialPortDef;
        in port purchaseOrderIn : ~PurchaseOrderPortDef;
    }

    connect Customer.inquiryOut to Manufacturer.Sales.inquiryIn;
    connect Manufacturer.Dispatch.shippingConfirmationOut to Customer.shippingConfirmationIn;
    connect Manufacturer.Sales.shippingConfirmationOut to Customer.shippingConfirmationIn;

    connect Manufacturer.Sales.orderQuotationOut to Customer.orderQuotationIn;
    connect Manufacturer.Sales.orderConfirmationIn to Customer.orderConfirmationOut;

    connect Customer.shipmentIn to Manufacturer.Dispatch.shipmentOut;

    connect Supplier.purchaseOrderIn to Manufacturer.Procurement.purchaseOrderOut;
    connect Supplier.materialOut to Manufacturer.Storage.materialIn;

    connect Manufacturer.Procurement.purchaseOrderOut to Supplier.purchaseOrderIn;
}