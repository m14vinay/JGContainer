pageextension 50220 "Posted Whse Ship Ext" extends "Posted Whse. Shipment"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Vehicle No."; Rec."Vehicle No.")
            {
               ToolTip = 'Specifies Vehicle No.';
                ApplicationArea = All;
            }
        }
    }
}
