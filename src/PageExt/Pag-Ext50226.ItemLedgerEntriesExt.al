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
        addafter(Quantity)
        {
             field("Quantity Pieces"; Rec."Quantity Pieces")
            {
                ToolTip = 'Specifies the Quantity Pieces';
                ApplicationArea = All;
            }
             field("Net Weight"; Rec."Net Weight")
            {
                ToolTip = 'Specifies the Net Weight';
                ApplicationArea = All;
            }
        }
        
    }
}
