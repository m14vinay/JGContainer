pageextension 50248 "Sales Order List Ext" extends "Sales Order List"
{
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
