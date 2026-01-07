pageextension 50341 "County Ext" extends Counties
{
    layout{
        addafter(Description)
        {
            field("Hide in Documents"; Rec."Hide in Documents")
            {
                ToolTip = 'Specifies the Hide in Documents';
                ApplicationArea = All;
            }
        }
    }
}
