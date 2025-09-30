pageextension 50235 "Sales Return Ord Line Ext" extends "Sales Return Order Subform"
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
