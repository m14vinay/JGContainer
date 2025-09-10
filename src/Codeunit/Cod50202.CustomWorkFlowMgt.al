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

    [IntegrationEvent(false, false)]
    procedure OnSendSalesPriceForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelSalesPriceForApproval(var RecRef: RecordRef)
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        SalesPrice: Record "Sales Price";
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
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        SalesPricePending: Record "Sales Price";
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
    begin
        Clear(SalesType);
        case RecRef.Number of
            Database::"Sales Price":
                begin
                    RecRef.SetTable(SalesPricePopulate);
                    ApprovalEntryArgument."Document No." := SalesPricePopulate."Item No.";
                    /*If SalesPricePopulate."Sales Type" = SalesPricePopulate."Sales Type"::Customer then
                       SalesType := 'Customer';
                        If SalesPricePopulate."Sales Type" = SalesPricePopulate."Sales Type"::"All Customers" then
                       SalesType := 'All Customers';
                        If SalesPricePopulate."Sales Type" = SalesPricePopulate."Sales Type"::Campaign then
                       SalesType := 'Campaign';
                        If SalesPricePopulate."Sales Type" = SalesPricePopulate."Sales Type"::"Customer Price Group" then
                       SalesType := 'Customer Price Group';*/
                         

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        SalesPriceRej: Record "Sales Price";

    begin
        case ApprovalEntry."Table ID" of
            Database::"Sales Price":
                begin
                    if SalesPriceRej.Get(ApprovalEntry."Record ID to Approve") then
                        SalesPriceRej.Validate("Approval Status", SalesPriceRej."Approval Status"::Open);
                    SalesPriceRej.Modify(True);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; Var Handled: Boolean)
    var
        SalesPriceRelease: Record "Sales Price";
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

    end;

    
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnConditionalCardPageIDNotFound', '', true, true)]
    local procedure OnConditionalCardPageIDNotFound(RecordRef: RecordRef; var CardPageID: Integer)
    begin
        if RecordRef.Number = DATABASE::"Sales Price" then
            CardPageID := PAGE::"Sales Prices cust";

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


}
