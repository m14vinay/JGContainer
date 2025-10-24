pageextension 50335 "General Journal Batch Ext" extends "General Journal Batches"
{
  layout{
    modify("Allow VAT Difference")
    {
       Caption = 'Allow GST Difference';
    }
     modify("Copy VAT Setup to Jnl. Lines")
    {
       Caption = 'Copy SST Setup to Jnl. Lines';
    }
  }
}
