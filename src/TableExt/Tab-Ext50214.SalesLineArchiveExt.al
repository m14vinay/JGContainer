tableextension 50214 "Sales Line Archive Ext" extends "Sales Line Archive"
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
        modify("VAT Clause Code")
        {
            Caption = 'SST Clause Code';
        }
        modify("VAT Difference")
        {
            Caption = 'SST Difference';
        }
        modify("VAT Identifier")
        {
            Caption = 'SST Identifier';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
        modify("Prepmt. VAT Base Amt.")
        {
            Caption = 'Prepmt. SST Base Amt.';
        }
        modify("Prepayment VAT %")
        {
            Caption = 'Prepayment SST %';
        }
        modify("Prepayment VAT Identifier")
        {
            Caption = 'Prepayment SST Identifier';
        }
        modify("Prepmt. VAT Calc. Type")
        {
            Caption = 'Prepmt. SST Calc. Type';
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including SST';
        }
        modify("Prepmt. Amt. Incl. VAT")
        {
            Caption = 'Prepmt. Amt. Incl. SST';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            Caption = 'Prepmt. Amount Inv. Incl. SST';
        }
    }
}
