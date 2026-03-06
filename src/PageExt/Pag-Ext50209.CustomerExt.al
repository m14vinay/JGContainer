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
                ShowMandatory = True;
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
            var
                DimensionSetEntryAppro: Record "Default Dimension";
                JobExistAppro: Boolean;
            begin
                JobExistAppro := False;
                DimensionSetEntryAppro.Reset();
                DimensionSetEntryAppro.SetRange("Table ID", 18);
                DimensionSetEntryAppro.SetRange("No.", Rec."No.");
                If DimensionSetEntryAppro.FindSet() then
                    repeat
                        If DimensionSetEntryAppro."Dimension Code" = 'CUSTOMER SEGMENT' then
                            JobExistAppro := True;
                    until DimensionSetEntryAppro.Next() = 0;
                If not (JobExistAppro) then
                    Error('Please update dimension Customer Segment');
                Rec.TestField("ADY E-INV State Code");
                Rec.Blocked := Rec.Blocked::" ";
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                DimensionSetEntryApproSend: Record "Default Dimension";
                JobExistApproSend: Boolean;
            begin
                JobExistApproSend := False;
                DimensionSetEntryApproSend.Reset();
                DimensionSetEntryApproSend.SetRange("Table ID", 18);
                DimensionSetEntryApproSend.SetRange("No.", Rec."No.");
                If DimensionSetEntryApproSend.FindSet() then
                    repeat
                        If DimensionSetEntryApproSend."Dimension Code" = 'CUSTOMER SEGMENT' then
                            JobExistApproSend := True;
                    until DimensionSetEntryApproSend.Next() = 0;
                If not (JobExistApproSend) then
                    Error('Please update dimension Customer Segment');
                Rec.TestField("ADY E-INV State Code");
            end;
        }
    }
}
