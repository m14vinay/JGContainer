tableextension 50229 "Warehouse Ship Line Ext" extends "Warehouse Shipment Line"
{
    fields
    {
        field(50200; Returnable; Boolean)
        {
            Caption = 'Returnable';
            DataClassification = ToBeClassified;
        }
    }
}
