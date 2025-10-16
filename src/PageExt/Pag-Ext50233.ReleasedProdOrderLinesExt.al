pageextension 50233 "Released Prod. Order Lines Ext" extends "Released Prod. Order Lines"
{
    layout{
        addafter(Quantity)
        {
            field("Net Weight"; Rec."Net Weight")
            {
                ToolTip = 'Specifies the Net Weight';
                ApplicationArea = All;
            }
        }
        
    }
}
