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
