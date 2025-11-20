pageextension 50210 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
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
            field("Proforma Invoice No"; Rec."Proforma Invoice No")
            {
                ToolTip = 'Proforma Invoice No';
                ApplicationArea = All;
                Editable = false;
            }
            field("Commercial Invoice No"; Rec."Commercial Invoice No")
            {
                ToolTip = 'Commercial Invoice No';
                ApplicationArea = All;
                Editable = false;
            }
            field("Commercial Invoice Date"; Rec."Commercial Invoice Date")
            {
                ToolTip = 'Commercial Invoice Date';
                ApplicationArea = All;
                Editable = false;
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
            field(Vessel; Rec.Vessel)
            {
                ToolTip = 'Specifies vessel';
                ApplicationArea = All;
            }
              field("Vessel 1"; Rec."Vessel 1")
            {
                ToolTip = 'Specifies Mother vessel';
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
        modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
        modify("VAT Country/Region Code")
        {
            Caption = 'SST Country/Region Code';
        }
        modify("VAT Registration No.")
        {
            Caption = 'SST Registration No.';
        }
        modify("VAT Reporting Date")
        {
            Caption = 'SST Reporting Date';
        }
          modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
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
            action(GenerateProformaInvoice)
            {
                ApplicationArea = All;
                Caption = 'Generate Proforma Invoice';
                Image = CreateDocument; // Optional icon
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                trigger OnAction()
                var
                    GLSetup: Record "General Ledger Setup";
                    NoSeries: Codeunit "No. Series";
                    SalesReceSetup: Record "Sales & Receivables Setup";
                begin
                    GLSetup.Get();
                    SalesReceSetup.Get();

                    If (Rec."Currency Code" <> GLSetup."LCY Code") and (Rec."Currency Code" <> '') then
                        If Rec."Proforma Invoice No" = '' then begin
                            Rec."Proforma Invoice No" := NoSeries.GetNextNo(SalesReceSetup."Proforma Invoice Nos.");
                            Rec.Modify();
                        end else
                            Message('Proforma Invoice exists');
                end;
            }
            action(GenerateCommercialInvoice)
            {
                ApplicationArea = All;
                Caption = 'Generate Commercial Invoice & Packing List';
                Image = CreateDocument; // Optional icon
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                trigger OnAction()
                var
                    SalesHeader : Record "Sales Header";
                    GLSetup: Record "General Ledger Setup";
                    NoSeries: Codeunit "No. Series";
                    SalesReceSetup: Record "Sales & Receivables Setup";
                    CommercialInvoice: Report "Generate Commercial Invoice";
                    MyReportID: Integer;
                begin
                    GLSetup.Get();
                    CurrPage.SetSelectionFilter(SalesHeader);
                    MyReportID := Report::"Generate Commercial Invoice";
                    If (Rec."Currency Code" <> GLSetup."LCY Code") and (Rec."Currency Code" <> '') then
                        Report.RunModal(MyReportID, true, false, SalesHeader);


                end;
            }
            
        }
        modify(ProformaInvoice)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                If Rec."Proforma Invoice No" = '' then
                  Error('Generate Proforma Invoice before report is printed.');
            end;
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
