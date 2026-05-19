tableextension 50202 "Sales Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50200; "SST Exempted BPG"; Code[20])
        {
            Caption = 'SST Exempted Business Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group".Code;
        }
        field(50201; "Proforma Invoice Nos."; Code[20])
        {
            Caption = 'Proforma Invoice Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }
        field(50202; "Commercial Invoice Nos."; Code[20])
        {
            Caption = 'Commercial Invoice Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }
        field(50203; "Customer Complaint Report No."; Code[20])
        {
            Caption = 'Customer Complaint Report No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }
        field(50204; "Terms and Conditions Sales"; Text[150])
        {
            Caption = 'Terms and Conditions Sales';
            ExtendedDatatype = URL;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'SST Bus. Posting Gr. (Price)';
        }
        modify("Allow VAT Difference")
        {
            Caption = 'Allow SST Difference';
        }
        modify("Calc. Inv. Disc. per VAT ID")
        {
            Caption = 'Calc. Inv. Disc. per SST ID';
        }

    }
}
