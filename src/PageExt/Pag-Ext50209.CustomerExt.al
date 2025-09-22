pageextension 50209 "Customer Ext" extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Agent/Distributor Name"; Rec."Agent/Distributor Name")
            {
                ToolTip = 'Specifies agent/distributor name';
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
             field(Incoterms; Rec.Incoterms)
            {
                ToolTip = 'Specifies Incoterms';
                ApplicationArea = All;
            }
             field("Place of Export"; Rec."Place of Export")
            {
                ToolTip = 'Specifies Place of Export';
                ApplicationArea = All;
            }
        }
         modify(Blocked)
        {
            Editable = false;
        }
        addafter("Phone No.")
        {
            field("Phone No. 2"; Rec."Phone No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer''s telephone number 2.';
            }
        }
    }
    actions
    {
        addlast("&Customer")
        {
            action(BlockCustomer)
            {
                ApplicationArea = All;
                Caption = 'Block Customer';
                Image = Cancel;
                ToolTip = 'Block the Customer';
                Promoted = true;
                PromotedCategory = Category9;
                trigger OnAction()
                begin
                    Rec.Blocked := Rec.Blocked::All;
                end;
            }
            action(SSTExemptionList)
            {
                ApplicationArea = All;
                Caption = 'SST Exemption Details';
                Image = VATExemption;
                ToolTip = 'SST Exemption Details';
                Promoted = true;
                PromotedCategory = Category9;
                RunObject = page "SST Exemption Details";
                RunPageLink = "Customer No." = field("No.");
            }
        }
        modify(Approve)
         {
            trigger OnAfterAction()
            begin
                Rec.Blocked := Rec.Blocked::" ";
            end;
        }
    }
}
