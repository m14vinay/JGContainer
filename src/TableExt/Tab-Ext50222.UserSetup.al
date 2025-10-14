tableextension 50222 "User Setup" extends "User Setup"
{
    fields
    {
        field(50200; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

        }
        modify("Allow VAT Date From")
        {
            Caption = 'Allow SST Date From';
        }
        modify("Allow VAT Date To")
        {
            Caption = 'Allow SST Date To';
        }
    }
}
