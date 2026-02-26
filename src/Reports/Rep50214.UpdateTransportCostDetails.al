report 50214 "Update Transport Cost Details"
{
    ApplicationArea = All;
    Caption = 'Update Transport Cost Details';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    dataset
    {
        dataitem(WarehouseShipmentServices; "Warehouse Shipment Services")
        {
           
           
        }
       
    }
     trigger OnPreReport()
        var
            myInt: Integer;
        begin
                DOSalesShipment.Reset();
                DOSalesShipment.SetFilter("Whse Ship No", '<>%1', '');
                If DOSalesShipment.FindSet() then
                    repeat
                        WarehouseShipment.Reset();
                        WarehouseShipment.SetRange("Whse Shipment No.",DOSalesShipment."Whse Ship No");
                        If WarehouseShipment.FindSet() then
                            repeat
                                If WarehouseShipment."Rate Type" = WarehouseShipment."Rate Type"::Pallet then begin
                                    SalesShipmentLine.Reset();
                                    SalesShipmentLine.SetRange("Document No.", DOSalesShipment."No.");
                                    SalesShipmentLine.SetRange(Type, SalesShipmentLine.Type::Item);
                                    SalesShipmentLine.SetFilter(Quantity, '>%1', 0);
                                    If SalesShipmentLine.FindSet() then
                                        repeat
                                            TransportCostDetails.Init();
                                            TransportCostDetailsLine.SetAscending("Line No", false);
                                            If TransportCostDetailsLine.FindFirst() then
                                                TransportCostDetails."Line No" := TransportCostDetailsLine."Line No" + 10000
                                            else
                                                TransportCostDetails."Line No" := 10000;
                                            TransportCostDetails."Item No." := SalesShipmentLine."No.";
                                            TransportCostDetails.QTY := SalesShipmentLine.Quantity;
                                            TransportCostDetails.UOM := SalesShipmentLine."Unit of Measure Code";
                                            TransportCostDetails.Cost := WarehouseShipment.Rate;
                                            TransportCostDetails."Line Amount" := WarehouseShipment.Rate * SalesShipmentLine.Quantity;
                                            TransportCostDetails.Carrier := WarehouseShipment."Carrier Code";
                                            TransportCostDetails."Vendor No." := WarehouseShipment."Vendor No.";
                                            TransportCostDetails."DO" := SalesShipmentLine."Document No.";
                                            TransportCostDetails."DO Date" := SalesShipmentLine."Shipment Date";
                                            TransportCostDetails.Customer := SalesShipmentLine."Sell-to Customer No.";
                                            TransportCostDetails."Whse Shipment No." := WarehouseShipment."Whse Shipment No.";
                                            TransportCostDetails.Insert();
                                        until SalesShipmentLine.Next() = 0;
                                end;
                                If WarehouseShipment."Rate Type" = WarehouseShipment."Rate Type"::Fixed then begin
                                    TransportCostDetails.Init();
                                    TransportCostDetailsLine.SetAscending("Line No", false);
                                    If TransportCostDetailsLine.FindFirst() then
                                        TransportCostDetails."Line No" := TransportCostDetailsLine."Line No" + 10000
                                    else
                                        TransportCostDetails."Line No" := 10000;
                                    TransportCostDetails."Item No." := WarehouseShipment."Item Code";
                                    TransportCostDetails.QTY := 1;
                                    TransportCostDetails.UOM := WarehouseShipment."Unit of Measure Code";
                                    TransportCostDetails.Cost := WarehouseShipment.Rate;
                                    TransportCostDetails."Line Amount" := WarehouseShipment.Rate * 1;
                                    TransportCostDetails.Carrier := WarehouseShipment."Carrier Code";
                                    TransportCostDetails."Vendor No." := WarehouseShipment."Vendor No.";
                                    TransportCostDetails."DO" := DOSalesShipment."No.";
                                    TransportCostDetails."DO Date" := DOSalesShipment."Shipment Date";
                                    TransportCostDetails.Customer := DOSalesShipment."Sell-to Customer No.";
                                    TransportCostDetails."Whse Shipment No." := WarehouseShipment."Whse Shipment No.";
                                    TransportCostDetails.Insert();
                                end;
                            until WarehouseShipment.Next() = 0;
                    until DOSalesShipment.Next() = 0; 
        end;
   
    var
        WarehouseShipment: Record "Warehouse Shipment Services";
        PostedSalesShipment: Record "Sales Shipment Header";
        DOSalesShipment: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TransportCostDetails: Record "Transport Cost Details";
        TransportCostDetailsLine: Record "Transport Cost Details";
        SingleInstance: Codeunit JGSingleInstance;
}
