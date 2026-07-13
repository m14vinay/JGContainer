pageextension 50344 "Approval Entries Ext" extends "Approval Entries"
{
    layout{
        addbefore("Amount (LCY)")
        {
    
         field(Amount; Rec.Amount)
            {
                ToolTip = 'Specifies the Amount';
                ApplicationArea = All;
            }
        }
    }
}
