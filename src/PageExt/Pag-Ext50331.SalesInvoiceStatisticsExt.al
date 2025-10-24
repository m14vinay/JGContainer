pageextension 50331 "Sales Invoice Statistics Ext" extends "Sales Invoice Statistics"
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
