tableextension 50227 "Document Attachment Ext" extends "Document Attachment"
{
    fields
    {
        field(50200; "Sales Type"; Enum "Sales Price Type")
        {
            Caption = 'Sales Type';
            DataClassification = ToBeClassified;
        }
        field(50201; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
            DataClassification = ToBeClassified;
        }
        field(50202; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(50203; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(50204; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
        }
        field(50205; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
        }
        field(50206; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(50207; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(50208; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key3; "Record ID")
        {
        }
    }
}
