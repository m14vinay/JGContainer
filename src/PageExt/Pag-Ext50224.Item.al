#pragma warning disable AA0215
pageextension 50224 Item extends "Item Card"
#pragma warning restore AA0215
{
    layout
    {
        addafter("Purchasing Code")
        {
            field("Pallet Tracking Required"; Rec."Pallet Tracking Required")
            {
                ToolTip = 'Specifies whether the pallet tracking required for the item';
                ApplicationArea = All;
            }
            field(Brand; Rec.Brand)
            {
                ToolTip = 'Specifies the Brand of the Item';
                ApplicationArea = All;
            }
            field("Print Charges in Footer"; Rec."Print Charges in Footer")
            {
                ToolTip = 'Specifies the Print Charges in Footer for Reports';
                ApplicationArea = All;
            }
            field("Allow Negative Amount"; Rec."Allow Negative Amount")
            {
                ToolTip = 'Specifies the Allow Only Negative Amount';
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Pack Size"; Rec."Pack Size")
            {
                ToolTip = 'Specifies the Pack Size of the Item';
                ApplicationArea = All;
            }
            field("PM Pack Qty"; Rec."PM Pack Qty")
            {
                ToolTip = 'Specifies the PM Pack Qty of the Item';
                ApplicationArea = All;
            }
        }
        modify(Blocked)
        {
            Editable = false;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'SST Bus. Posting Gr. (Price)';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'SST Prod. Posting Group';
        }
        modify("Price Includes VAT")
        {
            Caption = 'Price Includes SST';
        }
        modify(PreventNegInventoryDefaultNo)
        {
            Visible = false; 
            Editable = false;
        }
         modify(PreventNegInventoryDefaultYes)
        {
            Visible = false;
            Editable = false;
        }
    }
    actions
    {
        addafter("Substituti&ons")
        {
            action(BlockItem)
            {
                ApplicationArea = All;
                Caption = 'Block Item';
                Image = Cancel;
                ToolTip = 'Block the item';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Rec.Blocked := True;
                end;
            }
        }
        modify(Approve)
        {
            trigger OnAfterAction()
             var
                DimensionSetEntryAppro: Record "Default Dimension";
                JobExistAppro: Boolean;
            begin
                If (Rec."Item Category Code" = 'FG') Or (Rec."Item Category Code" = 'PB') or (Rec."Item Category Code" = 'WIP') then begin
                    JobExistAppro := false;
                    Rec.TestField("Base Unit of Measure");
                    Rec.TestField("Gen. Prod. Posting Group");
                    If Rec."Item Category Code" = 'FG' then
                        Rec.TestField("Pack Size");
                    Rec.TestField("Item Tracking Code");
                    Rec.TestField("Production BOM No.");
                    Rec.TestField("Routing No.");
                    
                    If not (Rec."Costing Method" = Rec."Costing Method"::Standard) then
                        Error('Costing Method should be Standard');
                    
                    DimensionSetEntryAppro.Reset();
                    DimensionSetEntryAppro.SetRange("Table ID", 27);
                    DimensionSetEntryAppro.SetRange("No.", Rec."No.");
                    If DimensionSetEntryAppro.FindSet() then
                        repeat
                            If DimensionSetEntryAppro."Dimension Code" = 'JOB' then
                                JobExistAppro := True;
                        until DimensionSetEntryAppro.Next() = 0;
                    If not (JobExistAppro) then
                        Error('Please update dimension Job in the Item Card');
                end;
                Rec.Blocked := false;
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                DimensionSetEntry: Record "Default Dimension";
                JobExist: Boolean;
            begin
                If (Rec."Item Category Code" = 'FG') Or (Rec."Item Category Code" = 'PB') or (Rec."Item Category Code" = 'WIP') then begin
                    JobExist := false;
                    Rec.TestField("Base Unit of Measure");
                    Rec.TestField("Gen. Prod. Posting Group");
                    If Rec."Item Category Code" = 'FG' then
                        Rec.TestField("Pack Size");
                    Rec.TestField("Item Tracking Code");
                    Rec.TestField("Production BOM No.");
                    Rec.TestField("Routing No.");
                   
                    If not (Rec."Costing Method" = Rec."Costing Method"::Standard) then
                        Error('Costing Method should be Standard');
                   
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Table ID", 27);
                    DimensionSetEntry.SetRange("No.", Rec."No.");
                    If DimensionSetEntry.FindSet() then
                        repeat
                            If DimensionSetEntry."Dimension Code" = 'JOB' then
                                JobExist := True;
                        until DimensionSetEntry.Next() = 0;
                    If not (JobExist) then
                        Error('Please update dimension Job in the Item Card');
                end;
            end;
        }
    }
}
