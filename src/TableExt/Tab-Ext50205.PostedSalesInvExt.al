tableextension 50205 "Posted Sales Inv Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(50201; "Price Per Piece"; Decimal)
        {
            Caption = 'Price Per Piece';
            DataClassification = CustomerContent;
            Editable = false;
            BlankZero = true;
        }
        field(50202; "Quantity Pieces"; Decimal)
        {
            Caption = 'Quantity Pieces';
            DataClassification = CustomerContent;
            Editable = false;
            BlankZero = true;
        }
        field(50208; "Qty Per Pack"; Decimal)
        {
            Caption = 'Qty Per Pack';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Editable = false;
            BlankZero = true;
        }
        field(50209; "Container No."; Text[100])
        {
            Caption = 'Container No.';
            DataClassification = CustomerContent;
        }
         field(50210; "Seal"; Text[100])
        {
            Caption = 'Seal';
            DataClassification = CustomerContent;
        }
    }
}
