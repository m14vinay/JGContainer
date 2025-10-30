tableextension 50218 "Prod. Order Line Ext" extends "Prod. Order Line"
{
    fields
    {
        field(50200; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            BlankZero = True;
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
