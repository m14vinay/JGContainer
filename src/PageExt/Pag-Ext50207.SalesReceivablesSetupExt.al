pageextension 50207 "Sales Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    layout{
        addafter("Payment Discount Reason Code")
        {
            field("SST Exempted BPG"; Rec."SST Exempted BPG")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies SST Exempted Business Posting Group';
            }
        }
    }
}
