pageextension 50226 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    layout{
        addafter("Item No.")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ToolTip = 'Specifies the Customer no';
                ApplicationArea = All;
            }
        }
    }
}
