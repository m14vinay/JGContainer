tableextension 50212 "Warehouse Ship Hdr Ext" extends "Warehouse Shipment Header"
{
    fields
    {
        field(50201; "Vehicle No."; Text[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
                WhseShipLine: Record "Warehouse Shipment Line";
            begin
                WhseShipLine.Reset();
                WhseShipLine.SetRange("No.", Rec."No.");
                WhseShipLine.SetRange("Source Document", WhseShipLine."Source Document"::"Sales Order");
                if WhseShipLine.FindSet() then
                    repeat
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No.", WhseShipLine."Source No.");
                        If SalesHeader.FindFirst() then
                            If SalesHeader."Vehicle No." <> Rec."Vehicle No." then begin
                                SalesHeader."Vehicle No." := Rec."Vehicle No.";
                                SalesHeader.Modify(false);
                            end;
                    until WhseShipLine.Next() = 0;
            end;
        }
        field(50202; "Delivery Area"; Code[20])
        {
            Caption = 'Delivery Area';
            DataClassification = CustomerContent;
            TableRelation = "Delivery Area";
        }
        field(50203; "Approval Status"; Enum "Purchase Document Status")
        {
            Caption = 'Approval Status';
            Editable = False;
        }
        field(50204; "Transporter"; Text[50])
        {
            Caption = 'Transporter';
            DataClassification = CustomerContent;
        }

    }
    procedure WhseShpLinesExist(): Boolean
    var
        WareShipLine: Record "Warehouse Shipment Line";
    begin
        WareShipLine.Reset();
        WareShipLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        WareShipLine.SetRange("No.", "No.");
        exit(not WareShipLine.IsEmpty);
    end;
}
