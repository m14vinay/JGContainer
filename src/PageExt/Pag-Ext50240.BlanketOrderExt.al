pageextension 50240 "Blanket Order Ext" extends "Blanket Sales Order"
{
    layout
    {
        addafter("Status")
        {
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ToolTip = 'Specifies vehicle no';
                ApplicationArea = All;
            }
        }
        
         addafter("Package Tracking No.")
        {
            field("Shipment From"; Rec."Shipment From")
            {
                ToolTip = 'Specifies Shipment From';
                ApplicationArea = All;
            }
            field("Shipment To"; Rec."Shipment To")
            {
                ToolTip = 'Specifies Shipment To';
                ApplicationArea = All;
            }
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
          modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
        }
    }
}
