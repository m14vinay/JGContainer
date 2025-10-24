pageextension 50333 "Posted Sales Cr Notes Ext" extends "Posted Sales Credit Memos"
{
    layout{
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including SST';
        }
    }
}
