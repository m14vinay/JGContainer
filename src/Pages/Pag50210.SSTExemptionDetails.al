page 50210 "SST Exemption Details"
{
    ApplicationArea = All;
    Caption = 'SST Exemption Details';
    PageType = List;
    SourceTable = "SST Exemption Details";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("SST Exemption Registration No."; Rec."SST Exemption Registration No.")
                {
                    ToolTip = 'Specifies the value of the SST Exemption Registration No. field.', Comment = '%';
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ToolTip = 'Specifies the value of the Effective Date field.', Comment = '%';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.', Comment = '%';
                }
            }
        }
    }
}
