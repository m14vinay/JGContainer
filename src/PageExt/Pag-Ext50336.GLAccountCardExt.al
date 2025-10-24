pageextension 50336 "G/L Account Card Ext" extends "G/L Account Card"
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
  }
}
