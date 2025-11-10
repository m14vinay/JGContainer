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
            Caption = 'Feeder Vessel';
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
        field(50206; "SST Exemption Registration No."; Text[20])
        {
            Caption = 'SST Exemption Registration No.';
            DataClassification = CustomerContent;
            TableRelation = "SST Exemption Details"."SST Exemption Registration No." where("Customer No." = field("Sell-to Customer No."));
            trigger OnValidate()
            var
                SSTExemptionDetails: Record "SST Exemption Details";
            begin
                SSTExemptionDetails.Reset();
                SSTExemptionDetails.SetRange("Customer No.","Sell-to Customer No.");
                SSTExemptionDetails.SetRange("SST Exemption Registration No.",Rec."SST Exemption Registration No.");
                If SSTExemptionDetails.FindFirst() then
                    Rec.Validate("VAT Bus. Posting Group", SSTExemptionDetails."SST Business Posting Group");

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
        field(50209; "Proforma Invoice No"; Code[20])
        {
            Caption = 'Proforma Invoice No';
            DataClassification = CustomerContent;
        }
        field(50210; "Commercial Invoice No"; Code[20])
        {
            Caption = 'Commercial Invoice No';
            DataClassification = CustomerContent;
        }
        field(50211; "Order No"; Code[20])
        {
            Caption = 'Order No';
            DataClassification = CustomerContent;
        }
        field(50212; "Commercial Invoice Date"; Date)
        {
            Caption = 'Commercial Invoice Date';
            DataClassification = CustomerContent;
        }
        field(50214; "Vessel 1"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Mother Vessel';
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
        modify("VAT Base Discount %")
        {
            Caption = 'SST Base Discount %';
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
        modify("Alt. VAT Bus Posting Group")
        {
            Caption = 'Alt. SST Bus Posting Group';
        }
        modify("Alt. VAT Registration No.")
        {
            Caption = 'Alt. SST Registration No.';
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including SST';
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
        }
    }

}
