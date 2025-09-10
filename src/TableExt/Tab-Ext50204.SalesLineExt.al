tableextension 50204 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50201; "Price Per Piece"; Decimal)
        {
            Caption = 'Price Per Piece';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50202; "Quantity Pieces"; Decimal)
        {
            Caption = 'Quantity Pieces';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50208; "Qty Per Pack"; Decimal)
        {
            Caption = 'Qty Per Pack';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            Editable = false;
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
    }
}

