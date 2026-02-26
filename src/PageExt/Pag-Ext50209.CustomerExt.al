pageextension 50209 "Customer Ext" extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Agent/Distributor Name"; Rec."Agent/Distributor Name")
            {
                ToolTip = 'Specifies agent/distributor name';
                ApplicationArea = All;
            }
            field("Commercial Invoice Needed"; Rec."Commercial Invoice Needed")
            {
                ToolTip = 'Specifies Commercial Invoice Needed';
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Place of Export"; Rec."Place of Export")
            {
                ToolTip = 'Specifies Place of Export';
                ApplicationArea = All;
            }
        }
        modify(Blocked)
        {
            Editable = false;
        }
        addafter("Phone No.")
        {
            field("Phone No. 2"; Rec."Phone No. 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer''s telephone number 2.';
            }
        }
        modify("E-Mail")
        {
            ShowMandatory = true;
        }
        modify("Phone No.")
        {
            ShowMandatory = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'SST Bus. Posting Group';
        }
        modify("VAT Registration No.")
        {
            Caption = 'SST Registration No.';
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including SST';
            Visible = false;
        }
        modify("ADY E-INV Classification Code")
        {
            ShowMandatory = True;
        }
        modify("ADY E-INV TIN No.")
        {
            ShowMandatory = True;
        }
        modify("ADY e-Inv TIN Status")
        {
            ShowMandatory = True;
        }
        modify("ADY E-INV SST Reg No.")
        {
            ShowMandatory = True;
        }
        modify("ADY E-INV ID Type")
        {
            ShowMandatory = True;
        }
          modify("ADY E-INV ID No.")
        {
            ShowMandatory = True;
        }

    }
    actions
    {
        addlast("&Customer")
        {
            action(BlockCustomer)
            {
                ApplicationArea = All;
                Caption = 'Block Customer';
                Image = Cancel;
                ToolTip = 'Block the Customer';
                Promoted = true;
                PromotedCategory = Category9;
                trigger OnAction()
                var
                    ExtManagement: Codeunit "Extension Management";
                    NAVInstalledAPP: Record "NAV App Installed App";
                    PackageID: Boolean;
                begin
                    Rec.Blocked := Rec.Blocked::All;
                    //ExtManagement.UninstallExtension();
                    /*NAVInstalledAPP.Reset();
                    NAVInstalledAPP.SetRange("App ID",'fd09b53c-ff32-4d9c-91ce-6a82a87b8c9c');
                    If NAVInstalledAPP.FindFirst() then
                     Message('%1',NAVInstalledAPP."Package ID");

                    PackageID := ExtManagement.UnpublishExtension('02CF4BF5-94D4-48BF-94A6-B6259B46B09C');
                    Message('%1',PackageID);*/
                end;
            }
            action(SSTExemptionList)
            {
                ApplicationArea = All;
                Caption = 'SST Exemption Details';
                Image = VATExemption;
                ToolTip = 'SST Exemption Details';
                Promoted = true;
                PromotedCategory = Category9;
                RunObject = page "SST Exemption Details";
                RunPageLink = "Customer No." = field("No.");
            }
        }
        modify(Approve)
        {
            trigger OnAfterAction()
            begin
                Rec.TestField("ADY E-INV State Code");
                Rec.Blocked := Rec.Blocked::" ";
            end;
        }
    }
}
