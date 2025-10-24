pageextension 50244 "Sales Order Statistics Ext" extends "Sales Order Statistics"
{
    layout
    {
        modify(VATAmount)
        {
            CaptionClass = 'SST Amount';
            Caption = 'SST Amount';
        }
        modify(VATAmount_Invoicing)
        {
            CaptionClass = 'SST Amount';
            Caption = 'SST Amount';
        }
        modify("VATAmount[3]")
        {
            CaptionClass = 'SST Amount';
            Caption = 'SST Amount';
        }
        modify(PrepmtVATAmount)
        {
            Caption = 'SST Amount';
            CaptionClass = 'SST Amount';
        }
    }
}
