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

item def Product {
    attribute productID : String;
}

item def Material {
    attribute materialID : String;
}

item def Intermediate {}

item def Intermediate0 specializes Intermediate {}

part Machine {
    attribute name : String;
    attribute secondsToProcess : int;
}

// Port defs. Are they really needed? Each port has just one member ...

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
            part ProducitonControl {
                in port materialIn : ~MaterialPortDef;
                in port productionOrderIn : ~ProductOrderPortDef;
                out port material0 : MaterialPortDef;
            }

            part ProductionLine1 {
                in port materialIn : ~MaterialPortDef;
                out port productOut : ProductPortDef;

                // TODO: Add Machines!
            }

            part ProductionLine2 {
                in port materialIn : ~MaterialPortDef;
                out port productOut : ProductPortDef;

                // TODO: Add Machines!
            }

            in port productionOrderIn : ~ProductOrderPortDef;
            out port productOut : ProductPortDef;
            out port materialOrderOut : MaterialOrderPortDef;
            in port materialIn : ~MaterialPortDef;
        }

        part Storage {
            in port materialOrderIn : ~MaterialOrderPortDef;
            in port materialIn : ~MaterialPortDef;

            out port purchaseOrderOut : PurchaseOrderPortDef;
            out port materialOut : MaterialPortDef;
        }

        part Sales {
            out port salesOrderOut : SalesOrderPortDef;
            out port orderQuotationOut : OrderQuotationPortDef;

            in port orderConfirmationIn : ~OrderConfirmationPortDef;
            in port inquiryIn : ~InquiryPortDef;
        }

        part ProductionScheduling {
            in port salesOrderIn : ~SalesOrderPortDef;
            out port productionOrderOut : ProductOrderPortDef;
        }

        part Dispatch {
            in port productIn : ~ProductPortDef;
            in port salesOrderIn : ~SalesOrderPortDef;
            out port shipmentOut : ShipmentPortDef;
        }

        connect Sales.salesOrderOut to ProductionScheduling.salesOrderIn;
        connect Sales.salesOrderOut to Dispatch.salesOrderIn;

        connect ProductionScheduling.productionOrderOut to Production.productionOrderIn;
        connect Production.materialOrderOut to Storage.materialOrderIn;
        connect Production.ProductionLine1 to Dispatch.productIn;
        connect Production.ProductionLine2 to Dispatch.productIn;

        connect Storage.materialOut to Production.materialIn;
    }

    part Customer {
        out port inquiryOut : InquiryPortDef;
        out port orderConfirmationOut : OrderConfirmationPortDef;

        in port orderQuotationIn : ~OrderQuotationPortDef;
        in port shipmentIn : ~ShipmentPortDef;
    }

    part Supplier {
        out port materialOut : MaterialPortDef;
        in port purchaseOrderIn : ~PurchaseOrderPortDef;
    }

    connect Customer.inquiryOut to Manufacturer.Sales.inquiryIn;

    connect Manufacturer.Sales.orderQuotationOut to Customer.orderQuotationIn;
    connect Manufacturer.Sales.orderConfirmationIn to Customer.orderConfirmationOut;

    connect Customer.shipmentIn to Manufacturer.Dispatch.shipmentOut;

    connect Supplier.purchaseOrderIn to Manufacturer.Storage.purchaseOrderOut;
    connect Supplier.materialOut to Manufacturer.Storage.materialIn;

    connect Manufacturer.Storage.purchaseOrderOut to Supplier.purchaseOrderIn;
}