pageextension 50218 "Whse Ship Ext" extends "Warehouse Shipment"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ToolTip = 'Specifies Vehicle No.';
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Delivery Area"; Rec."Delivery Area")
            {
                ToolTip = 'Delivery Area';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Autofill Qty. to Ship")
        {
            action(SelectTransportServices)
            {
                ApplicationArea = All;
                Caption = 'Transport Contract Services';
                Image = ServiceItem;
                Promoted = True;
                PromotedIsBig = True;
                PromotedCategory = Category7;
                ToolTip = 'Show Transport Contract Pricing List';
                trigger OnAction()
                var
                    TransportPricing: Record "Transport Contract Pricing";
                    JGSingleInstance: Codeunit "JGSingleInstance";
                begin
                    JGSingleInstance.SetWhseShipNo(Rec."No.");
                    TransportPricing.Reset();
                    TransportPricing.SetRange("Carrier Code", Rec."Shipping Agent Code");
                    TransportPricing.SetRange("Delivery Area Code", Rec."Delivery Area");
                    TransportPricing.Setfilter("Starting Date", '<=%1', Rec."Posting Date");
                    If TransportPricing."Ending Date" <> 0D then
                    TransportPricing.Setfilter("Ending Date", '>=%1', Rec."Posting Date");
                    Page.RunModal(Page::"Transport Contract Services", TransportPricing);
                end;
            }
            action(SelectedTransportServices)
            {
                ApplicationArea = All;
                Caption = 'Selected Contract Services';
                Image = ServiceLines;
                Promoted = True;
                PromotedIsBig = True;
                PromotedCategory = Category7;
                ToolTip = 'Show selected transport contract services';
                RunObject = page "Whse Shipment Services";
                RunPageLink = "Whse Shipment No." = field("No.");
            }
        }
    }
}
