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
            Caption = 'Incoterms'; //Done
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
                    if c in ['A' .. 'Z', 'a' .. 'z','*','-','(',')'] then
                        FieldError("Phone No. 2", 'Phone number cannot contain letters or special characters.');
                end;
            end;
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
        modify("VAT Registration No.")
        {
            Caption = 'SST Registration No.';
        }
        modify("Validate EU Vat Reg. No.")
        {
            Caption = 'Validate EU SST Reg. No.';
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
        }
        modify("Phone No.")
        {
             trigger OnBeforeValidate()
            var
                c: Char;
                i: Integer;
            begin
                for i := 1 to StrLen("Phone No.") do begin
                    c := "Phone No."[i];
                    if c in ['A' .. 'Z', 'a' .. 'z','*','-','(',')'] then
                        FieldError("Phone No.", 'Phone number cannot contain letters or special characters.');
                end;
            end;
        }
        modify("Mobile Phone No.")
        {
             trigger OnBeforeValidate()
            var
                c: Char;
                i: Integer;
            begin
                for i := 1 to StrLen("Mobile Phone No.") do begin
                    c := "Mobile Phone No."[i];
                    if c in ['A' .. 'Z', 'a' .. 'z','*','-','(',')'] then
                        FieldError("Mobile Phone No.", 'Phone number cannot contain letters or special characters.');
                end;
            end;
        }
    }

}
