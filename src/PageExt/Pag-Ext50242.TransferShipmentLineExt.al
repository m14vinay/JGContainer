pageextension 50242 "Transfer Shipment Line Ext" extends "Posted Transfer Shpt. Subform"
{
     layout
    {
        addafter(Quantity)
        {
            field("Quantity Pieces"; Rec."Quantity Pieces")
            {
                ToolTip = 'Specifies the Quantity Pieces';
                ApplicationArea = All;
            }
        }
    }
}
