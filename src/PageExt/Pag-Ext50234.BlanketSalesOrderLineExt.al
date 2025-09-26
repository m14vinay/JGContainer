pageextension 50234 "Blanket Sales Order Line Ext" extends "Blanket Sales Order Subform"
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
            field("Price Per Piece"; Rec."Price Per Piece")
            {
                ToolTip = 'Specifies the Price Per Piece';
                ApplicationArea = All;
            }
            field("Qty Per Pack"; Rec."Qty Per Pack")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Qty Per Pack';
            }
        }
         Modify("Net Weight")
        {
                Visible = true;
        }
        Modify("Gross Weight")
        {
            Visible = true;
        }
    }
}

