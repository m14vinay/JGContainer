pageextension 50348 "Fixed Asset Card Ext" extends "Fixed Asset Card"
{
    actions
    {
        addlast(Processing)
        {
            action(PrintFixedAssetLabel)
            {
                ApplicationArea = All;
                Caption = 'Print Fixed Asset Label';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    FixedAssetLabelReport: Report "Fixed Asset Label";
                    Fixedasset : Record "Fixed Asset";
                begin
                    Currpage.SetSelectionFilter(Fixedasset);
                    FixedAssetLabelReport.SetTableView(Fixedasset);
                    FixedAssetLabelReport.RunModal();
                end;
            }
        }
    }
}
