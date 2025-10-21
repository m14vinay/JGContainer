pageextension 50242 "Sales Quotes Ext" extends "Sales Quotes"
{
    actions
    {
        modify("Print")
        {
            trigger OnBeforeAction()
            var
                SalesHeader: Record "Sales Header";
            begin
                SalesHeader.Copy(Rec);
                CurrPage.SetSelectionFilter(SalesHeader);
                Report.RunModal(Report::"Sales Quotation Report", true, true, SalesHeader);
            end;
        }
    }
}
