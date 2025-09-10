tableextension 50223 ItemUOMExt extends "Item Unit of Measure"
{
    fields
    {
        field(50100; "Qty. per UOM HighPrecision"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure (High Precision)';
            DecimalPlaces = 0:15; // or however many you need
        }
        modify("Qty. per Unit of Measure")
        {
            BlankZero = false;
            
            trigger OnAfterValidate()
            begin

            end;
        }
    }
}