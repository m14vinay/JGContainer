pageextension 50213 "Sales CrMemo Ext" extends "Sales Credit Memo"
{
    layout
    {
        addafter(Status)
        {
            field(Vessel; Rec.Vessel)
            {
                ToolTip = 'Specifies vessel';
                ApplicationArea = All;
            }
            field("Vessel 1"; Rec."Vessel 1")
            {
                ToolTip = 'Specifies Mother vessel';
                ApplicationArea = All;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("SST Exemption registration No."; Rec."SST Exemption registration No.")
            {
                ToolTip = 'SST Exemption registration No.';
                ApplicationArea = All;
            }
        }
          modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
        modify("VAT Country/Region Code")
        {
            Caption = 'SST Country/Region Code';
        }
        modify("VAT Registration No.")
        {
            Caption = 'SST Registration No.';
        }
        modify("VAT Reporting Date")
        {
            Caption = 'SST Reporting Date';
        }
          modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
        }
    }
}
