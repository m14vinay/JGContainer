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
        addafter("Completely Shipped")
        {
            field("Reason Code"; Rec."Reason Code")
            {
                ToolTip = 'Reason Code';
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
            Visible = false;
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

                    If (Rec."Currency Code" <> GLSetup."LCY Code") and (Rec."Currency Code" <> '') then begin
                        If Rec."Proforma Invoice No" = '' then begin
                            Rec."Proforma Invoice No" := NoSeries.GetNextNo(SalesReceSetup."Proforma Invoice Nos.");
                            Rec.Modify();
                        end else
                            Message('Proforma Invoice exists');
                    end else
                        Error('Only applicable for foreign currency');

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
                    SalesHeader: Record "Sales Header";
                    GLSetup: Record "General Ledger Setup";
                    NoSeries: Codeunit "No. Series";
                    CustomerNeeded: Record Customer;
                    SalesReceSetup: Record "Sales & Receivables Setup";
                    CommercialInvoice: Report "Generate Commercial Invoice";
                    MyReportID: Integer;
                begin
                    GLSetup.Get();
                    CurrPage.SetSelectionFilter(SalesHeader);
                    MyReportID := Report::"Generate Commercial Invoice";
                    If CustomerNeeded.Get(Rec."Sell-to Customer No.") then;
                    If ((Rec."Currency Code" <> GLSetup."LCY Code") and (Rec."Currency Code" <> '')) or (CustomerNeeded."Commercial Invoice Needed") then
                        Report.RunModal(MyReportID, true, false, SalesHeader)
                    else
                        Error('Only applicable for foreign currency and for customer for which commercial invoice needed');
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
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                SalesLine: Record "Sales Line";
                Item: Record Item;
                DimensionSetEntryApproSend: Record "Dimension Set Entry";
                JobExistApproSend: Boolean;
                InsuffInv: Boolean;
                ItemNO: Code[20];
            begin
                InsuffInv := False;
                Clear(ItemNO);
                Rec.TestField("ADY E-INV MSIC CODE");
                Rec.TestField("ADY E-INV SST Reg No.");
                Rec.TestField("ADY E-INV State Code");
                Rec.TestField("ADY E-INV Rcpt Address");
                Rec.TestField("ADY E-INV Rcpt City");
                Rec.TestField("ADY E-INV Rcpt Post Code");
                Rec.TestField("ADY E-INV Rcpt County");
                Rec."ADY E-INV State Code" := Rec."ADY E-INV Rcpt State Code";
                Rec.TestField("ADY E-INV TTx Registration No.");
                Rec.TestField("ADY E-INV TIN No.");
                Rec.TestField("ADY E-INV ID Type");
                Rec.TestField("ADY E-INV ID No.");
                Rec.TestField("ADY E-INV Rcpt Email");
                Rec.Testfield("ADY E-INV Rcpt Phone No.");
                Rec.TestField("VAT Bus. Posting Group");
                JobExistApproSend := False;
                DimensionSetEntryApproSend.Reset();
                DimensionSetEntryApproSend.SetRange("Dimension Set ID", Rec."Dimension Set ID");
                If DimensionSetEntryApproSend.FindSet() then
                    repeat
                        If DimensionSetEntryApproSend."Dimension Code" = 'CUSTOMER SEGMENT' then
                            JobExistApproSend := True;
                    until DimensionSetEntryApproSend.Next() = 0;
                If not (JobExistApproSend) then
                    Error('Please update dimension Customer Segment');

                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                //SalesLine.SetRange("Item Category Code", 'FG');
                //SalesLine.SetRange("ADY E-INV Classification Code", '');
                If SalesLine.FindSet() then
                    repeat
                        If SalesLine."ADY E-INV Classification Code" = '' then
                            Error('Classification Code must have value in sales line');
                        If Item.Get(SalesLine."No.") then;
                        If Item."Allow Negative Amount" then
                            If SalesLine."Line Amount" > 0 then
                                Error('Transport Discount amount should be negative');
                        Item.CalcFields("Assembly BOM");
                        If Item."Assembly BOM" then begin
                            If SalesLine."Qty. to Assemble to Order" = 0 then
                                Error('Qty. to Assemble to Order must have a value');
                            If SalesLine."Item Category Code" = '' then
                                Error('Item Category Code must have a value');
                            JobExistApproSend := False;
                            DimensionSetEntryApproSend.Reset();
                            DimensionSetEntryApproSend.SetRange("Dimension Set ID", SalesLine."Dimension Set ID");
                            If DimensionSetEntryApproSend.FindSet() then
                                repeat
                                    If DimensionSetEntryApproSend."Dimension Code" = 'ITEM CATEGORY' then
                                        JobExistApproSend := True;
                                until DimensionSetEntryApproSend.Next() = 0;
                            If not (JobExistApproSend) then
                                Error('Please update dimension Item Category for item %1', SalesLine."No.");
                        end;
                        If SalesLine."Item Category Code" = 'FG' then begin
                            Item.CalcFields(Inventory);
                            Item.CalcFields("Qty. on Sales Order");
                            If Item.Inventory - Item."Qty. on Sales Order" < 0 then
                                if not Confirm('Item %1 has insufficient inventory. Do you want to continue sending approval request?', true, SalesLine."No.") then
                                    Error('Approval request not sent due to insufficient inventory for item %1', SalesLine."No.");
                        end;
                    until SalesLine.Next() = 0;


            end;
        }
        modify(Approve)
        {
            trigger OnBeforeAction()
            var
                SalesLine: Record "Sales Line";
                Item: Record Item;
                InsuffInv: Boolean;
                ItemNO: Code[20];
            begin
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                //SalesLine.SetRange("ADY E-INV Classification Code", '');
                SalesLine.SetRange("Item Category Code",'FG');
                If SalesLine.FindSet() then
                    repeat
                        If Item.Get(SalesLine."No.") then;
                        Item.CalcFields(Inventory);
                        Item.CalcFields("Qty. on Sales Order");
                        If Item.Inventory - Item."Qty. on Sales Order" < 0 then begin
                            if not Confirm('Item %1 has insufficient inventory. Do you want to continue sending approval request?', true, SalesLine."No.") then
                                Error('Not approved due to insufficient inventory for item %1', SalesLine."No.");
                        end;
                    until SalesLine.Next() = 0;
            end;
        }
    }

    trigger OnAfterGetRecord()
    begin
        DeliveryAreaEditable := True;
        InvoiceDetailsEditable := True;
        If Rec."Ship-to Code" <> '' then
            DeliveryAreaEditable := false;
        If Rec.Ship then
            InvoiceDetailsEditable := false;
    end;

    trigger OnOpenPage()
    begin
        InvoiceDetailsEditable := True;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        DeliveryAreaEditable := True;
        If Rec."Ship-to Code" <> '' then
            DeliveryAreaEditable := false;
    end;

    Procedure CheckShip()
    begin
        If Rec.Ship then
            Error('Cannot change after shipping');
    end;

    var
        DeliveryAreaEditable: Boolean;
        InvoiceDetailsEditable: Boolean;
}
