pageextension 50239 "Sales Return Order Ext" extends "Sales Return Order"
{
    layout
    {
        addafter(Status)
        {
            field(Vessel; Rec.Vessel)
            {
                ToolTip = 'Specifies vessel';
                ApplicationArea = All;
            }
              field("Vessel 1"; Rec."Vessel 1")
            {
                ToolTip = 'Specifies Mother vessel';
                ApplicationArea = All;
            }
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ToolTip = 'Specifies vehicle no';
                ApplicationArea = All;
            }
            field(Measurement; Rec.Measurement)
            {
                ToolTip = 'Measurement';
                ApplicationArea = All;
            }
        }
         addafter("Shipping Agent Code")
        {
            field(Incoterms; Rec.Incoterms)
            {
                ToolTip = 'Specifies Incoterms';
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
