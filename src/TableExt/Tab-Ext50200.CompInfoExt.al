tableextension 50200 "Comp Info Ext" extends "Company Information"
{
    fields
    {
        field(50201; "Business Activity"; Text[50])
        {
            Caption = 'Business Activity';
            DataClassification = CustomerContent;
        }
        field(50202; "Company Logo 1"; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50203; "Company Logo 2"; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50204; "Company Logo 3"; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
         field(50205; "Marketing Phone No"; Text[30])
        {
            Caption = 'Marketing Phone No';
        }
         field(50206; "Marketing Email"; Text[80])
        {
            Caption = 'Marketing Email';
        }
         field(50207; "Alternative Bank 1"; Code[20])
        {
            Caption = 'Alternative Bank 1';
            TableRelation = "Bank Account"."No.";
        }
         field(50208; "Alternative Bank 2"; Code[20])
        {
            Caption = 'Alternative Bank 2';
            TableRelation = "Bank Account"."No.";
        }
         field(50209; "Print Name"; Text[100])
        {
            Caption = 'Print Name';
        }
    }
}
