pageextension 50225 "Item Journal Ext" extends "Item Journal"
{
    layout{
        addafter("Applies-to Entry")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ToolTip = 'Specifies the Customer no';
                ApplicationArea = All;
            }
        }
    }
}
