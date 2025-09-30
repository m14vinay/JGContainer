pageextension 50217 "Sales Archive Ext" extends "Sales Order Archive"
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
        addafter("Ship-to Phone No.")
        {
            field("Delivery Area"; Rec."Delivery Area")
            {
                ToolTip = 'Delivery Area';
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
            field("Vessel 1"; Rec."Vessel 1")
            {
                ToolTip = 'Specifies Mother vessel';
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
