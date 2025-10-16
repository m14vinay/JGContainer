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
         modify("Total VAT Amount")
        {
            Caption = 'Total SST Amount';
        }
          modify("Total Amount Excl. VAT")
        {
            Caption = 'Total Amount Excl. SST';
        }
           modify("Total Amount Incl. VAT")
        {
            Caption = 'Total Amount Incl. SST';
        }
        modify("Subtotal Excl. VAT")
        {
            Caption = 'Subtotal Excl. SST';
        }
    }
}
