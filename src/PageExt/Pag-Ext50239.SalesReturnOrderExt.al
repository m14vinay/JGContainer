pageextension 50239 "Sales Return Order Ext" extends "Sales Return Order"
{
    layout
    {
        addafter(Status)
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
        modify("VAT Country/Region Code")
        {
            Caption = 'SST Country/Region Code';
        }
        modify("VAT Registration No.")
        {
            Caption = 'SST Registration No.';
        }
        modify("VAT Reporting Date")
        {
            Caption = 'SST Reporting Date';
        }
          modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
        }
    }
}
