tableextension 50204 "Sales Line Ext" extends "Sales Line"
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
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PackSize: Record "Pack Size";
            begin
                If Item.Get("No.") then
                    If PackSize.Get(Item."Pack Size") then
                        "Quantity Pieces" := PackSize."Qty Per Pack" * Quantity;
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                If ("Unit Price" <> 0) And ("Qty Per Pack" <> 0) then
                    "Price Per Piece" := "Unit Price" / "Qty Per Pack";
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PackSize: Record "Pack Size";
            begin
                If Item.Get("No.") then
                    If PackSize.Get(Item."Pack Size") then
                        "Qty Per Pack" := PackSize."Qty Per Pack";
            end;
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
        modify("Prepmt VAT Diff. Deducted")
        {
            Caption = 'Prepmt SST Diff. Deducted';
        }
        modify("Prepmt. VAT Base Deducted")
        {
            Caption = 'Prepmt. SST Base Deducted';
        }
        modify("Prepmt. VAT Amount Deducted")
        {
            Caption = 'Prepmt. SST Amount Deducted';
        }
        modify("Prepmt. VAT Amount Inv. (LCY)")
        {
            Caption = 'Prepmt. SST Amount Inv. (LCY)';
        }
        modify("Prepmt. VAT Base Amt.")
        {
            Caption = 'Prepmt. SST Base Amt.';
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
        modify("Prepayment VAT %")
        {
            Caption = 'Prepayment SST %';
        }
        modify("Prepayment VAT Difference")
        {
            Caption = 'Prepayment SST Difference';
        }
        modify("Prepayment VAT Identifier")
        {
            Caption = 'Prepayment SST Identifier';
        }
        modify("Prepmt VAT Diff. to Deduct")
        {
            Caption = 'Prepmt SST Diff. to Deduct';
        }
        modify("Prepmt. VAT Calc. Type")
        {
            Caption = 'Prepmt. SST Calc. Type';
        }
        modify("Prepmt. Amt. Incl. VAT")
        {
            Caption = 'Prepmt. Amt. Incl. SST';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            Caption = 'Prepmt. Amount Inv. Incl. SST';
        }
        modify("Shipped Not Inv. (LCY) No VAT")
        {
            Caption = 'Shipped Not Inv. (LCY) No SST';
        }
    }
}

