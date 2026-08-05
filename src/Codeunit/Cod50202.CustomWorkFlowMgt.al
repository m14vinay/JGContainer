codeunit 50202 "Sales Custom WorkFlow Mgt"
{
    procedure CheckSalesPriceApprovalPossible(var RecRef: RecordRef): Boolean
    var
        IsHandled: Boolean;
        ShowNothingToApproveError: Boolean;
        SalesPrice: Record "Sales Price";
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkFlowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        RecRef.SetTable(SalesPrice);
        ShowNothingToApproveError := SalesPrice.IsEmpty;

        if ShowNothingToApproveError then
            Error(NothingToApproveErr);
        exit(true);
    end;

    procedure CheckJournalApprovalPossible(var RecRef: RecordRef): Boolean
    var
        IsHandled: Boolean;
        ShowNothingToApproveError: Boolean;
        ItemJournalLine: Record "Item Journal Line";
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkFlowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
            Error(NoWorkflowEnabledErr);
        RecRef.SetTable(ItemJournalLine);
        ShowNothingToApproveError := ItemJournalLine.IsEmpty;

        if ShowNothingToApproveError then
            Error(NothingToApproveErr);
        exit(true);
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendSalesPriceForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelSalesPriceForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendItemRevaluationForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelItemRevaluationForApproval(var RecRef: RecordRef)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddSalesPriceWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        Clear(WorkFlowEventHandling);
        RecRef.Open(Database::"Sales Price");
        WorkFlowEventHandling.AddEventToLibrary(GetWorkFlowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::"Sales Price",
        GetWorkFlowEventDesc(WorkflowSendApprovalEventDesc, RecRef), 0, false);
        WorkFlowEventHandling.AddEventToLibrary(GetWorkFlowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), Database::"Sales Price",
        GetWorkFlowEventDesc(WorkflowCancelApprovalEventDesc, RecRef), 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddItemRevaluationWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        Clear(WorkFlowEventHandling);
        RecRef.Open(Database::"Item Journal Line");
        WorkFlowEventHandling.AddEventToLibrary(GetWorkFlowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), Database::"Item Journal Line",
        GetWorkFlowEventDesc(WorkflowSendApprovalEventDesc, RecRef), 0, false);
        WorkFlowEventHandling.AddEventToLibrary(GetWorkFlowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), Database::"Item Journal Line",
        GetWorkFlowEventDesc(WorkflowCancelApprovalEventDesc, RecRef), 0, false);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Custom WorkFlow Mgt", OnSendSalesPriceForApproval, '', false, false)]
    local procedure RunWorkFlowOnSendPriceCompForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkFlowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Custom WorkFlow Mgt", OnCancelSalesPriceForApproval, '', false, false)]
    local procedure RunWorkFlowOnCancelPriceCompForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkFlowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Custom WorkFlow Mgt", OnSendItemRevaluationForApproval, '', false, false)]
    local procedure RunWorkFlowOnSendItemJnrForApproval(var RecRef: RecordRef)
    var
        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
        NoOfSelected: Integer;
        NoOfSkipped: Integer;
    begin
        WorkflowManagement.HandleEvent(GetWorkFlowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Custom WorkFlow Mgt", OnCancelItemRevaluationForApproval, '', false, false)]
    local procedure RunWorkFlowOnCancelItemJnorlForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkFlowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        SalesPrice: Record "Sales Price";
        ItmJnlrCanc: Record "Item Journal Line";
    begin
        case RecRef.Number of
            Database::"Sales Price":
                begin
                    RecRef.SetTable(SalesPrice);
                    SalesPrice.Validate("Approval Status", SalesPrice."Approval Status"::Open);
                    SalesPrice.Modify(true);
                    Handled := true;
                end;
        end;
        case RecRef.Number of
            Database::"Item Journal Line":
                begin
                    RecRef.SetTable(ItmJnlrCanc);
                    ItmJnlrCanc.Validate("Approval Status", ItmJnlrCanc."Approval Status"::Cancelled);
                    ItmJnlrCanc.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        SalesPricePending: Record "Sales Price";
        ItemJnrlLinePending: Record "Item Journal Line";
    begin
        case RecRef.Number of
            Database::"Sales Price":
                begin
                    RecRef.SetTable(SalesPricePending);
                    SalesPricePending.Validate("Approval Status", SalesPricePending."Approval Status"::"Pending Approval");
                    SalesPricePending.Modify(true);
                    Variant := SalesPricePending;
                    IsHandled := true;
                end;
        end;
        case RecRef.Number of
            Database::"Item Journal Line":
                begin
                    RecRef.SetTable(ItemJnrlLinePending);
                    ItemJnrlLinePending.Validate("Approval Status", ItemJnrlLinePending."Approval Status"::"Pending Approval");
                    ItemJnrlLinePending.Modify(true);
                    Variant := ItemJnrlLinePending;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkFlowStepInstance: Record "Workflow Step Instance")
    var
        SalesPricePopulate: Record "Sales Price";
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesType: Text;
        SalesPriceRecordID: RecordId;
        DateText: Text;
        SalesTypeNew: Text;
        ItemJnrl: Record "Item Journal Line";
    begin
        Clear(SalesType);
        case RecRef.Number of
            Database::"Sales Price":
                begin
                    RecRef.SetTable(SalesPricePopulate);
                    ApprovalEntryArgument."Document No." := SalesPricePopulate."Item No.";
                    ApprovalEntryArgument.Amount := SalesPricePopulate."Unit Price";
                    ApprovalEntryArgument."Currency Code" := SalesPricePopulate."Currency Code";
                end;
        end;
        case RecRef.Number of
            Database::"Item Journal Line":
                begin
                    RecRef.SetTable(ItemJnrl);
                    ApprovalEntryArgument."Document No." := ItemJnrl."Document No.";
                    ApprovalEntryArgument.Amount := ItemJnrl.Amount;
                    //  ApprovalEntryArgument."Currency Code" := ItemJnrl."Currency Code";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        SalesPriceRej: Record "Sales Price";
        ItenJnrlRej: Record "Item Journal Line";
    begin
        case ApprovalEntry."Table ID" of
            Database::"Sales Price":
                begin
                    if SalesPriceRej.Get(ApprovalEntry."Record ID to Approve") then
                        SalesPriceRej.Validate("Approval Status", SalesPriceRej."Approval Status"::Open);
                    SalesPriceRej.Modify(True);
                end;
        end;
        case ApprovalEntry."Table ID" of
            Database::"Item Journal Line":
                begin
                    if ItenJnrlRej.Get(ApprovalEntry."Record ID to Approve") then
                        ItenJnrlRej.Validate("Approval Status", ItenJnrlRej."Approval Status"::Rejected);
                    ItenJnrlRej.Modify(True);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; Var Handled: Boolean)
    var
        SalesPriceRelease: Record "Sales Price";
        ItmJnrlAprv: Record "Item Journal Line";
    begin
        case RecRef.Number of
            DataBase::"Sales Price":
                begin
                    RecRef.SetTable(SalesPriceRelease);
                    SalesPriceRelease.Validate("Approval Status", SalesPriceRelease."Approval Status"::Released);
                    SalesPriceRelease.Modify(True);
                    Handled := true;
                end;
        end;

        case RecRef.Number of
            DataBase::"Item Journal Line":
                begin
                    RecRef.SetTable(ItmJnrlAprv);
                    ItmJnrlAprv.Validate("Approval Status", ItmJnrlAprv."Approval Status"::Approved);
                    ItmJnrlAprv.Modify(True);
                    Handled := true;
                end;
        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnConditionalCardPageIDNotFound', '', true, true)]
    local procedure OnConditionalCardPageIDNotFound(RecordRef: RecordRef; var CardPageID: Integer)
    begin
        if RecordRef.Number = DATABASE::"Sales Price" then
            CardPageID := PAGE::"Sales Prices cust";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeApproveApprovalRequests, '', false, false)]
    local procedure UpdateSalesOrderSequenceApproval(var ApprovalEntry: Record "Approval Entry")
    var
        SalesHeader: Record "Sales Header";
        SequenceNo: Integer;
        RecordID: RecordId;
    begin
        If ApprovalEntry.FindFirst() then begin
            SequenceNo := ApprovalEntry."Sequence No.";
            RecordID := ApprovalEntry."Record ID to Approve";
        end;

        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Sequence No.", SequenceNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        //end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCheckUserAsApprovalAdministrator, '', false, false)]
    local procedure SkipUserIDCheck(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        SequenceNo: Integer;
        RecordIDtoApprove: RecordId;
    begin
        SequenceNo := ApprovalEntry."Sequence No.";
        RecordIDtoApprove := ApprovalEntry."Record ID to Approve";
        //If SalesHeader.Get(ApprovalEntry."Record ID to Approve") then begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Sequence No.", SequenceNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordIDtoApprove);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        If ApprovalEntry.Count > 0 then
            IsHandled := True;
        //end;
    end;


    var
        WorkflowManagement: Codeunit "Workflow Management";
        RUNWORKFLOWONSENDFORAPPROVALCODE: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';

        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        NothingToApproveErr: Label 'There is nothing to approve.';
        WorkflowSendApprovalEventDesc: Label 'Approval of a %1 is requested.';
        WorkflowCancelApprovalEventDesc: Label 'An approval request for a %1 is cancelled.';

    procedure GetWorkFlowCode(WorkFlowCode: Code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkFlowCode, RecRef.Name), '=', ' '));
    end;

    procedure GetWorkFlowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name))
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    procedure DeleteApprovalEntriesAfterDeleteJournalLine(var Rec: Record "Item Journal Line"; RunTrigger: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
    begin
        if not Rec.IsTemporary then begin
            ApprovalMgt.DeleteApprovalEntries(Rec.RecordId);
            ApprovalMgt.DeleteApprovalCommentLines(Rec.RecordId);
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLines', '', false, false)]
    local procedure OnAfterInsertLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        SalesInvLine: Record "Sales Line";
    begin

        If SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            SalesInvLine.Reset();
            SalesInvLine.SetRange("Document Type", SalesInvLine."Document Type"::Invoice);
            SalesInvLine.SetRange("Document No.", SalesHeader."No.");
            SalesInvLine.SetFilter("Shipment No.", '<>%1', '');
            If SalesInvLine.FindFirst() then begin
                SalesHeader."Posting Description" := CopyStr(SalesInvLine.Description + ' ' + SalesInvLine."Shipment No.", 1, 100);
                SalesHeader.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure UpdatePostingDesc(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ChargeItem: Record "Item Charge";
        ItemRec: Record Item;
        GLAccount: Record "G/L Account";
        PostingDesc: Text[100];
        Count: Integer;
    begin
        If Rec."Document Type" = Rec."Document Type"::Invoice then begin
            Clear(PostingDesc);
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Invoice);
            SalesLine.SetRange("Document No.", Rec."Document No.");
            //PurchLine.SetFilter(Description, '<>%1', '');
            SalesLine.SetFilter(Type, '<>%1', SalesLine.Type::" ");
            Count := SalesLine.Count;
            If SalesLine.FindFirst() then begin
                If SalesLine."Shipment No." = '' then
                    If SalesHeader.Get(SalesHeader."Document Type"::Invoice, Rec."Document No.") then
                        if Rec."Line No." = SalesLine."Line No." then begin
                            SalesHeader."Posting Description" := Rec.Description;
                            SalesHeader.Modify();
                        end;
            end;

        end;
    end;
}
