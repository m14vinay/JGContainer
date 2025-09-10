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
    }
}
