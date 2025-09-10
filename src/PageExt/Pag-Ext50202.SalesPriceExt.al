pageextension 50202 "Sales Price Ext" extends "Sales Prices"
{
    PromotedActionCategoriesML = ENU = 'New,Home,Process,Report,Approve,Request Approve';
    layout
    {
        addafter("Unit Price")
        {
             field("Price Per Piece"; Rec."Price Per Piece")
            {
                ToolTip = 'Specifies the Price Per Piece';
                ApplicationArea = All;
            }
            field("Approval Status"; Rec."Approval Status")
            {
                ToolTip = 'Specifies the approval status';
                ApplicationArea = All;
            }
           
        }
    }
    actions
    {
        addafter(CopyPrices)
        {
            group(Action12)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec."Approval Status" <> Rec."Approval Status"::Open;
                    Image = ReOpen;
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = Category6;
                    ToolTip = 'Reopen to change it after it has been approved.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        PerformManualReopen(Rec);
                    end;
                }
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = True;
                    PromotedCategory = Category6;
                    ToolTip = 'Send the approval request.';
                    trigger OnAction()
                    var
                        CustomWorkFlowMgt: Codeunit "Sales Custom WorkFlow Mgt";
                        RecRef: RecordRef;
                    begin

                        RecRef.GetTable(Rec);
                        If CustomWorkFlowMgt.CheckSalesPriceApprovalPossible(RecRef) then
                            CustomWorkFlowMgt.OnSendSalesPriceForApproval(RecRef);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = True;
                    PromotedCategory = Category6;
                    trigger OnAction()
                    var
                        CustomWorkFlowMgt: Codeunit "Sales Custom WorkFlow Mgt";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        CustomWorkFlowMgt.OnCancelSalesPriceForApproval(RecRef);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Enabled = Rec."Approval Status" <> Rec."Approval Status"::Open;
                    Image = Approvals;
                    Promoted = True;
                    PromotedCategory = Category6;
                    ToolTip = 'View approval requests';
                    trigger OnAction()
                    begin
                        ApprovalMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }

            group(Approval)
            {
                Caption = 'Approval';

                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = True;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = True;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = True;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = True;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }

        }
    }
    procedure PerformManualReopen(var SalesPrice: Record "Sales Price")
    begin
        if SalesPrice."Approval Status" = SalesPrice."Approval Status"::"Pending Approval" then
            Error(Text003);
        if SalesPrice."Approval Status" = SalesPrice."Approval Status"::Open then
            exit;
        SalesPrice."Approval Status" := SalesPrice."Approval Status"::Open;
        SalesPrice.Modify(true);
    end;

    var
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        Text003: Label 'The approval process must be cancelled or completed to reopen this document.';
    trigger OnAfterGetCurrRecord()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId());
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId());
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId());
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId(), CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
    trigger OnOpenPage()
    var
        CurrCodeFilter: Text;
    begin
        CurrCodeFilter := Rec.GetFilter("Currency Code");

        // Handle BC's '''' (blank filter) case
        if (CurrCodeFilter = '''''') or (CurrCodeFilter = '') then
            Rec.SetRange("Currency Code"); // Remove blank filter
    end;
    
}
