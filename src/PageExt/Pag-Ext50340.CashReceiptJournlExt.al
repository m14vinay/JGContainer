pageextension 50340 "Cash Receipt Journl Ext" extends "Cash Receipt Journal"
{
    layout{
        addbefore("Payment Method Code")
        {
             field("Payment Reference"; Rec."Payment Reference")
            {
                ApplicationArea = All;
            }
        }
    }
}
