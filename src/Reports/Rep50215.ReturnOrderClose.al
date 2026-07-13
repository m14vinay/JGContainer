report 50215 "Return Order Close"
{
    ApplicationArea = All;
    Caption = 'Return Order Close';
    UsageCategory = Tasks;
    ProcessingOnly = True;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = where("Document Type" = CONST("Return Order"), Closed = CONST(FALSE));
            trigger OnAfterGetRecord()
            begin
                FullyInvoiced := True;
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::"Return Order");
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                If SalesLine.FindSet() then
                    repeat
                        If SalesLine.Quantity <> SalesLine."Quantity Invoiced" then
                            FullyInvoiced := false;
                    until SalesLine.Next() = 0;
                If FullyInvoiced then begin
                   SalesHeader.Closed := true;
                   SalesHeader.Modify();
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        SalesLine: Record "Sales Line";
        FullyInvoiced: Boolean;
}
