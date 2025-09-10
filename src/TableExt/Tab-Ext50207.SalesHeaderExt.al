tableextension 50207 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50201; "Incoterms"; Code[20])
        {
            Caption = 'Incoterms';
            DataClassification = CustomerContent;
            TableRelation = Incoterms;
        }
        field(50202; Vessel; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Vessel';
        }
        field(50203; "Shipment From"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment From';
        }
        field(50204; "Shipment To"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment To';
        }
        field(50205; "Vehicle No."; Text[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
        field(50206; "SST Exemption registration No."; Text[20])
        {
            Caption = 'SST Exemption registration No.';
            DataClassification = CustomerContent;
            TableRelation = "SST Exemption Details"."SST Exemption Registration No." where("Customer No." = field("Sell-to Customer No."));
            trigger OnValidate()
            var
                SalesReceivablesSetup: Record "Sales & Receivables Setup";
            begin
                SalesReceivablesSetup.Get();
                If "SST Exemption registration No." <> '' then
                    Rec.Validate("VAT Bus. Posting Group", SalesReceivablesSetup."SST Exempted BPG");

            end;
        }
        field(50207; "Delivery Area"; Code[20])
        {
            Caption = 'Delivery Area';
            DataClassification = CustomerContent;
            TableRelation = "Delivery Area"."Delivery Area Code";
        }
         field(50208; "Whse Ship No"; Code[20])
        {
            Caption = 'Whse Ship No';
            DataClassification = CustomerContent;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Customer: Record Customer;
            begin
                If Customer.Get("Sell-to Customer No.") then
                    Incoterms := Customer.Incoterms;
            end;
        }
    }

}
