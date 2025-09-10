pageextension 50210 "Sales Order Ext" extends "Sales Order"
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
                Editable = DeliveryAreaEditable;
            }
        }
        addafter(Status)
        {
            field(Vessel; Rec.Vessel)
            {
                ToolTip = 'Specifies vessel';
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
        addafter("VAT Bus. Posting Group")
        {
            field("SST Exemption registration No."; Rec."SST Exemption registration No.")
            {
                ToolTip = 'SST Exemption registration No.';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Work Order")
        {
            action(CommercialInvoice)
            {
                ApplicationArea = All;
                Caption = 'Print Commercial Invoice';
                Image = Report; // Optional icon
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category11;
                trigger OnAction()
                var
                    MyReportID: Integer;
                    DocumentNo: Record "Sales Header";
                begin
                    MyReportID := Report::CommercialInvoiceReport; // Replace with your report ID or name
                                                                   // Run without request page
                                                                   // Report.Run(MyReportID, false, false); 

                    // Run with request page
                    CurrPage.SetSelectionFilter(DocumentNo);
                    //DocumentNo.Reset();
                    //DocumentNo.SETRANGE("Document No.", Rec."Document No.");
                    Report.RunModal(MyReportID, true, false, DocumentNo);
                end;
            }
             action(PrintPackingList)
            {
                ApplicationArea = All;
                Caption = 'Print Packing List';
                Image = Report; // Optional icon
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category11;
                trigger OnAction()
                var
                    MyReportID: Integer;
                    DocumentNo: Record "Sales Header";
                begin
                    MyReportID := Report::"Packing List Report"; // Replace with your report ID or name
                                                                   // Run without request page
                                                                   // Report.Run(MyReportID, false, false); 

                    // Run with request page
                    CurrPage.SetSelectionFilter(DocumentNo);
                    //DocumentNo.Reset();
                    //DocumentNo.SETRANGE("Document No.", Rec."Document No.");
                    Report.RunModal(MyReportID, true, false, DocumentNo);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        DeliveryAreaEditable := True;
        If Rec."Ship-to Code" <> '' then
            DeliveryAreaEditable := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        DeliveryAreaEditable := True;
        If Rec."Ship-to Code" <> '' then
            DeliveryAreaEditable := false;
    end;

    var
        DeliveryAreaEditable: Boolean;
}
