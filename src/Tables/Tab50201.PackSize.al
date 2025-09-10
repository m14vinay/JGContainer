table 50201 "Pack Size"
{
    Caption = 'Pack Size';
    DataClassification = CustomerContent;
    LookupPageId = "Pack Size";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Qty Per Pack"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty Per Pack';
            DecimalPlaces = 0:2;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups{
        fieldgroup(DropDown; "Code", Description,"Qty Per Pack")
        {
        }
    }
}
