tableextension 50227 "Transfer Shipment Line Ext" extends "Transfer Shipment Line"
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
    }
}
