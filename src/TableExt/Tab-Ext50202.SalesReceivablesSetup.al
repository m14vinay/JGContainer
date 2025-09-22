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
    }
}
