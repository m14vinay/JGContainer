report 50202 "Generate Commercial Invoice"
{
    ApplicationArea = All;
    Caption = 'Generate Commercial Invoice & Packing List';
    UsageCategory = Tasks;
    ProcessingOnly = True;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            trigger OnAfterGetRecord()
            var
                SalesInvoice: Record "Sales Header";
                NoSeries: Codeunit "No. Series";
                SalesRecSetup: Record "Sales & Receivables Setup";
                SalesOrder : Record "Sales Header";
            begin
                SalesRecSetup.Get();
                //SalesInvoice.InitFromSalesHeader(SalesHeader);
                SalesInvoice.Validate("Document Type", SalesInvoice."Document Type"::Invoice);
                SalesInvoice.Validate("No.", NoSeries.GetNextNo(SalesRecSetup."Commercial Invoice Nos."));
                SalesInvoice.Status := SalesInvoice.Status::Open;
                SalesInvoice.Insert(True);
                SalesInvoice.Validate("Sell-to Customer No.",SalesHeader."Sell-to Customer No.");
                SalesInvoice.Validate("Posting Date",CommercialInvoiceDate);
                SalesInvoice.Validate("Document Date",CommercialInvoiceDate);
                SalesInvoice."Order No" := SalesHeader."No.";
                SalesInvoice.Validate("Currency Code",SalesHeader."Currency Code");
                SalesInvoice.Validate("Your Reference",SalesHeader."Your Reference");
                SalesInvoice.Validate("Payment Method Code" , SalesHeader."Payment Method Code");
                SalesInvoice.Validate("Gen. Bus. Posting Group", SalesHeader."Gen. Bus. Posting Group");
                SalesInvoice.Validate("VAT Bus. Posting Group" , SalesHeader."VAT Bus. Posting Group");
                SalesInvoice.Validate("Shipment Method Code",SalesHeader."Shipment Method Code");
                SalesInvoice.Validate("Shipping Agent Code",SalesHeader."Shipping Agent Code");
                SalesInvoice.Validate("Shipping Agent Service Code",SalesHeader."Shipping Agent Service Code");
                SalesInvoice.Validate(Incoterms,SalesHeader.Incoterms);
                SalesInvoice.Validate("Location Code",SalesHeader."Location Code");
                SalesInvoice.Validate("Dimension Set ID", SalesHeader."Dimension Set ID");
                SalesInvoice.Modify();
                If SalesOrder.Get(SalesOrder."Document Type"::Order,SalesHeader."No.") then begin
                   SalesOrder."Commercial Invoice No" := SalesInvoice."No.";
                   SalesOrder."Commercial Invoice Date" := CommercialInvoiceDate;
                   SalesOrder.Modify();
                end;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(CommercialInvoiceDate; CommercialInvoiceDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Commercial Invoice Date';
                        ToolTip = 'Specifies Commercial Invoice Date to print.';
                    }
                }
            }
        }
    }
    var
        CommercialInvoiceDate: Date;
}
