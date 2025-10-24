pageextension 50206 "Sales Quote Subform" extends "Sales Quote Subform"
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
        modify("Subtotal Excl. VAT")
        {
            Caption = 'Subtotal Excl. SST';
        }
        modify("Total VAT Amount")
        {
            Caption = 'Total SST';
            CaptionClass = Rec.GetCaptionWithCurrencyCode('Total SST',Currency.Code);;
        }
        modify("Total Amount Excl. VAT")
        {
            Caption = 'Total Excl. SST';
            CaptionClass = Rec.GetCaptionWithCurrencyCode('Total Excl. SST',Currency.Code);
        }
        modify("Total Amount Incl. VAT")
        {
            Caption = 'Total Incl. SST';
            CaptionClass = Rec.GetCaptionWithCurrencyCode('Total Incl. SST',Currency.Code);
        }
    }
}
