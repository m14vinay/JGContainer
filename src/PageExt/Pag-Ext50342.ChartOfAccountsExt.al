pageextension 50342 "Chart Of Accounts Ext" extends "Chart of Accounts"
{
    
    trigger OnModifyRecord(): Boolean
    var
    UserSetup : Record "User Setup";
    begin
       UserSetup.Get(UserId);
       If not (UserSetup."Allowed to Change COA") then
          Error('Not allowed to modify');
    end;
}
