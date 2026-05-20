page 50201 "Warehouse Entries API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'commit';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'warehouseEntries';
    DelayedInsert = true;
    EntityName = 'warehouseEntry';
    EntitySetName = 'warehouseEntries';
    SourceTable = "Warehouse Entry";
    Editable = false;
    PageType = API;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(registeringDate; Rec."Registering Date")
                {
                    Caption = 'Registering Date';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(qtyBase; Rec."Qty. (Base)")
                {
                    Caption = 'Qty. (Base)';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                    Caption = 'Source Subtype';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(sourceLineNo; Rec."Source Line No.")
                {
                    Caption = 'Source Line No.';
                }
                field(sourceSublineNo; Rec."Source Subline No.")
                {
                    Caption = 'Source Subline No.';
                }
                field(sourceDocument; Rec."Source Document")
                {
                    Caption = 'Source Document';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(cubage; Rec.Cubage)
                {
                    Caption = 'Cubage';
                }
                field(weight; Rec.Weight)
                {
                    Caption = 'Weight';
                }
                field(journalTemplateName; Rec."Journal Template Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(whseDocumentNo; Rec."Whse. Document No.")
                {
                    Caption = 'Whse. Document No.';
                }
                field(whseDocumentType; Rec."Whse. Document Type")
                {
                    Caption = 'Whse. Document Type';
                }
                field(whseDocumentLineNo; Rec."Whse. Document Line No.")
                {
                    Caption = 'Whse. Document Line No.';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(referenceDocument; Rec."Reference Document")
                {
                    Caption = 'Reference Document';
                }
                field(referenceNo; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(serialNo; Rec."Serial No.")
                {
                    Caption = 'Serial No.';
                }
                field(lotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                }
                field(packageNo; Rec."Package No.")
                {
                    Caption = 'Package No.';
                }
            }
        }
    }
}
