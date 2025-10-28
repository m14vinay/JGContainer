pageextension 50338 "VAT Posting Setup Ext" extends "VAT Posting Setup"
{
     Caption = 'SST Posting Setup';
    layout
    {
        modify("VAT %")
        {
            Caption = 'SST %';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
        modify("VAT Clause Code")
        {
            Caption = 'SST Clause Code';
        }
        modify("VAT Identifier")
        {
            Caption = 'SST Identifier';
        }
        modify("Sales VAT Account")
        {
            Caption = 'SST Account';
        }
         modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
    }
}
