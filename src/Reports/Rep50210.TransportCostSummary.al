report 50210 "Transport Cost Summary"
{
    ApplicationArea = All;
    Caption = 'Transport Cost Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/Reports/Layouts/TransportCostSummary.rdl';
    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            RequestFilterFields = "Shipment Date";
            dataitem(TransportCostDetails; "Transport Cost Details")
            {
                column(DO; TransportCostDetails."DO") { }
                column(DO_Date; "DO Date") { }
                column(Vendor_No_; "Vendor No.") { }
                column(Customer; Customername) { }
                column(QTY; QTY) { }
                column(Item_No_; "Item No.") { }
                column(Line_Amount; "Line Amount") { }
                column(Carrier; Carrier) { }
                column(Cost; Cost) { }
                column(UOM; UOM) { }
                column(vendorname; vendorname) { }
                trigger OnAfterGetRecord()
                begin
                    Clear(vendorname);
                    If Vendor.Get("Vendor No.") then
                        vendorname := Vendor.Name;
                    Clear(Customername);
                    if CustomerRec.Get(Customer) then
                       Customername := CustomerRec.Name;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                If TransportCostDetailsLine.FindSet() then
                    TransportCostDetailsLine.DeleteAll();
                WarehouseShipment.Reset();
                WarehouseShipment.SetRange("Whse Shipment No.", SalesShipmentHeader."Whse Ship No");
                If WarehouseShipment.FindSet() then
                    repeat
                        If WarehouseShipment."Rate Type" = WarehouseShipment."Rate Type"::Pallet then begin
                            SalesShipmentLine.Reset();
                            SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
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

                            TransportCostDetails."DO" := SalesShipmentHeader."No.";
                            TransportCostDetails."DO Date" := SalesShipmentHeader."Shipment Date";
                            TransportCostDetails.Customer := SalesShipmentHeader."Sell-to Customer No.";
                            TransportCostDetails.Insert();
                        end;
                    until WarehouseShipment.Next() = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
    var
        WarehouseShipment: Record "Warehouse Shipment Services";
        PostedSalesShipment: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TransportCostDetailsLine: Record "Transport Cost Details";
        vendorname: Text[100];
        Vendor: Record Vendor;
        CustomerRec : Record customer;
        Customername: Text[100];
}
