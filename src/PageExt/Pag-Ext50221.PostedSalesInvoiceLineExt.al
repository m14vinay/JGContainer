pageextension 50221 "Posted Sales Invoice Line Ext" extends "Posted Sales Invoice Subform"
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
              field("Container No."; Rec."Container No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Container No.';
            }
             field(Seal; Rec.Seal)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Seal';
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
