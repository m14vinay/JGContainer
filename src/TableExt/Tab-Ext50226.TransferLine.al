tableextension 50226 "Transfer Line" extends "Transfer Line"
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
        modify(Quantity)
        {
           trigger OnAfterValidate()
            var
                Item: Record Item;
                PackSize: Record "Pack Size";
            begin
                If Item.Get("Item No.") then
                    If PackSize.Get(Item."Pack Size") then
                        "Quantity Pieces" := PackSize."Qty Per Pack" * Quantity;
            end;
        }
    }

}
