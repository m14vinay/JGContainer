tableextension 50213 "Posted Whse Ship Hdr Ext" extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(50201; "Vehicle No."; Text[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
    }
}