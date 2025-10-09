codeunit 50201 "Event Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforePostedWhseShptHeaderInsert', '', false, false)]
    local procedure OnBeforePostWhseShptHeader(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        PostedWhseShipmentHeader."Vehicle No." := WarehouseShipmentHeader."Vehicle No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Record Restriction Mgt.", 'OnRestrictRecordUsageOnBeforeSetFilter', '', false, false)]
    local procedure BlockRecordsOnRecordRestrict(var RestrictedRecord: Record "Restricted Record"; RecordReference: RecordRef)
    var
        Item: Record Item;
        Vendor: Record Vendor;
        Customer: Record Customer;
    begin
        If RecordReference.Number = Database::Item then begin
            RecordReference.SetTable(Item);
            Item.Blocked := True;
            Item.Modify();
        end;
        If RecordReference.Number = Database::Vendor then begin
            RecordReference.SetTable(Vendor);
            Vendor.Blocked := Vendor.Blocked::All;
            Vendor.Modify();
        end;
        If RecordReference.Number = Database::Customer then begin
            RecordReference.SetTable(Customer);
            Customer.Blocked := Customer.Blocked::All;
            Customer.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales Price Calc. Mgt.", 'OnFindSalesLinePriceOnItemTypeOnAfterSetUnitPrice', '', false, false)]
    local procedure UpdatePricePerPiece(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price" temporary; CalledByFieldNo: Integer; FoundSalesPrice: Boolean)
    begin
        If TempSalesPrice."Approval Status" = TempSalesPrice."Approval Status"::Released then 
        
            SalesLine."Price Per Piece" := TempSalesPrice."Price Per Piece"
        Else
           SalesLine."Unit Price" := 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Code', false, false)]
    local procedure UpdateDeliveryAreaCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        ShipToAddress: Record "Ship-to Address";
    begin
        If ShipToAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code") then
            Rec."Delivery Area" := ShipToAddress."Delivery Area";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Get Source Doc. Outbound", 'OnAfterFindWarehouseRequestForSalesOrder', '', false, false)]
    local procedure UpdateDeliveryCode(var WarehouseRequest: Record "Warehouse Request"; SalesHeader: Record "Sales Header")
    begin
        WarehouseRequest."Delivery Area" := SalesHeader."Delivery Area";
    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnSalesLineOnAfterCreateShptHeader', '', false, false)]
    local procedure UpdaeWhseShipDeliveryArea(var WhseShptHeader: Record "Warehouse Shipment Header"; WhseHeaderCreated: Boolean; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; WarehouseRequest: Record "Warehouse Request");
    begin
        WhseShptHeader."Delivery Area" := SalesHeader."Delivery Area";
        WhseShptHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Whse.-Post Shipment", 'OnCodeOnAfterGetWhseShptHeader', '', false, false)]
    local procedure UpdateSalesHeaderWhse(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        SalesHeader: Record "Sales Header";
        WareShipLine: Record "Warehouse Shipment Line";
    begin
        WareShipLine.Reset();
        WareShipLine.SetRange("No.", WarehouseShipmentHeader."No.");
        WareShipLine.SetRange("Source Document", WareShipLine."Source Document"::"Sales Order");
        If WareShipLine.FindSet() then
            repeat

                SalesHeader.Reset();
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange("No.", WareShipLine."Source No.");
                If SalesHeader.FindFirst() then begin
                    SalesHeader."Whse Ship No" := WareShipLine."No.";
                    SalesHeader.Modify(false);
                end;

            until WareShipLine.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntryProcedure', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; var IsHandled: Boolean; var ItemJournalLine: Record "Item Journal Line")
    begin
        If ItemLedgerEntry.Quantity > 0 then
            ItemLedgerEntry."Quantity Pieces" := ItemJournalLine."Quantity Pieces"
        else
            ItemLedgerEntry."Quantity Pieces" := -ItemJournalLine."Quantity Pieces";
        ItemLedgerEntry."Net Weight" := ItemJournalLine."Net Weight";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure OnAfterCopyFromTransferLine(var TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                TransferShipmentLine."Quantity Pieces" := TransferLine."Qty. to Ship" * PackSize."Qty Per Pack";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Line", 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure OnAfterCopyFromTransferLineRecpt(var TransferReceiptLine: Record "Transfer Receipt Line"; TransferLine: Record "Transfer Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                TransferReceiptLine."Quantity Pieces" := TransferLine."Qty. to Receive" * PackSize."Qty Per Pack";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                ItemJournalLine."Quantity Pieces" := TransferLine."Qty. to Ship" * PackSize."Qty Per Pack";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                ItemJournalLine."Quantity Pieces" := TransferLine."Qty. to Receive" * PackSize."Qty Per Pack";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"TransferOrder-Post Transfer", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLineTransfer(var ItemJnlLine: Record "Item Journal Line"; TransLine: Record "Transfer Line"; DirectTransHeader: Record "Direct Trans. Header"; DirectTransLine: Record "Direct Trans. Line")

    begin
        ItemJnlLine."Quantity Pieces" := TransLine."Quantity Pieces";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", 'OnPostItemJnlLineOnAfterPrepareItemJnlLine', '', false, false)]
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin

        If Item.Get(SalesLine."No.") then
            If PackSize.Get(Item."Pack Size") then
                If SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" then
                    ItemJournalLine."Quantity Pieces" := SalesLine."Return Qty. to Receive" * PackSize."Qty Per Pack";
        If (SalesLine."Document Type" = SalesLine."Document Type"::Order) and (SalesLine."Qty. to Ship" <> 0) then
            ItemJournalLine."Quantity Pieces" := -SalesLine."Qty. to Ship" * PackSize."Qty Per Pack"
    end;



}
