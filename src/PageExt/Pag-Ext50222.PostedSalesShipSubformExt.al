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
        }
    }
}
