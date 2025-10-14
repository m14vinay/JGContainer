tableextension 50219 "Item Ext" extends Item
{
    fields
    {
        field(50201; "Pallet Tracking Required"; Boolean)
        {
            Caption = 'Pallet Tracking Required';
            DataClassification = CustomerContent;
        }
        field(50202; "Brand"; Text[100])
        {
            Caption = 'Brand';
            DataClassification = CustomerContent;
        }
        field(50203; "Pack Size"; Code[20])
        {
            Caption = 'Pack Size';
            DataClassification = CustomerContent;
            TableRelation = "Pack Size".Code;
        }
        field(50204; "Print Charges in Footer"; Boolean)
        {
            Caption = 'Print Charges in Footer';
            DataClassification = CustomerContent;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'SST Bus. Posting Gr. (Price)';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
        modify("Price Includes VAT")
        {
            Caption = 'Price Includes SST';
        }
    }
}
