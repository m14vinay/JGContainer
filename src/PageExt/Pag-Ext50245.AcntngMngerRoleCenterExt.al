pageextension 50245 "Acntng Mnger RoleCenter Ext" extends "Accounting Manager Role Center"
{
    layout
    {
        addafter(Control1902304208)
        {
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
