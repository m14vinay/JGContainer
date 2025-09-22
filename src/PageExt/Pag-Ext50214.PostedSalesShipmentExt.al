pageextension 50214 "Posted Sales Shipment Ext" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field(Incoterms; Rec.Incoterms)
            {
                ToolTip = 'Specifies Incoterms';
                ApplicationArea = All;
            }

        }
        addafter("Ship-to Phone No.")
        {
            field("Delivery Area"; Rec."Delivery Area")
            {
                ToolTip = 'Delivery Area';
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
        {
            field(Vessel; Rec.Vessel)
            {
                ToolTip = 'Specifies vessel';
                ApplicationArea = All;
            }
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ToolTip = 'Specifies vehicle no';
                ApplicationArea = All;
            }
        }
        addafter("Package Tracking No.")
        {
            field("Shipment From"; Rec."Shipment From")
            {
                ToolTip = 'Specifies Shipment From';
                ApplicationArea = All;
            }
            field("Shipment To"; Rec."Shipment To")
            {
                ToolTip = 'Specifies Shipment To';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Shipment")
        {
            action(DeliveryOrderReport)
            {
                ApplicationArea = All;
                Caption = 'Print Delivery Order';
                Image = Report; // Optional icon
                trigger OnAction()
                var
                    MyReportID: Integer;
                    OrderNo: Record "Sales Shipment Header";
                begin
                    MyReportID := Report::DeliveryOrderReport; // Replace with your report ID or name
                    // Run without request page
                    // Report.Run(MyReportID, false, false); 

                    // Run with request page
                    CurrPage.SetSelectionFilter(OrderNo);
                    //SalesOrderNo.SetRange("Order No.", rec."Order No.");
                    Report.RunModal(MyReportID, true, false, OrderNo);
                end;
            }
            action(TransportContractDetails)
            {
                ApplicationArea = All;
                Caption = 'Transport Cost Details';
                Image = ViewDetails;
                Promoted = True;
                PromotedIsBig = True;
                PromotedCategory = Category5;
                ToolTip = 'Show Transport Cost Details';
                trigger OnAction()
                var
                    TransportPricing: Record "Transport Contract Pricing";
                    JGSingleInstance: Codeunit "JGSingleInstance";
                begin
                    JGSingleInstance.SetWhseShipNo(Rec."Whse Ship No");
                    JGSingleInstance.SetShipNo(Rec."No.");
                    Page.RunModal(Page::"Transport Cost Details");
                end;
            }

        }

    }
}
