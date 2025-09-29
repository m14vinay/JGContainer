pageextension 50208 "Sales Invoice Subform Ext" extends "Sales Invoice Subform"
{
    layout{
        addafter(Quantity)
        {
             field("Price Per Piece"; Rec."Price Per Piece")
            {
                ApplicationArea = All;
            }
             field("Quantity Pieces"; Rec."Quantity Pieces")
            {
                ApplicationArea = All;
            }
             field("Qty Per Pack"; Rec."Qty Per Pack")
            {
                ApplicationArea = All;
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
