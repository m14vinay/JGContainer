pageextension 50249 "WareShip Line Ext" extends "Whse. Shipment Subform"
{
    layout{
        addafter(Quantity)
        {
            field(Returnable; Rec.Returnable)
            {
                ToolTip = 'Specifies Returnable';
                ApplicationArea = All;
            }
        }
    }
}
