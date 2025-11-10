table 50204 "Item Label Print"
{
    Caption = 'Item Label Print';
    DataClassification = CustomerContent;
    
    fields

    {
        field(7; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            trigger OnValidate()
            var
            ItemRec : Record Item;
            begin
               If ItemRec.Get("Item No.") then begin
                  Description := ItemRec.Description;
                  UOM := ItemRec."Base Unit of Measure";
               end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(3; Location; Code[10])
        {
            Caption = 'Location';
            TableRelation = Location.Code;
        }
        field(4; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code;
        }
        field(5; UOM; Code[20])
        {
            Caption = 'UOM';
        }
        field(6; "Batch No"; Code[20])
        {
            Caption = 'Batch No';
        }
        field(8; "Quantity"; Integer)
        {
            Caption = 'Quantity';
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
