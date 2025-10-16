tableextension 50216 "Sales Credit Memo Line Ext" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50201; "Price Per Piece"; Decimal)
        {
            Caption = 'Price Per Piece';
            DataClassification = CustomerContent;
             DecimalPlaces = 0 : 5;
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
        modify("VAT Amount (ACY)")
        {
            Caption = 'SST Amount (ACY)';
        }
        modify("VAT Base (ACY)")
        {
            Caption = 'SST Base (ACY)';
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
        modify("VAT Difference (ACY)")
        {
            Caption = 'SST Difference (ACY)';
        }
        modify("VAT Identifier")
        {
            Caption = 'SST Identifier';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
        modify("ADY E-INV VAT Bus. Pstg Group")
        {
            Caption = 'ADY E-INV SST Bus. Pstg Group';
        }
        modify("ADY E-INV VAT Prod. Pstg Group")
        {
            Caption = 'ADY E-INV SST Prod. Pstg Group';
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including SST';
        }
        modify("Amount Including VAT (ACY)")
        {
            Caption = 'Amount Including SST (ACY)';
        }
    }
}
