pageextension 50243 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
{
     layout{
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including SST';
        }
    }
    actions
    {
        modify("Print")
        {
            trigger OnBeforeAction()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
            begin
                SalesInvoiceHeader.Copy(Rec);
                CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                Report.RunModal(Report::"SalesInvoiceReport", true, true, SalesInvoiceHeader);
            end;
        }
    }
}
