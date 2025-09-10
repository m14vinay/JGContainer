tableextension 50206 "Customer Ext" extends Customer
{
    fields
    {
        field(50201; "Agent/Distributor Name"; Text[100])
        {
            Caption = 'Agent/Distributor Name';
            DataClassification = CustomerContent;
        }
        field(50202; "Incoterms"; Code[20])
        {
            Caption = 'Incoterms';
            DataClassification = CustomerContent;
            TableRelation = Incoterms.Code;
        }
    }
    
}
