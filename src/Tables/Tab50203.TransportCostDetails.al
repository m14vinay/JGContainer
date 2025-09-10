table 50203 "Transport Cost Details"
{
    Caption = 'Transport Cost Details';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
         field(3; "QTY"; Decimal)
        {
            Caption = 'Quantity';
        }
         field(4; "UOM"; Code[20])
        {
            Caption = 'UOM';
        }
         field(5; "Cost"; Decimal)
        {
            Caption = 'Cost';
        }
         field(6; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
         field(7; "Carrier"; Code[20])
        {
            Caption = 'Carrier';
        }
         field(8; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
        }
         field(9; "DO"; Code[20])
        {
            Caption = 'DO';
        }
         field(10; "DO Date"; Date)
        {
            Caption = 'DO Date';
        }
         field(11; "Customer"; Code[20])
        {
            Caption = 'Customer';
        }

    }
    keys
    {
        key(PK; "Line No")
        {
            Clustered = true;
        }
    }
}
