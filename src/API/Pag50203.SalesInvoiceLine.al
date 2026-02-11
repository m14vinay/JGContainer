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
    SourceTableView = where("No." = filter(<> ''), Type = CONST(Item));
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
                field(salesTax; Rec."Amount Including VAT" - Rec.Amount)
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

                field(pricePerPiece; Rec."Price Per Piece")
                {
                    Caption = 'Price Per Piece';
                }
                field(qtyPerPack; Rec."Qty Per Pack")
                {
                    Caption = 'Qty Per Pack';
                }
                field(quantityPieces; Rec."Quantity Pieces")
                {
                    Caption = 'Quantity Pieces';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(amountLCY; AmountLCY)
                {
                    Caption = 'amountLCY';
                }
                 field(amountincvatlcy; Amountincvatlcy)
                {
                    Caption = 'amountincvatlcy';
                }
                 field(unitPriceLcy; unitPriceLcy)
                {
                    Caption = 'unitPriceLcy';
                }
                 field(unitPrice; "Unit Price")
                {
                    Caption = 'unitPrice';
                }
            }
        }
    }
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Amountincvatlcy: Decimal;
        AmountLCY : Decimal;
        unitPriceLcy : Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Currency  : Record Currency;
    trigger OnAfterGetRecord()
    begin
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", Rec."Document No.");
        If SalesInvoiceHeader.FindFirst() then begin
            If SalesInvoiceHeader."Currency Code" = '' then begin
            Amountincvatlcy := Rec."Amount Including VAT";
            AmountLCY := Rec.Amount;
            end else begin
            If Currency.Get(SalesInvoiceHeader."Currency Code") then;
            Amountincvatlcy := Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Rec."Posting Date", SalesInvoiceHeader."Currency Code", (Rec."Amount Including VAT"), SalesInvoiceHeader."Currency Factor"), Currency."Amount Rounding Precision");
            AmountLCY  := Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Rec."Posting Date", SalesInvoiceHeader."Currency Code", (Rec.Amount), SalesInvoiceHeader."Currency Factor"), Currency."Amount Rounding Precision");
            unitPriceLcy := Round(CurrencyExchangeRate.ExchangeAmtFCYToLCY(Rec."Posting Date", SalesInvoiceHeader."Currency Code", (Rec."Unit Price"), SalesInvoiceHeader."Currency Factor"), Currency."Amount Rounding Precision");
            end;
        end;
    end;
}
