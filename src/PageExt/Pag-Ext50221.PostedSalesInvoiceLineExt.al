pageextension 50221 "Posted Sales Invoice Line Ext" extends "Posted Sales Invoice Subform"
{
    layout{
        addafter(Quantity)
        {
             field("Price Per Piece"; Rec."Price Per Piece")
            {
                ApplicationArea = All;
            }
             field("Quantity Pieces"; Rec."Quantity Pieces")
            {
                ApplicationArea = All;
            }
              field("Qty Per Pack"; Rec."Qty Per Pack")
            {
                ApplicationArea = All;
            }
              field("Container No."; Rec."Container No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Container No.';
            }
             field(Seal; Rec.Seal)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Seal';
            }
        }
         Modify("Net Weight")
        {
            Visible = true;
        }
        Modify("Gross Weight")
        {
            Visible = true;
        }
          modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
         modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
        modify("VAT %")
        {
            Caption = 'SST %';
        }
         modify("Total VAT Amount")
        {
            Caption = 'Total SST';
            CaptionClass = GetCaptionWithCurrencyCode('Total SST');;
        }
        modify("Total Amount Excl. VAT")
        {
            Caption = 'Total Excl. SST';
            CaptionClass = GetCaptionWithCurrencyCode('Total Excl. SST');
        } 
        modify("Total Amount Incl. VAT")
        {
            Caption = 'Total Incl. SST';
            CaptionClass = GetCaptionWithCurrencyCode('Total Incl. SST');
        }
    }
    procedure GetCaptionWithCurrencyCode(CaptionWithoutCurrencyCode: Text): Text
    var
        GLSetup: Record "General Ledger Setup";
        SalesInvHdr : Record "Sales Invoice Header";
        CurrencyCode : Text[20];
    begin
        If SalesInvHdr.Get(Rec."Document No.") then
         CurrencyCode := SalesInvHdr."Currency Code";
        if CurrencyCode = '' then begin
            GLSetup.Get();
            CurrencyCode := GLSetup.GetCurrencyCode(CurrencyCode);
        end;


        if CurrencyCode <> '' then
            exit(CaptionWithoutCurrencyCode + StrSubstNo(' (%1)', CurrencyCode));

        exit(CaptionWithoutCurrencyCode);
    end;
}
