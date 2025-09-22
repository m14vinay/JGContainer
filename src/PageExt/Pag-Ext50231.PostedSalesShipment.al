pageextension 50231 PostedSalesShipment extends "Posted Sales Shipments"
{
    actions
    {
        addafter("&Shipment")
        {
            action(DeliveryOrderReport)
            {
                ApplicationArea = All;
                Caption = 'Print Delivery Order';
                Image = Report; // Optional icon
                trigger OnAction()
                var
                    MyReportID: Integer;
                    OrderNo: Record "Sales Shipment Header";
                begin
                    MyReportID := Report::DeliveryOrderReport; // Replace with your report ID or name
                    
                    CurrPage.SetSelectionFilter(OrderNo);
                    Report.RunModal(MyReportID, true, false, OrderNo);
                end;
            }

        }

    }
}