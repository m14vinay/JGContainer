page 50204 "Sales Shipment Header"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'commit';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesShipmentHeader';
    Editable = false;
    EntityName = 'salesShipmentHeader';
    EntitySetName = 'salesShipmentHeaders';
    PageType = API;
    SourceTable = "Sales Shipment Header";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(packslipno; Rec."No.")
                {
                    Caption = 'Pack slip No.';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(Lorryno; Rec."Vehicle No.")
                {
                    Caption = 'Lorry No.';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
            }
        }
    }
}
