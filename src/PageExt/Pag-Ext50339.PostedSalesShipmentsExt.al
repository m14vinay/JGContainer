pageextension 50339 "Posted Sales Shipments Ext" extends "Posted Sales Shipments"
{
    layout{
        addafter("Posting Date")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
