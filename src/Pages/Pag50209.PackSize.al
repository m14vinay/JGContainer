page 50209 "Pack Size"
{
    ApplicationArea = All;
    Caption = 'Pack Size';
    PageType = List;
    SourceTable = "Pack Size";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Qty Per Pack"; Rec."Qty Per Pack")
                {
                    ToolTip = 'Specifies the value of the Qty Per Pack field.', Comment = '%';
                    BlankZero = true;
                }
            }
        }
    }
}
