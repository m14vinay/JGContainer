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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure UpdateClosed(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        SalesL: Record "Sales Line";
        FullyInvoice: Boolean;
        SalesHdr: Record "Sales Header";
        CRLine: Record "Sales Cr.Memo Line";
        CNInvoiceQty: Decimal;
        ReturnOrderNo: Code[20];
        Returorder: Boolean;
    begin
        If SalesCrMemoHdrNo <> '' then begin
            Clear(ReturnOrderNo);
            CRLine.Reset();
            CRLine.SetRange("Document No.", SalesCrMemoHdrNo);
            CRLine.Setfilter("Order No.", '<>%1', '');
            If CRLine.FindFirst then
                ReturnOrderNo := CRLine."Order No.";

            If ReturnOrderNo <> '' then begin
                FullyInvoice := True;
                SalesL.Reset();
                SalesL.SetRange("Document Type", SalesL."Document Type"::"Return Order");
                SalesL.SetRange("Document No.", ReturnOrderNo);
                If SalesL.FindSet() then begin
                    repeat
                        Returorder := True;
                        If SalesL.Quantity <> SalesL."Quantity Invoiced" then
                            FullyInvoice := false;
                    until SalesL.Next() = 0;
                    If FullyInvoice and Returorder then
                        If SalesHdr.Get(SalesHdr."Document Type"::"Return Order", ReturnOrderNo) then begin
                            SalesHdr.Closed := True;
                            SalesHdr.Modify();
                        end;
                end;
            End;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'SST Exemption Registration No.', false, false)]
    local procedure UpdateTaxExemption(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        ShipToAddress: Record "Ship-to Address";
    begin
        If Rec."SST Exemption Registration No." <> '' then
            Rec."ADY E-INV Dtl of Tax Exemption" := Rec."SST Exemption Registration No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Get Source Doc. Outbound", 'OnAfterFindWarehouseRequestForSalesOrder', '', false, false)]
    local procedure UpdateDeliveryCode(var WarehouseRequest: Record "Warehouse Request"; SalesHeader: Record "Sales Header")
    begin
        WarehouseRequest."Delivery Area" := SalesHeader."Delivery Area";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure UpdateTransportCost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20])
    var
        WarehouseShipment: Record "Warehouse Shipment Services";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TransportCostDetails: Record "Transport Cost Details";
        TransportCostDetailsLine: Record "Transport Cost Details";
    begin
        SalesShipmentHeader.Reset();
        SalesShipmentHeader.SetRange("No.", SalesShptHdrNo);
        If SalesShipmentHeader.FindFirst() then;
        WarehouseShipment.Reset();
        WarehouseShipment.SetRange("Whse Shipment No.", SalesShipmentHeader."Whse Ship No");
        If WarehouseShipment.FindSet() then
            repeat
                If WarehouseShipment."Rate Type" = WarehouseShipment."Rate Type"::Pallet then begin
                    SalesShipmentLine.Reset();
                    SalesShipmentLine.SetRange("Document No.", SalesShptHdrNo);
                    SalesShipmentLine.SetRange(Type, SalesShipmentLine.Type::Item);
                    SalesShipmentLine.SetFilter(Quantity, '>%1', 0);
                    If SalesShipmentLine.FindSet() then
                        repeat
                            TransportCostDetails.Init();
                            TransportCostDetailsLine.SetAscending("Line No", false);
                            If TransportCostDetailsLine.FindFirst() then
                                TransportCostDetails."Line No" := TransportCostDetailsLine."Line No" + 10000
                            else
                                TransportCostDetails."Line No" := 10000;
                            TransportCostDetails."Item No." := SalesShipmentLine."No.";
                            TransportCostDetails.QTY := SalesShipmentLine.Quantity;
                            TransportCostDetails.UOM := SalesShipmentLine."Unit of Measure Code";
                            TransportCostDetails.Cost := WarehouseShipment.Rate;
                            TransportCostDetails."Line Amount" := WarehouseShipment.Rate * SalesShipmentLine.Quantity;
                            TransportCostDetails.Carrier := WarehouseShipment."Carrier Code";
                            TransportCostDetails."Vendor No." := WarehouseShipment."Vendor No.";
                            TransportCostDetails."DO" := SalesShipmentLine."Document No.";
                            TransportCostDetails."DO Date" := SalesShipmentHeader."Document Date";
                            TransportCostDetails.Customer := SalesShipmentLine."Sell-to Customer No.";
                            TransportCostDetails."Whse Shipment No." := WarehouseShipment."Whse Shipment No.";
                            TransportCostDetails.Insert();
                        until SalesShipmentLine.Next() = 0;
                end;
                If WarehouseShipment."Rate Type" = WarehouseShipment."Rate Type"::Fixed then begin
                    TransportCostDetails.Init();
                    TransportCostDetailsLine.SetAscending("Line No", false);
                    If TransportCostDetailsLine.FindFirst() then
                        TransportCostDetails."Line No" := TransportCostDetailsLine."Line No" + 10000
                    else
                        TransportCostDetails."Line No" := 10000;
                    TransportCostDetails."Item No." := WarehouseShipment."Item Code";
                    TransportCostDetails.QTY := 1;
                    TransportCostDetails.UOM := WarehouseShipment."Unit of Measure Code";
                    TransportCostDetails.Cost := WarehouseShipment.Rate;
                    TransportCostDetails."Line Amount" := WarehouseShipment.Rate * 1;
                    TransportCostDetails.Carrier := WarehouseShipment."Carrier Code";
                    TransportCostDetails."Vendor No." := WarehouseShipment."Vendor No.";
                    TransportCostDetails."DO" := SalesShipmentHeader."No.";
                    TransportCostDetails."DO Date" := SalesShipmentHeader."Document Date";
                    TransportCostDetails.Customer := SalesShipmentHeader."Sell-to Customer No.";
                    TransportCostDetails."Whse Shipment No." := WarehouseShipment."Whse Shipment No.";
                    TransportCostDetails.Insert();
                end;
                WarehouseShipment.Delete();
            until WarehouseShipment.Next() = 0;
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

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", 'OnPostItemJnlLineOnAfterPrepareItemJnlLine', '', false, false)]
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin

        If Item.Get(SalesLine."No.") then
            If PackSize.Get(Item."Pack Size") then
                If SalesLine."Document Type" = SalesLine."Document Type"::"Return Order" then
                    ItemJournalLine."Quantity Pieces" := PackSize."Qty Per Pack";
        If (SalesLine."Document Type" = SalesLine."Document Type"::Order) and (SalesLine."Qty. to Ship" <> 0) then
            ItemJournalLine."Quantity Pieces" :=  PackSize."Qty Per Pack"
    end;

    [EventSubscriber(ObjectType::Page, Page::"Doc. Attachment List Factbox", 'OnAfterGetRecRefFail', '', false, false)]
    local procedure OnBeforeDrillDown(var Sender: Page "Doc. Attachment List Factbox"; DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        SalesPrice: Record "Sales Price";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Sales Price":
                begin
                    RecRef.Open(DATABASE::"Sales Price");
                    SalesPrice.Reset();
                    SalesPrice.SetRange("Item No.", DocumentAttachment."No.");
                    SalesPrice.SetRange("Sales Type", DocumentAttachment."Sales Type");
                    SalesPrice.SetRange("Starting Date", DocumentAttachment."Starting Date");
                    SalesPrice.SetRange("Variant Code", DocumentAttachment."Variant Code");
                    SalesPrice.SetRange("Unit of Measure Code", DocumentAttachment."Unit of Measure Code");
                    SalesPrice.SetRange("Sales Code", DocumentAttachment."Sales Code");
                    SalesPrice.SetRange("Currency Code", DocumentAttachment."Currency Code");
                    If SalesPrice.FindFirst() then
                        //if SalesPrice.Get(DocumentAttachment."No.",DocumentAttachment."Sales Type",DocumentAttachment."Sales Code",DocumentAttachment."Starting Date",DocumentAttachment."Currency Code",DocumentAttachment."Variant Code",DocumentAttachment."Unit of Measure Code") then
                        RecRef.GetTable(SalesPrice);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
        StartDate: Date;
        SalesType: Enum "Sales Price Type";
        MinQty: Decimal;
    begin
        case RecRef.Number of
            DATABASE::"Sales Price":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    FieldRef := RecRef.Field(13);
                    SalesType := FieldRef.Value;
                    DocumentAttachment.SetRange("Sales Type", SalesType);
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("Currency Code", RecNo);
                    FieldRef := RecRef.Field(4);
                    StartDate := FieldRef.Value;
                    DocumentAttachment.SetRange("Starting Date", StartDate);
                    FieldRef := RecRef.Field(13);
                    SalesType := FieldRef.Value;
                    DocumentAttachment.SetRange("Sales Type", SalesType);
                    FieldRef := RecRef.Field(5400);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("Unit of Measure Code", RecNo);
                    FieldRef := RecRef.Field(5700);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("Variant Code", RecNo);
                    FieldRef := RecRef.Field(14);
                    MinQty := FieldRef.Value;
                    DocumentAttachment.SetRange("Minimum Quantity", MinQty);
                    // FlowFieldsEditable := false;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        StartDate: Date;
        SalesType: Enum "Sales Price Type";
        LineNo: Integer;
        MinQty: Decimal;
    begin
        case RecRef.Number of
            DATABASE::"Sales Price":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    FieldRef := RecRef.Field(13);
                    SalesType := FieldRef.Value;
                    DocumentAttachment.Validate("Sales Type", SalesType);
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("Currency Code", RecNo);
                    FieldRef := RecRef.Field(4);
                    StartDate := FieldRef.Value;
                    DocumentAttachment.Validate("Starting Date", StartDate);
                    FieldRef := RecRef.Field(13);
                    SalesType := FieldRef.Value;
                    DocumentAttachment.Validate("Sales Type", SalesType);
                    FieldRef := RecRef.Field(5400);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("Unit of Measure Code", RecNo);
                    FieldRef := RecRef.Field(5700);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("Variant Code", RecNo);
                    FieldRef := RecRef.Field(14);
                    MinQty := FieldRef.Value;
                    DocumentAttachment.Validate("Minimum Quantity", MinQty);

                end;
        end;
    end;
}
