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
         field(50202; "Quantity Pieces"; Decimal)
        {
            Caption = 'Quantity Pieces';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            BlankZero = True;
            Editable = false;
        }
          field(50203; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            BlankZero = True;
            Editable = false;
        }
    }
}
