tableextension 50210 "Sales Shipment Hdr" extends "Sales Shipment Header"
{
    fields
    {
        field(50201; "Incoterms"; Code[20])
        {
            Caption = 'Incoterms';
            DataClassification = CustomerContent;
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
        field(50206; "SST Exemption registration No."; Text[20])
        {
            Caption = 'SST Exemption registration No.';
            DataClassification = CustomerContent;
            TableRelation = "SST Exemption Details"."SST Exemption Registration No.";
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
        field(50213; "Measurement"; Text[50])
        {
            Caption = 'Measurement';
            DataClassification = CustomerContent;
        }
        field(50214; "Vessel 1"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Mother Vessel';
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
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
    }
}
