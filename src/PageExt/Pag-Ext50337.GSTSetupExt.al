pageextension 50337 "GST Setup Ext" extends "VAT Setup"
{
    layout
    {
        modify("Allow VAT To")
        {
            Caption = 'Allow SST To';
        }
        modify("Allow VAT From")
        {
            Caption = 'Allow SST From';
        }
        modify("Show Non-Ded. VAT In Lines")
        {
            Caption = 'Show Non-Ded. SST In Lines';
        }
        modify("Enable Non-Deductible VAT")
        {
            Caption = 'Enable Non-Deductible SST';
        }
    }
    actions{
        modify(VATPostingGroups)
        {
            Caption = 'SST Posting Groups';
        }
    }
}
