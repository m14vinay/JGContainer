pageextension 50211 "Sales Quote Ext" extends "Sales Quote"
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
                Editable = DeliveryAreaEditable;
            }
        }
        addafter(Status)
        {
            field(Vessel; Rec.Vessel)
            {
                ToolTip = 'Specifies vessel';
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
        addafter("VAT Bus. Posting Group")
        {
            field("SST Exemption registration No."; Rec."SST Exemption registration No.")
            {
                ToolTip = 'SST Exemption registration No.';
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        DeliveryAreaEditable := True;
        If Rec."Ship-to Code" <> '' then
            DeliveryAreaEditable := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        DeliveryAreaEditable := True;
        If Rec."Ship-to Code" <> '' then
            DeliveryAreaEditable := false;
    end;

    var
        DeliveryAreaEditable: Boolean;
}
