pageextension 50203 "Sales Line Subform" extends "Sales Order Subform"
{
    layout
    {
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
