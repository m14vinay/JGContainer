tableextension 50207 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
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
        field(50206; "SST Exemption Registration No."; Text[30])
        {
            Caption = 'SST Exemption Registration No.';
            DataClassification = CustomerContent;
            TableRelation = "SST Exemption Details"."SST Exemption Registration No." where("Customer No." = field("Sell-to Customer No."));
            trigger OnValidate()
            var
                SSTExemptionDetails: Record "SST Exemption Details";
                Customer : Record Customer;
                SalesLine : Record "Sales Line";
            begin
                SSTExemptionDetails.Reset();
                SSTExemptionDetails.SetRange("Customer No.", "Sell-to Customer No.");
                SSTExemptionDetails.SetRange("SST Exemption Registration No.", Rec."SST Exemption Registration No.");
                SSTExemptionDetails.SetFilter("Effective Date", '<=%1', Rec."Document Date");
                SSTExemptionDetails.SetFilter("Expiry Date", '=%1|>=%2', 0D, Rec."Document Date");
                If SSTExemptionDetails.FindFirst() then
                    Rec.Validate("VAT Bus. Posting Group", SSTExemptionDetails."SST Business Posting Group")
                Else
                    Error('It is not within the date range/Expired');
                If Customer.Get("Sell-to Customer No.") then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type",SalesLine."Document Type"::Order);
                    SalesLine.SetRange("Document No.","No.");
                    SalesLine.SetRange(Type,SalesLine.Type::Item);
                    SalesLine.SetRange("ADY E-INV Classification Code",'');
                    if SalesLine.FindSet() then 
                        repeat
                            SalesLine.Validate("ADY E-INV Classification Code", Customer."ADY E-INV Classification Code");
                            SalesLine.Modify();
                        until SalesLine.Next() = 0;
                end;
                  
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
            TableRelation = "Sales Header"."No." where("Document Type" = CONST(Invoice));
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
    trigger OnBeforeDelete()
    begin
        If Rec."Document Type" = Rec."Document Type"::Order then
           Rec.TestField("Reason Code");
       
    end;
    

}
