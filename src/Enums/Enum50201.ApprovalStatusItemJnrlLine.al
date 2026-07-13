enum 50201 "Approval Status Item Jnrl Line"
{
    Extensible = true;
    
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; Cancelled)
    {
        Caption = 'Cancelled';
    }
     value(4; Rejected)
    {
        Caption = 'Rejected';
    }
}
