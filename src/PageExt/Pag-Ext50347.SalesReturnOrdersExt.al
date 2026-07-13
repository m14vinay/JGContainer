pageextension 50347 "Sales Return Orders Ext" extends "Sales Return Order List"
{
    layout{
        addafter(Status)
        {
            field(Closed; Rec.Closed)
            {
                ToolTip = 'Specifies the Closed';
                ApplicationArea = All;
            }
        }
    }
}
