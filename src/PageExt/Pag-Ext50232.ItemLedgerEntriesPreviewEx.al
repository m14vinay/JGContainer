pageextension 50232 "Item Ledger Entries Preview Ex" extends "Item Ledger Entries Preview"
{
    layout{
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
