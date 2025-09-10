page 50211 "Transport Contract Services"
{
    ApplicationArea = All;
    Caption = 'Transport Contract Services';
    PageType = List;
    SourceTable = "Transport Contract Pricing";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Carrier Code"; Rec."Carrier Code")
                {
                    ToolTip = 'Specifies the value of the Carrier Code field.', Comment = '%';
                }
                field("Delivery Area Code"; Rec."Delivery Area Code")
                {
                    ToolTip = 'Specifies the value of the Delivery Area Code field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Rate Type"; Rec."Rate Type")
                {
                    ToolTip = 'Specifies the value of the Rate Type field.';
                }
                field(Rate; Rec.Rate)
                {
                    ToolTip = 'Specifies the value of the Rate field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            Group(Action01)
            {
                action(AddService)
                {
                    ApplicationArea = All;
                    Caption = 'Add Transport Service';
                    Image = AddAction;
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = Process;
                    ToolTip = 'Will add Transport Contract services to Shipment';
                    trigger OnAction()
                    var
                        WareShipmentServices: Record "Warehouse Shipment Services";
                        WareShipmentServicesLine: Record "Warehouse Shipment Services";
                        TransportContractPric: Record "Transport Contract Pricing";
                        JGSingleInstance: Codeunit "JGSingleInstance";
                    begin
                        CurrPage.SetSelectionFilter(TransportContractPric);
                        If TransportContractPric.FindSet() then
                            repeat
                                WareShipmentServices.Reset();
                                WareShipmentServices.SetRange("Carrier Code", TransportContractPric."Carrier Code");
                                WareShipmentServices.SetRange("Delivery Area Code", TransportContractPric."Delivery Area Code");
                                WareShipmentServices.SetRange("Item Code", TransportContractPric."Item Code");
                                WareShipmentServices.SetRange("Whse Shipment No.",JGSingleInstance.GetWhseShipNo());
                                If not WareShipmentServices.FindFirst() then begin
                                    WareShipmentServices.Init();
                                    WareShipmentServices."Whse Shipment No." := JGSingleInstance.GetWhseShipNo();
                                    WareShipmentServicesLine.Reset();
                                    WareShipmentServicesLine.SetAscending("Line No.", false);
                                    WareShipmentServicesLine.SetRange("Whse Shipment No.", WareShipmentServices."Whse Shipment No.");
                                    If WareShipmentServicesLine.FindFirst() then
                                        WareShipmentServices."Line No." := WareShipmentServicesLine."Line No." + 10000
                                    else
                                        WareShipmentServices."Line No." := 10000;
                                    WareShipmentServices."Carrier Code" := TransportContractPric."Carrier Code";
                                    WareShipmentServices."Delivery Area Code" := TransportContractPric."Delivery Area Code";
                                    WareShipmentServices."Currency Code" := TransportContractPric."Currency Code";
                                    WareShipmentServices."Item Code" := TransportContractPric."Item Code";
                                    WareShipmentServices."Item Description" := TransportContractPric."Item Description";
                                    WareShipmentServices."Unit of Measure Code" := TransportContractPric."Unit of Measure Code";
                                    WareShipmentServices."Vendor No." := TransportContractPric."Vendor No.";
                                    WareShipmentServices."Vendor Name" := TransportContractPric."Vendor Name";
                                    WareShipmentServices.Rate := TransportContractPric.Rate;
                                    WareShipmentServices."Rate Type" := TransportContractPric."Rate Type";
                                    WareShipmentServices.Insert();
                                end;
                            until TransportContractPric.Next() = 0;
                        Clear(JGSingleInstance);
                        Message('Transport services created');
                    end;
                }
            }
        }
    }
}
