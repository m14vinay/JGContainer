pageextension 50248 "Sales Order List Ext" extends "Sales Order List"
{
    layout{
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including SST';
        }
         modify("Amt. Ship. Not Inv. (LCY)")
        {
            Caption = 'Amount Shipped Not Invoiced (LCY) Incl. SST';
        }
    }
    actions
    {
        modify("Print Confirmation")
        {
            trigger OnBeforeAction()
            var
                SalesHeader: Record "Sales Header";
            begin
                SalesHeader.Copy(Rec);
                CurrPage.SetSelectionFilter(SalesHeader);
                Report.RunModal(Report::SalesOrderReport, true, true, SalesHeader);
            end;
        }
    }
}
