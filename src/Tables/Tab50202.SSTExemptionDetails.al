table 50202 "SST Exemption Details"
{
    Caption = 'SST Exemption Details';
    DataClassification = CustomerContent;
    LookupPageId = "SST Exemption Details";
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(2; "SST Exemption Registration No."; Text[25])
        {
            Caption = 'SST Exemption Registration No.';
        }
        field(3; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
        }
        field(4; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }
    }
    keys
    {
        key(PK; "Customer No.","SST Exemption Registration No.","Effective Date")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown;"Customer No.","SST Exemption Registration No.","Effective Date"){}
    }
}
