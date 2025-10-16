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
        addafter("Order Nos.")
        {
            field("Proforma Invoice Nos."; Rec."Proforma Invoice Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Proforma Invoice Nos.';
            }
            field("Commercial Invoice Nos."; Rec."Commercial Invoice Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Commercial Invoice Nos.';
            }
        }
            modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'SST Bus. Posting Gr. (Price)';
        }
         modify("Allow VAT Difference")
        {
            Caption = 'Allow SST Difference';
        }
         modify("Calc. Inv. Disc. per VAT ID")
        {
            Caption = 'Calc. Inv. Disc. per SST ID';
        }
    }
}
