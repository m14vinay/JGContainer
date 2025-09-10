tableextension 50201 "Sales Price Ext" extends "Sales Price"
{
    fields
    {
        field(50201; "Approval Status"; Enum "Sales Document Status")
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50202; "Price Per Piece"; Decimal)
        {
            Caption = 'Price Per Piece';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            Item : Record Item;
            PackSize : Record "Pack Size";
            begin
                If Item.Get("Item No.") then 
                  If PackSize.Get(Item."Pack Size") then 
                     "Unit Price" := PackSize."Qty Per Pack" * "Price Per Piece";
            end;
        }
        modify("Sales Code")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Sales Type")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Currency Code")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Item No.")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Unit of Measure Code")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Minimum Quantity")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Cost-plus %")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Discount Amount")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Unit Price")
        {
            
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Starting Date")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }
         modify("Ending Date")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Approval Status",Rec."Approval Status"::Open);
            end;
        }

    }
}
