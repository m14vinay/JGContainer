pageextension 50243 "Transfer Order Line Ext" extends "Transfer Order Subform"
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
