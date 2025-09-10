pageextension 50215 "Posted Sales Inv Ext" extends "Posted Sales Invoice"
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
        addafter("Payment Method Code")
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
        addafter("AttachAsPDF")
        {
            action(CustomActionForDebitNote)
            {
                ApplicationArea = All;
                Caption = 'Print Debit Note';
                Image = Report; // Optional icon
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    MyReportID: Integer;
                    DocumentNo: Record "Sales Invoice Header";
                begin
                    MyReportID := Report::SalesDebitNoteReport;  

                
                    CurrPage.SetSelectionFilter(DocumentNo);
                   
                    Report.RunModal(MyReportID, true, false, DocumentNo);
                end;
            }
        }
    }
}
