page 50212 "Whse Shipment Services"
{
    ApplicationArea = All;
    Caption = 'Shipment Services';
    PageType = List;
    SourceTable = "Warehouse Shipment Services";
   // Editable = false;
    DeleteAllowed = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.', Comment = '%';
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.', Comment = '%';
                     Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                     Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.', Comment = '%';
                     Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.', Comment = '%';
                     Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                     Editable = false;
                }
                field("Carrier Code"; Rec."Carrier Code")
                {
                    ToolTip = 'Specifies the value of the Carrier Code field.', Comment = '%';
                     Editable = false;
                }
                field("Delivery Area Code"; Rec."Delivery Area Code")
                {
                    ToolTip = 'Specifies the value of the Delivery Area Code field.', Comment = '%';
                     Editable = false;
                }
                field("Rate Type"; Rec."Rate Type")
                {
                    ToolTip = 'Specifies the value of the Rate Type field.', Comment = '%';
                     Editable = false;
                }
                field(Rate; Rec.Rate)
                {
                    ToolTip = 'Specifies the value of the Rate field.', Comment = '%';
                }
            }
        }
    }
}
