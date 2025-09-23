pageextension 50201 "Comp Info Ext" extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("Company Logo 1"; Rec."Company Logo 1")
            {
                Caption = 'Company Logo 1';
                ToolTip = 'Specifies the company''s Logo 1';
                ApplicationArea = All;
            }
             field("Company Logo 2"; Rec."Company Logo 2")
            {
                Caption = 'Company Logo 2';
                ToolTip = 'Specifies the company''s Logo 2';
                ApplicationArea = All;
            }
             field("Company Logo 3"; Rec."Company Logo 3")
            {
                Caption = 'Company Logo 3';
                ToolTip = 'Specifies the company''s Logo 3';
                ApplicationArea = All;
            }
        }
        addafter("Bank Account No.")
        {
            field("Alternative Bank 1"; Rec."Alternative Bank 1")
            {
                Caption = 'Alternative Bank 1';
                ToolTip = 'Specifies the Alternative Bank 1';
                ApplicationArea = All;
            }
             field("Alternative Bank 2"; Rec."Alternative Bank 2")
            {
                Caption = 'Alternative Bank 2';
                ToolTip = 'Specifies the Alternative Bank 2';
                ApplicationArea = All;
            }
        }
        addafter("Home Page")
        {
            field("Marketing Phone No"; Rec."Marketing Phone No")
            {
                Caption = 'Marketing Phone No';
                ToolTip = 'Specifies the Marketing Phone No';
                ApplicationArea = All;
            }
             field("Marketing Email"; Rec."Marketing Email")
            {
                Caption = 'Marketing Email';
                ToolTip = 'Specifies the Marketing Email';
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field("Print Name"; Rec."Print Name")
            {
                Caption = 'Print Name';
                ToolTip = 'Specifies the Print Name';
                ApplicationArea = All;
            }
        }
    }
}
