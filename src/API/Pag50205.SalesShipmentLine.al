page 50205 "Sales Shipment Line"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'commit';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesShipmentLine';
    Editable = false;
    EntityName = 'salesShipmentLine';
    EntitySetName = 'salesShipmentLines';
    PageType = API;
    SourceTable = "Sales Shipment Line";
    SourceTableView = where ("Type" = const(Item));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Packslipno; Rec."Document No.")
                {
                    Caption = 'Pack slip No.';
                }
                field(shipmentLineNo; Rec."Line No.")
                {
                    Caption = 'Shipment Line No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(ShipmentItemNo; Rec."No.")
                {
                    Caption = 'Shipment Item No.';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.';
                }
            }
        }
    }
}
