tableextension 50215 "Posted Sales Ship Line Ext" extends "Sales Shipment Line"
{
    fields
    {
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
        modify("VAT %")
        {
            Caption = 'SST %';
        }
        modify("VAT Base Amount")
        {
            Caption = 'SST Base Amount';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
        modify("VAT Calculation Type")
        {
            Caption = 'SST Calculation Type';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
    }
}
