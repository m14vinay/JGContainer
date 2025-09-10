report 50213 "Packing List Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Packing List Report';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/Reports/Layouts/PackingList.rdlc';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Order Date";

            // --- Company Information ---
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyRegNo; CompanyInfo."Registration No.") { }
            column(CompanyCountry; CompanyInfo."Country/Region Code") { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyPhoneFax; CompanyInfo."Marketing Email" + ' ' + CompanyInfo."Fax No.") { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(GetCompanyCountryName; GetCompanyCountryName) { }
            column(GetCompanyAddress; GetCompanyAddress) { }

            // --- Report header ---
            column(ReportTitle; 'PACKING LIST') { }
            column(ReportDate; Today) { }

            // --- Sales Header fields ---
            column(SalesNo; "No.") { }
            column(SellToName; "Sell-to Customer Name") { }
            column(SellToAddress; "Sell-to Address") { }
            column(SellToAddress2; "Sell-to Address 2") { }
            column(SellToPostCountry; "Sell-to Post Code" + ' ' + GetCountyName()) { }

            column(ShipmentFrom; "Shipment From") { }
            column(ShipmentTo; "Shipment To") { }
            column(Vessel; Vessel) { }
            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"),
                               "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = const(Item));

                column(Job_No_; "Shortcut Dimension 2 Code") { }
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(QuantityBase; "Quantity (Base)") { }
                column(Quantity_Pieces; "Quantity Pieces") { }
                column(NetWeight; "Net Weight") { }
                column(GrossWeight; "Gross Weight") { }
                column(Unit_Volume; "Unit Volume") { }
                column(QtyPerPack; QtyPerPack) { }


                trigger OnAfterGetRecord()
                begin
                    LineNo += 1;
                    GetPackSizeQty();
                    AccumulateTotals();
                end;

                trigger OnPreDataItem()
                begin
                    LineNo := 0;
                    TotalQuantity := 0;
                    TotalNetWeight := 0;
                    TotalGrossWeight := 0;
                    TotalVolume := 0;
                end;
            }

            // --- Totals ---
            column(TotalQuantity; TotalQuantity) { }
            column(TotalNetWeight; TotalNetWeight) { }
            column(TotalGrossWeight; TotalGrossWeight) { }
            column(TotalVolume; TotalVolume) { }

            trigger OnAfterGetRecord()
            begin
                GetCompanyInfo();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
    }

    trigger OnInitReport()
    begin
        GetCompanyInfo();
        CompanyInfo.SetAutoCalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        PackSize: Record "Pack Size";
        CountryRegion: Record "Country/Region";
        CompanyAddress: Text[250];
        QtyPerPack: Decimal;
        LineNo: Integer;
        TotalQuantity: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;

    local procedure GetCompanyInfo()
    begin
        if not CompanyInfo.Get() then
            CompanyInfo.Init();

        CompanyAddress := CompanyInfo.Address;
        if CompanyInfo."Address 2" <> '' then
            CompanyAddress += ', ' + CompanyInfo."Address 2";
        if CompanyInfo."Post Code" <> '' then
            CompanyAddress += ', ' + CompanyInfo."Post Code";
        if CompanyInfo.City <> '' then
            CompanyAddress += ', ' + CompanyInfo.City;
        if CompanyInfo.County <> '' then
            CompanyAddress += ', ' + CompanyInfo.County;
        if CompanyInfo."Country/Region Code" <> '' then
            if CountryRegion.Get(CompanyInfo."Country/Region Code") then
                CompanyAddress += ', ' + CountryRegion.Name;
    end;

    local procedure GetSellToCountry(): Text
    var
        CountryRegion: Record "Country/Region";
    begin
        if SalesHeader."Sell-to Country/Region Code" <> '' then
            if CountryRegion.Get(SalesHeader."Sell-to Country/Region Code") then
                exit(CountryRegion.Name);

        exit('');
    end;

    local procedure GetCompanyCountryName(): Text
    var
        CountryRegion: Record "Country/Region";
    begin
        if CompanyInfo."Country/Region Code" <> '' then
            if CountryRegion.Get(CompanyInfo."Country/Region Code") then
                exit(CountryRegion.Name);

        exit('');
    end;

    local procedure GetPackSizeQty()
    begin
        Clear(QtyPerPack);

        if Item.Get(SalesLine."No.") then begin
            if Item."Pack Size" <> '' then
                if PackSize.Get(Item."Pack Size") then
                    QtyPerPack := PackSize."Qty Per Pack";
        end;
    end;

    local procedure AccumulateTotals()
    begin
        TotalQuantity += SalesLine.Quantity;
        TotalNetWeight += SalesLine."Net Weight";
        TotalGrossWeight += SalesLine."Gross Weight";
        TotalVolume += SalesLine."Unit Volume";
    end;

    local procedure GetCompanyAddress(): Text
    var
        CountryRegion: Record "Country/Region";
        County: Record County;
        CountryName: Text;
        CountyName: Text;
    begin
        if CompanyInfo."Country/Region Code" <> '' then
            if CountryRegion.Get(CompanyInfo."Country/Region Code") then
                CountryName := CountryRegion.Name;

        if (CompanyInfo.County <> '') then
            if County.Get(CompanyInfo.County) then
                CountyName := County.Description;

        exit(
            Format(
                CompanyInfo.Address + ', ' +
                CompanyInfo."Address 2" + ', ' +
                CompanyInfo."Post Code" + ', ' +
                CompanyInfo.City + ', ' +
                CountyName + ', ' +
                CountryName
            )
        );
    end;

    local procedure GetCountyName(): Text
    var
        CountyRec: Record County;
    begin
        if (SalesHeader."Sell-to County" <> '') then
            if CountyRec.Get(SalesHeader."Sell-to County") then
                exit(CountyRec.Description);

        exit(SalesHeader."Sell-to County");
    end;

}
