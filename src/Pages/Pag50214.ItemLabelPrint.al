page 50214 "Item Label Print"
{
    ApplicationArea = All;
    Caption = 'Item Label Print';
    PageType = List;
    SourceTable = "Item Label Print";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.', Comment = '%';
                }
                field(UOM; Rec.UOM)
                {
                    ToolTip = 'Specifies the value of the UOM field.', Comment = '%';
                }
                field("Batch No"; Rec."Batch No")
                {
                    ToolTip = 'Specifies the value of the Batch No field.', Comment = '%';
                }
                 field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            Group(Action01)
            {
                action(ItemLabel)
                {
                    ApplicationArea = All;
                    Caption = 'Print Item Label';
                    Image = Print;
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = Process;
                    ToolTip = 'Print the label';
                    trigger OnAction()
                    var
                        ItemLabel: Record "Item Label Print";
                    begin
                        CurrPage.SetSelectionFilter(ItemLabel);
                        //SetRecord.SetWHseRecptHdr(Rec);
                        Report.RunModal(Report::"Item Label Print", True, false, ItemLabel);
                    end;
                }
                 action(RMItemLabel)
                {
                    ApplicationArea = All;
                    Caption = 'RM Print Item Label';
                    Image = Print;
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = Process;
                    ToolTip = 'Print the label';
                    trigger OnAction()
                    var
                        ItemLabel: Record "Item Label Print";
                    begin
                        CurrPage.SetSelectionFilter(ItemLabel);
                        //SetRecord.SetWHseRecptHdr(Rec);
                        Report.RunModal(Report::"RM Item Label Print", True, false, ItemLabel);
                    end;
                }
            }
        }
    }
}
