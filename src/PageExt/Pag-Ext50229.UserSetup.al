pageextension 50229 "User Setup" extends "User Setup"
{
    layout{
        addafter("Salespers./Purch. Code")
        {
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ToolTip = 'Specifies Dimension Department';
                ApplicationArea = All;
            }
            field("Allowed to Change COA"; Rec."Allowed to Change COA")
            {
                ToolTip = 'Specifies Allowed to Change COA';
                ApplicationArea = All;
            }
        }
         modify("Allow VAT From")
        {
            Caption = 'Allow SST From';
        }
         modify("Allow VAT To")
        {
            Caption = 'Allow SST To';
        }
    }
}
