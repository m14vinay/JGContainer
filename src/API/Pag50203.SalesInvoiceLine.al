page 50203 "Sales Invoice Line"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'commit';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesInvoiceLine';
    Editable = false;
    EntityName = 'salesInvoiceLine';
    EntitySetName = 'SalesInvoiceLines';
    PageType = API;
    SourceTable = "Sales Invoice Line";
    SourceTableView = where ("No." = filter(<>''));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(invoiceNo; Rec."Document No.")
                {
                    Caption = 'Invoice No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(itemcode; Rec."No.")
                {
                    Caption = 'Item Code';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Basic Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(salesTax; Rec."Amount Including VAT"- Rec.Amount)
                {
                    Caption = 'sales Tax';
                }
                field(shipmentNo; Rec."Shipment No.")
                {
                    Caption = 'Shipment No.';
                }
                field(shipmentLineNo; Rec."Shipment Line No.")
                {
                    Caption = 'Shipment Line No.';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'sale Order No.';
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.';
                }
                field(vatBaseAmount; Rec."VAT Base Amount")
                {
                    Caption = 'VAT Base Amount';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
            }
        }
    }
}
