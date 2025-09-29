pageextension 50241 "Sales Return Rcpt Ext" extends "Posted Return Receipt"
{
     layout
    {
        addafter("Shipment Method Code")
        {
            field(Incoterms; Rec.Incoterms)
            {
                ToolTip = 'Specifies Incoterms';
                ApplicationArea = All;
            }

        }
        addafter("Responsibility Center")
        {
            field(Vessel; Rec.Vessel)
            {
                ToolTip = 'Specifies vessel';
                ApplicationArea = All;
            }
            field(Measurement; Rec.Measurement)
            {
                ToolTip = 'Measurement';
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
    }
}
