#pragma warning disable AA0215
pageextension 50224 Item extends "Item Card"
#pragma warning restore AA0215
{
    layout
    {
        addafter("Purchasing Code")
        {
            field("Pallet Tracking Required"; Rec."Pallet Tracking Required")
            {
                ToolTip = 'Specifies whether the pallet tracking required for the item';
                ApplicationArea = All;
            }
            field(Brand; Rec.Brand)
            {
                ToolTip = 'Specifies the Brand of the Item';
                ApplicationArea = All;
            }
             field("Print Charges in Footer"; Rec."Print Charges in Footer")
            {
                ToolTip = 'Specifies the Print Charges in Footer for Reports';
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Pack Size"; Rec."Pack Size")
            {
                ToolTip = 'Specifies the Pack Size of the Item';
                ApplicationArea = All;
            }
        }
        modify(Blocked)
        {
            Editable = false;
        }
          modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'SST Bus. Posting Gr. (Price)';
        }
         modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
         modify("Price Includes VAT")
        {
            Caption = 'Price Includes SST';
        }
    }
    actions
    {
        addafter("Substituti&ons")
        {
            action(BlockItem)
            {
                ApplicationArea = All;
                Caption = 'Block Item';
                Image = Cancel;
                ToolTip = 'Block the item';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Rec.Blocked := True;
                end;
            }
        }
        modify(Approve)
         {
            trigger OnAfterAction()
            begin
                Rec.Blocked := false;
            end;
        }
    }
}
