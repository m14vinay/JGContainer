page 50202 "Sales Invoice Hdr"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'commit';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesInvoiceHdr';
    EntityName = 'SalesInvoiceHeader';
    EntitySetName = 'SalesInvoiceHeaders';
    Editable = false;
    PageType = API;
    SourceTable = "Sales Invoice Header";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                
                field(invoiceno; Rec."No.")
                {
                    Caption = 'Invoice No.';
                }
                field(customercode; Rec."Sell-to Customer No.")
                {
                    Caption = 'Customer Code';
                }
                field(customername; Rec."Sell-to Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(poNo; Rec."Your Reference")
                {
                    Caption = 'Po No.';
                }
                field(saleorderNo; Rec."Order No.")
                {
                    Caption = 'Sale Order No.';
                }
            }
        }
    }
}
