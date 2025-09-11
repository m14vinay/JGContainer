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
        field(50203; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            OptimizeForTextSearch = true;
            ExtendedDatatype = PhoneNo;
            ToolTip = 'Specifies the customer''s telephone number 2.';
            trigger OnValidate()
            var
                c: Char;
                i: Integer;
            begin
                for i := 1 to StrLen("Phone No. 2") do begin
                    c := "Phone No. 2"[i];
                    if c in ['A' .. 'Z', 'a' .. 'z'] then
                        FieldError("Phone No. 2", 'Phone number cannot contain letters.');
                end;
            end;
        }
    }

}
