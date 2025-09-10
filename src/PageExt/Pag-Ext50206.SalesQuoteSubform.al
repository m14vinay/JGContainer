pageextension 50206 "Sales Quote Subform" extends "Sales Quote Subform"
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
    }
}
