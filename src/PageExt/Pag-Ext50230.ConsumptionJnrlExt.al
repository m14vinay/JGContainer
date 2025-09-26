pageextension 50230 "Consumption Jnrl Ext" extends "Consumption Journal"
{
    layout
    {
        addafter("Quantity")
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
