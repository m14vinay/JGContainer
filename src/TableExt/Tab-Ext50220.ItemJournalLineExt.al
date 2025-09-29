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
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PackSize: Record "Pack Size";
            begin
                If Item.Get("Item No.") then
                    If Item."Pack Size" <> '' then
                        If PackSize.Get(Item."Pack Size") then
                            "Quantity Pieces" := PackSize."Qty Per Pack" * Quantity;
            end;
        }
        modify("Output Quantity")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PackSize: Record "Pack Size";
            begin
                If Item.Get("Item No.") then
                    If Item."Pack Size" <> '' then
                        If PackSize.Get(Item."Pack Size") then
                            "Quantity Pieces" := PackSize."Qty Per Pack" * Quantity;
            end;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                If Item.Get("Item No.") then
                    "Net Weight" := Item."Net Weight"
            end;
        }
    }

}
