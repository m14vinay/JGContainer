tableextension 50217 "Warehouse Request Ext" extends "Warehouse Request"
{
    fields
    {
         field(50200; "Delivery Area"; Code[20])
        {
            Caption = 'Delivery Area';
            DataClassification = CustomerContent;
            TableRelation = "Delivery Area"."Delivery Area Code";
        }
        
    }
}
