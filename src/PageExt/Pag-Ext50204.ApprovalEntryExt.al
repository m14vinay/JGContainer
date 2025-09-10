pageextension 50204 "Approval Entry Ext" extends "Requests to Approve"
{
    actions
    {
        modify(Approve)
        {
            trigger OnAfterAction()
            var
                Item: Record Item;
                Vendor: Record Vendor;
                Customer: Record Customer;
            begin
                If Item.Get(Rec."Record ID to Approve") then begin
                    Item.Blocked := false;
                    Item.Modify(false);
                end;
                If Vendor.Get(Rec."Record ID to Approve") then begin
                    Vendor.Blocked := Vendor.Blocked::" ";
                    Vendor.Modify(false);
                end;
                If Customer.Get(Rec."Record ID to Approve") then begin
                    Customer.Blocked := Vendor.Blocked::" ";
                    Customer.Modify(false);
                end;
            end;
        }
    }
}
