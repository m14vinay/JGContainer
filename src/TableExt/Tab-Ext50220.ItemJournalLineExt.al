tableextension 50220 "Item Journal Line Ext" extends "Item Journal Line"
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
