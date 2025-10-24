pageextension 50332 "Sales Cre Memo Stat Ext" extends "Sales Credit Memo Statistics"
{
    layout
    {
        modify(VATAmount)
        {
            CaptionClass = 'SST Amount';
            Caption = 'SST Amount';
        }
    }
}
