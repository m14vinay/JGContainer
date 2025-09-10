pageextension 50205 "Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        addafter("Allow Inventory Adjustment")
        {
            field("IPG to Split Item & Variant"; Rec."IPG to Split Item & Variant")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies IPG to Split Item & Variant';
            }
        }
        addafter("Package Nos.")
        {
             field("MR No."; Rec."MR No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies MR No.';
            }
        }
    }
}
