tableextension 50203 "Inventory Setup" extends "Inventory Setup"
{
    fields
    {
        field(50201; "IPG to Split Item & Variant"; Code[20])
        {
            Caption = 'IPG to Split Item & Variant';
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group".Code;
        }
         field(50202; "MR No."; Code[20])
        {
            Caption = 'MR No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }
    }
}
