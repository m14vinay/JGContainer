pageextension 50343 "GL Account Card Ext" extends "G/L Account Card"
{
    trigger OnNewRecord(BelowxRec: Boolean)
    var
    UserSetup : Record "User Setup";
    begin
       UserSetup.Get(UserId);
       If not (UserSetup."Allowed to Change COA") then
          Error('Not allowed to create');
    end;
     trigger OnModifyRecord(): Boolean
    var
    UserSetup : Record "User Setup";
    begin
       UserSetup.Get(UserId);
       If not (UserSetup."Allowed to Change COA") then
          Error('Not allowed to modify');
    end;
}
