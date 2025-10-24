pageextension 50250 "Sales Quote Statistics Ext" extends "Sales Statistics"
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
