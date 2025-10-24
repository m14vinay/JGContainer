pageextension 50334 "GST Sales Entries Ext" extends "GST Sales Entries"
{
     layout{
        modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
         modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
        modify("VAT Calculation Type")
        {
            Caption = 'SST Calculation Type';
        }
         modify(GSTPercentage)
        {
            Caption = 'SST %';
        }
          modify("GST Base")
        {
            Caption = 'SST Base';
        }
    }
}
