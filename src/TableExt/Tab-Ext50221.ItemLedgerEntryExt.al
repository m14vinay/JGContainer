tableextension 50221 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50201; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
    }
}
