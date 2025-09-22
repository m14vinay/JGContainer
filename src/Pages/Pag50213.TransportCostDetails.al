page 50213 "Transport Cost Details"
{
    ApplicationArea = All;
    Caption = 'Transport Cost Details';
    PageType = List;
    SourceTable = "Transport Cost Details";
    Editable = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Line No."; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Caption = 'Line No.';
                }
                field("No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Caption = 'Item No.';
                }
                field("Unit of Measure"; Rec."UOM")
                {
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                }
                field(Quantity; Rec.QTY)
                {
                    ToolTip = 'Specifies the number of units of the item, general ledger account, or item charge on the line.';
                }
                field("Unit Price"; Rec.Cost)
                {
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                    Caption = 'Cost';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the gross weight of one unit of the item. In the sales statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular sales document.';
                    Caption = 'Line Amount';
                }

                field(Carrier; Rec.Carrier)
                {
                    ToolTip = 'Specifies the number of the related project.';
                    Caption = 'Carrier';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the number of the related project task.';
                    Caption = 'Vendor No.';
                }
                field(DO; Rec."DO")
                {
                    ToolTip = 'Specifies the number of the related document.';
                    Caption = 'DO';
                }
                field("Shipment Date"; Rec."DO Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    Caption = 'DO Date';
                }
                field("Sell-to Customer No."; Rec.Customer)
                {
                    ToolTip = 'Specifies the number of the customer.';
                    Caption = 'Customer';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        WarehouseShipment: Record "Warehouse Shipment Services";
        PostedSalesShipment: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TransportCostDetails: Record "Transport Cost Details";
        TransportCostDetailsLine: Record "Transport Cost Details";
        SingleInstance: Codeunit JGSingleInstance;
    begin
        If TransportCostDetailsLine.FindSet() then
            TransportCostDetailsLine.DeleteAll();
        WarehouseShipment.Reset();
        WarehouseShipment.SetRange("Whse Shipment No.", SingleInstance.GetWhseShipNo());
        If WarehouseShipment.FindSet() then
            repeat
                If WarehouseShipment."Rate Type" = WarehouseShipment."Rate Type"::Pallet then begin
                    SalesShipmentLine.Reset();
                    SalesShipmentLine.SetRange("Document No.", SingleInstance.GetShipNo());
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
                    if PostedSalesShipment.get(SingleInstance.GetShipNo()) then;
                    TransportCostDetails."DO" := PostedSalesShipment."No.";
                    TransportCostDetails."DO Date" := PostedSalesShipment."Shipment Date";
                    TransportCostDetails.Customer := PostedSalesShipment."Sell-to Customer No.";
                    TransportCostDetails.Insert();
                end;
            until WarehouseShipment.Next() = 0;
    end;
}
