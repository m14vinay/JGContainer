pageextension 50222 "Posted Sales Ship Subform Ext" extends "Posted Sales Shpt. Subform"
{
    layout{
        addafter(Quantity)
        {
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
