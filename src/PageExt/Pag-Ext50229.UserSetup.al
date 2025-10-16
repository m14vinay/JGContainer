pageextension 50229 "User Setup" extends "User Setup"
{
    layout{
        addafter("Salespers./Purch. Code")
        {
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ToolTip = 'Specifies whether the pallet tracking required for the item';
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
