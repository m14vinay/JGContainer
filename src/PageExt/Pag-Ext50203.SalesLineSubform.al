pageextension 50203 "Sales Line Subform" extends "Sales Order Subform"
{
    layout
    {
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
