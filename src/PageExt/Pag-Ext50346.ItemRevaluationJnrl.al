pageextension 50346 "Item Revaluation Jnrl" extends "Revaluation Journal"
{
    PromotedActionCategoriesML = ENU = 'Manage,Home,Line,Test,Approve,Request Approve,Request Approve,Request Approve,Approve';
    layout
    {
        addafter(CurrentJnlBatchName)
        {
            field(ItemJnlBatchApprovalStatus; ItemJnlBatchApprovalStatus)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Status';
                Editable = false;
                Visible = EnabledItemJnlBatchWorkflowsExist;
                ToolTip = 'Specifies the approval status for item journal batch.';
            }
        }
        addafter(Amount)
        {
            field(JnlLineApprovalStatus; Rec."Approval Status")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Status';
                Editable = false;
                Visible = EnabledJnlLineWorkflowsExist;
                ToolTip = 'Specifies the approval status for general journal line.';
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Send Journal Batch';
                        Enabled = not OpenApprovalEntriesOnJnlBatchExist and CanRequestFlowApprovalForBatch and EnabledItemJnlBatchWorkflowsExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send all journal lines for approval, also those that you may not see because of filters.';
                        Promoted = true;
                        Visible = True;
                        PromotedIsBig = true;
                        PromotedCategory = Category8;
                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
                            SetControlAppearanceFromBatch();
                        end;
                    }
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Send Selected Journal Lines';
                        // Enabled = not OpenApprovalEntriesOnBatchOrCurrJnlLineExist and CanRequestFlowApprovalForBatchAndCurrentLine and EnabledGenJnlLineWorkflowsExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';
                        Promoted = true;
                        PromotedCategory = Category8;
                        PromotedIsBig = true;
                        Visible = True;
                        trigger OnAction()
                        var
                            [SecurityFiltering(SecurityFilter::Filtered)]
                            ItemJournalLine: Record "Item Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            CustomWorkFlowMgt: Codeunit "Sales Custom WorkFlow Mgt";
                            RecRef: RecordRef;
                        begin
                            CurrPage.SetSelectionFilter(ItemJournalLine);
                            if ItemJournalLine.FindSet() then
                                repeat
                                    RecRef.GetTable(ItemJournalLine);
                                    If CustomWorkFlowMgt.CheckJournalApprovalPossible(RecRef) then
                                        CustomWorkFlowMgt.OnSendItemRevaluationForApproval(RecRef);
                                until ItemJournalLine.Next() = 0;

                            SetControlAppearanceFromBatch();
                        end;
                    }
                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Journal Batch';
                        Enabled = CanCancelApprovalForJnlBatch or CanCancelFlowApprovalForBatch;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';
                        Promoted = true;
                        Visible = True;
                        PromotedIsBig = true;
                        PromotedCategory = Category8;
                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
                            SetControlAppearanceFromBatch();
                        end;
                    }
                    action(CancelApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Selected Journal Lines';
                        //Enabled = CanCancelApprovalForJnlLine or CanCancelFlowApprovalForLine;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending selected journal lines for approval.';
                        Promoted = true;
                        Visible = True;
                        PromotedIsBig = true;
                        PromotedCategory = Category8;
                        trigger OnAction()
                        var
                            [SecurityFiltering(SecurityFilter::Filtered)]
                            ItemJournalLineCancel: Record "Item Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            CustomWorkFlowMgt: Codeunit "Sales Custom WorkFlow Mgt";
                            RecRef: RecordRef;
                        begin
                            CurrPage.SetSelectionFilter(ItemJournalLineCancel);
                            if ItemJournalLineCancel.FindSet() then
                                repeat
                                    RecRef.GetTable(ItemJournalLineCancel);
                                    CustomWorkFlowMgt.OnCancelItemRevaluationForApproval(RecRef);
                                until ItemJournalLineCancel.Next() = 0;

                            SetControlAppearanceFromBatch();
                        end;
                    }
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                    Promoted = true;
                    Visible = True;
                    PromotedIsBig = true;
                    PromotedCategory = Category6;
                    trigger OnAction()
                    var
                        JournalLine: Record "Item Journal Line";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GetCurrentlySelectedLines(JournalLine);
                        
                            ShowJournalApprovalEntries(JournalLine);
                    end;
                }
            }

            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        ItemJournalBatch: Record "Item Journal Batch";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }

    var
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        RecordRestMgt: Codeunit "Record Restriction Mgt.";
        ApprovalEntriesExistSentByCurrentUser: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        EnabledItemJnlBatchWorkflowsExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        ItemJnlBatchApprovalStatus: Text[20];
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        ImposedRestrictionLbl: Label 'Imposed restriction';
        EnabledJnlLineWorkflowsExist: Boolean;
        JnlLineApprovalStatus: Text[20];

    trigger OnAfterGetCurrRecord()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ItemJournalBatch: Record "Item Journal Batch";
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        SetControlAppearanceFromBatch();
        //SetControlAppearance();
        if ItemJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), CurrentJnlBatchName) then begin
            SetApprovalStateForBatch(ItemJournalBatch, Rec, OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesOnJnlBatchExist, CanCancelApprovalForJnlBatch, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForBatch, ApprovalEntriesExistSentByCurrentUser, EnabledItemJnlBatchWorkflowsExist, EnabledJnlLineWorkflowsExist);
            // ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.Page.SetFilterOnWorkflowRecord(ItemJournalBatch.RecordId());
        end;

        ApprovalMgmt.GetItemJnlBatchApprovalStatus(Rec, ItemJnlBatchApprovalStatus, EnabledItemJnlBatchWorkflowsExist);
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId());
    end;


    trigger OnModifyRecord(): Boolean
    begin

        CleanItemJournalApprovalStatus(Rec, ItemJnlBatchApprovalStatus);
    end;


    trigger OnOpenPage()
    begin
        SetControlAppearanceFromBatch();
    end;

    local procedure GetJournalTemplateNameFromFilter(): Text[10]
    begin
        if Rec.GetFilter("Journal Template Name") = '' then
            exit;

        exit(Rec.GetRangeMax("Journal Template Name"));
    end;

    local procedure GetCurrentlySelectedLines(var JournalLine: Record "Item Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(JournalLine);
        exit(JournalLine.FindSet());
    end;

    local procedure SetControlAppearanceFromBatch()
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        if not ItemJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), CurrentJnlBatchName) then
            exit;

        //ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RecordId);
        SetApprovalStateForBatch(ItemJournalBatch, Rec, OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesOnJnlBatchExist, CanCancelApprovalForJnlBatch, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForBatch, ApprovalEntriesExistSentByCurrentUser, EnabledItemJnlBatchWorkflowsExist, EnabledJnlLineWorkflowsExist);

    end;



    internal procedure SetApprovalStateForBatch(ItemJournalBatch: Record "Item Journal Batch"; ItemJournalLine: Record "Item Journal Line"; var OpenApprovalEntriesExistForCurrentUser: Boolean; var OpenApprovalEntriesOnJournalBatchExist: Boolean; var CanCancelApprovalForJournalBatch: Boolean; var LocalCanRequestFlowApprovalForBatch: Boolean; var LocalCanCancelFlowApprovalForBatch: Boolean; var LocalApprovalEntriesExistSentByCurrentUser: Boolean; var EnabledItemJournalBatchWorkflowsExist: Boolean; var EnabledJnlLineWorkflowsExist: Boolean)
    var
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CustomWorkFlowMgt: Codeunit "Sales Custom WorkFlow Mgt";
        RecRef: RecordRef;
        ItemJnrline: Record "Item Journal Line";
    begin
        OpenApprovalEntriesExistForCurrentUser := OpenApprovalEntriesExistForCurrentUser or ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(ItemJournalBatch.RecordId());
        OpenApprovalEntriesOnJournalBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(ItemJournalBatch.RecordId());
        CanCancelApprovalForJournalBatch := ApprovalsMgmt.CanCancelApprovalForRecord(ItemJournalBatch.RecordId());
        WorkflowWebhookManagement.GetCanRequestAndCanCancel(ItemJournalBatch.RecordId(), LocalCanRequestFlowApprovalForBatch, LocalCanCancelFlowApprovalForBatch);
        LocalApprovalEntriesExistSentByCurrentUser := ApprovalsMgmt.HasApprovalEntriesSentByCurrentUser(ItemJournalBatch.RecordId());
        EnabledItemJournalBatchWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(Database::"Item Journal Batch", WorkflowEventHandling.RunWorkflowOnSendItemJournalBatchForApprovalCode());
        RecRef.GetTable(ItemJnrline);
        EnabledJnlLineWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::"Item Journal Line", CustomWorkFlowMgt.GetWorkFlowCode('RUNWORKFLOWONSEND%1FORAPPROVAL', RecRef));
    end;

    procedure CleanItemJournalApprovalStatus(ItemJournalLine: Record "Item Journal Line"; var ItemJnlBatchApprovalStatus: Text[20])
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ApprovalEntry: Record "Approval Entry";
    begin
        if ItemJournalBatch.Get(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name") then
            if IsItemJournalBatchApprovalsWorkflowEnabled(ItemJournalBatch) then
                if FindLastApprovalEntryForCurrUser(ApprovalEntry, ItemJournalBatch.RecordId()) and (ApprovalEntry.Status = ApprovalEntry.Status::Approved) then
                    ItemJnlBatchApprovalStatus := CopyStr(ImposedRestrictionLbl, 1, 20)
                else
                    if FindApprovalEntryByRecordId(ApprovalEntry, ItemJournalBatch.RecordId) and (ApprovalEntry.Status = ApprovalEntry.Status::Approved) then
                        ItemJnlBatchApprovalStatus := CopyStr(ImposedRestrictionLbl, 1, 20);
    end;

    procedure IsItemJournalBatchApprovalsWorkflowEnabled(var ItemJournalBatch: Record "Item Journal Batch") Result: Boolean
    var
        IsHandled: Boolean;
    begin

        exit(WorkflowManagement.CanExecuteWorkflow(ItemJournalBatch, WorkflowEventHandling.RunWorkflowOnSendItemJournalBatchForApprovalCode()));
    end;

    procedure FindLastApprovalEntryForCurrUser(var ApprovalEntry: Record "Approval Entry"; RecordID: RecordID): Boolean
    begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetRange("Approver ID", UserId);
        exit(ApprovalEntry.FindLast());
    end;

    procedure FindApprovalEntryByRecordId(var ApprovalEntry: Record "Approval Entry"; RecordID: RecordID): Boolean
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        exit(ApprovalEntry.FindLast());
    end;


    trigger OnDeleteRecord(): Boolean
    var
        RestMgt: Codeunit "Record Restriction Mgt.";
    begin
        RestMgt.CheckRecordHasUsageRestrictions(Rec);
    end;

    procedure ShowJournalApprovalEntries(var JournalLine: Record "Item Journal Line")
    var
        ApprovalEntry: Record "Approval Entry";
        JournalBatch: Record "Item Journal Batch";
    begin
        GetGeneralJournalBatch(JournalBatch, JournalLine);

        ApprovalEntry.SetFilter("Table ID", '%1|%2', DATABASE::"Item Journal Batch", DATABASE::"Item Journal Line");
        ApprovalEntry.SetFilter("Record ID to Approve", '%1|%2', JournalBatch.RecordId, JournalLine.RecordId);
        ApprovalEntry.SetRange("Related to Change", false);
        PAGE.Run(PAGE::"Approval Entries", ApprovalEntry);
    end;

    local procedure GetGeneralJournalBatch(var JournalBatch: Record "Item Journal Batch"; var JournalLine: Record "Item Journal Line")
    begin
        if not JournalBatch.Get(JournalLine."Journal Template Name", JournalLine."Journal Batch Name") then
            JournalBatch.Get(JournalLine.GetFilter("Journal Template Name"), JournalLine.GetFilter("Journal Batch Name"));
    end;
}
