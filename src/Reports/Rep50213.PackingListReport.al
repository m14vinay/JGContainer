report 50213 "Packing List Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Packing List Report';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/Reports/Layouts/PackingList.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Order Date";

            // --- Company Information ---
            column(PrintName; CompanyInfo."Print Name")
            {
            }
            column(CompanyAddress; CompanyInfo."Address")
            {
            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo."City")
            {
            }
            column(CompanyTIN; CompanyInfo."ADY E-INV TIN No.")
            {
            }
            column(CompanyMSICCode; CompanyMSICCode)
            {
            }
            column(CompanyState; CompanyCounty)
            {
            }
            column(ShipToAddrTxt; ShipToAddrTxt) { }
            column(BillToAddrTxt; BillToAddrTxt) { }

            column(CompanyCountry; CompanyCountry)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Marketing Phone No")
            {
            }
            column(CompanyInfoEmail; CompanyInfo."Marketing Email")
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo."ADY E-INV SST Reg No.")
            {
            }
            column(CompanyInfoBusinessRegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfoBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyLogo; CompanyInfo."Picture")
            {
            }
            column(CompanyPicture1; CompanyInfo."Company Logo 1")
            {
            }
            column(CompanyPicture2; CompanyInfo."Company Logo 2")
            {
            }
            column(CompanyPicture3; CompanyInfo."Company Logo 3")
            {
            }
            column(AlternateBank1; CompanyInfo."Alternative Bank 1")
            {
            }
            column(AlternateBank2; CompanyInfo."Alternative Bank 2")
            {
            }
            column(CompanyPhoneFax; CompanyInfo."Marketing Email" + ' ' + CompanyInfo."Fax No.") { }
            // --- Report header ---
            column(ReportTitle; 'PACKING LIST') { }
            column(ReportDate; Today) { }
            column(CommercialInvoiceDate; Format(SalesHeader."Commercial Invoice Date", 0, '<day,2>.<month,2>.<year4>')) { }

            // --- Sales Header fields ---
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Bill_to_Address; Bill_to_Address)
            {
            }
            column(Bill_to_Address2; "Bill-to Address 2")
            {
            }
            column(BilltoPhoneNo; BilltoPhoneNo)
            {
            }
            column(Billtomobileno; Billtomobileno)
            {
            }
            column(BIllpostcodecitycountrycounty; BIllpostcodecitycountrycounty)
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Shippostcodecitycountrycounty; "Ship-to Post Code" + ', ' + "Ship-to City" + ', ' + "Ship-to County" + ', ' + ShipCountry)
            {
            }
            column(Ship_to_Phone_No_; "Ship-to Phone No.")
            {
            }
            column(Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(SalesHeaderNo_; "No.")
            {
            }
            column(Shipment_Date; Format("Requested Delivery Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(PaymentTerms; "Payment Terms Code")
            {
            }
            column(CustomerCode; "Sell-to Customer No.")
            {
            }
            column(Incoterm; "ADY E-INV Incoterms Code")
            {
            }
            column(SalesPerson; SalesPersonPurch.Name)
            {
            }
            column(Document_Date; Format("Document Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column("selltocustomercode"; "Sell-to Customer No.")
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Work_Description; GetWorkDescription())
            {
            }
            column(ShipemntHeaderNo; "No.")
            {
            }
            column(Currency; "Currency Code")
            {
            }
            column(SSTExemption; "SST Exemption registration No.")
            {
            }
            column(EffectiveDate; EffectiveDate) { }
            column(Vessel; Vessel) { }
            column(CommercialInvoiceNo; "Commercial Invoice No") { }
            column(Commercial_Invoice_Date; Format("Commercial Invoice Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(TotalQuantity; TotalQuantity) { }
            column(TotalNetWeight; TotalNetWeight) { }
            column(TotalGrossWeight; TotalGrossWeight) { }
            column(TotalVolume; TotalVolume) { }
            column(ShipmentFrom; "Shipment From") { }
            column(ShipmentTo; "Shipment To") { }
            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"),
                               "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = const(item));
                dataitem(itemrecord; Item)
                {
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = where(Type = const(Inventory));
                    column(Job_No_; SalesLine."Shortcut Dimension 2 Code") { }
                    column(ItemNo; SalesLine."No.") { }
                    column(Description; SalesLine.Description) { }
                    column(Quantity; SalesLine.Quantity) { }
                    column(QuantityBase; SalesLine."Quantity (Base)") { }
                    column(Quantity_Pieces; SalesLine."Quantity Pieces") { }
                    column(NetWeight; SalesLine."Net Weight") { }
                    column(GrossWeight; SalesLine."Gross Weight") { }
                    column(Unit_Volume; SalesLine."Unit Volume") { }
                    column(QtyPerPack; QtyPerPack) { }
                    column(Container; SalesLine."Container No.") { }
                    column(SealNo; SalesLine.Seal) { }
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
            }
            trigger OnAfterGetRecord()
            var
                CountryRegion: Record "Country/Region";
                Customer: Record "Customer";
                VATPostingSetup: Record "VAT Posting Setup";
                salesline: Record "Sales Line";
            begin
                Clear(EffectiveDate);
                Clear(ShipToAddrTxt);
                Clear(BillToAddrTxt);
                cr := 13;
                lf := 10;
                If SalesPersonPurch.Get("Salesperson Code") then;
                if not Currency.Get("Currency Code") then
                    Currency.InitRoundingPrecision();
                if CountryRegion.Get("Ship-to Country/Region Code") then
                    ShipCountry := CountryRegion.Name;
                Customer.Get("Bill-to Customer No.");
                Bill_to_Address := Customer.Address + ', ' + Customer."Address 2";
                BilltoPhoneNo := Customer."Phone No.";
                Billtomobileno := Customer."Mobile Phone No.";
                BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + Customer.County + ', ' + BIllCountry;
                if CountryRegion.Get(Customer."Country/Region Code") then
                    BIllCountry := CountryRegion.Name;
                BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + Customer.County + ', ' + BIllCountry;
                If "Ship-to Address" <> '' then
                    ShipToAddrTxt += "Ship-to Address" + Format(cr) + Format(lf);
                If "Ship-to Address 2" <> '' then
                    ShipToAddrTxt += "Ship-to Address 2" + Format(cr) + Format(lf);
                If "Ship-to Post Code" <> '' then
                    ShipToAddrTxt += "Ship-to Post Code" + ' ';
                If "Ship-to City" <> '' then
                    ShipToAddrTxt += "Ship-to City" + ', ';
                If "Ship-to County" <> '' then
                    if County.Get("Ship-to County") then begin
                        If ShipCountry <> '' then
                            ShipToAddrTxt += County.Description + ', '
                        else
                            ShipToAddrTxt += County.Description;
                    end else begin
                        If ShipCountry <> '' then
                            ShipToAddrTxt += "Ship-to County" + ', '
                        else
                            ShipToAddrTxt += "Ship-to County";
                    end;
                If ShipCountry <> '' then
                    ShipToAddrTxt += ShipCountry;

                If Customer.Address <> '' then
                    BillToAddrTxt += Customer.Address + Format(cr) + Format(lf);
                If Customer."Address 2" <> '' then
                    BillToAddrTxt += Customer."Address 2" + Format(cr) + Format(lf);
                If Customer."Post Code" <> '' then
                    BillToAddrTxt += Customer."Post Code" + ' ';
                If Customer.City <> '' then
                    BillToAddrTxt += Customer.City + ', ';
                If Customer.County <> '' then
                    if County.Get(Customer.County) then begin
                        If BIllCountry <> '' then
                            BillToAddrTxt += County.Description + ', '
                        else
                            BillToAddrTxt += County.Description;
                    end else begin
                        If BIllCountry <> '' then
                            BillToAddrTxt += Customer.County + ', '
                        else
                            BillToAddrTxt += Customer.County;
                    end;
                If BIllCountry <> '' then
                    BillToAddrTxt += BIllCountry;
                SSTExemption.Reset();
                SSTExemption.SetRange("Customer No.", "Sell-to Customer No.");
                SSTExemption.SetRange("SST Exemption Registration No.", "SST Exemption Registration No.");
                If SSTExemption.FindFirst() then
                    EffectiveDate := SSTExemption."Effective Date";
            end;

            trigger OnPreDataItem()
            var
                CountryRegion: Record "Country/Region";
                BankAccount: Record "Bank Account";
                County: Record County;
            begin
                CompanyInfo.Get();
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                begin

                    if CountryRegion.Get(CompanyInfo."Country/Region Code") then
                        CompanyCountry := CountryRegion.Name;
                    if County.Get(CompanyInfo."County") then
                        CompanyCounty := County."Description";
                    // Lookup MSIC Code from ADY e-Inv Comp MSIC Setup
                    Clear(CompanyMSICCode);
                    if ADYEInvCompMSICSetup.FindFirst() then
                        if ADYEInvCompMSICSetup."ADY Name" = CompanyInfo.Name then
                            CompanyMSICCode := ADYEInvCompMSICSetup."ADY E-INV MSIC CODE";
                end;

                GLSetup.Get();
            end;


        }

    }

    requestpage
    {
        SaveValues = true;
    }

    trigger OnInitReport()
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.SetAutoCalcFields("Company Logo 1");
        CompanyInfo.SetAutoCalcFields("Company Logo 2");
        CompanyInfo.SetAutoCalcFields("Company Logo 3");
    end;

    var
        CompanyAddr: array[8] of Text[100];
        BIllpostcodecitycountrycounty: Text;
        Bill_to_Address: Text;
        CompanyCountry: Text;
        CompanyCounty: Text;
        Billtomobileno: Text;
        BilltoPhoneNo: Text;
        ShipCountry: text;
        BIllCountry: Text;
        DocumentDate: date;
        CompanyInfo: Record "Company Information";
        Item: Record Item;
        PackSize: Record "Pack Size";
        CountryRegion: Record "Country/Region";
        SalesPersonPurch: Record "Salesperson/Purchaser";
        EffectiveDate: Date;
        SSTExemption: Record "SST Exemption Details";

        CompanyAddress: Text[250];
        QtyPerPack: Decimal;
        LineNo: Integer;
        TotalQuantity: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        ADYEInvCompMSICSetup: Record "ADY e-Inv Comp MSIC Setup";
        CompanyMSICCode: Code[20];
        BillToAddrTxt: Text[200];
        ShipToAddrTxt: Text[200];
        Shiptotxt: Text[100];
        cr: Char;
        lf: Char;
        County: Record County;


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

    local procedure CurrencyCode(SrcCurrCode: Code[10]): Code[10]
    begin
        if SrcCurrCode = '' then
            exit(GLSetup."LCY Code")
        else
            exit(SrcCurrCode);
    end;

    local procedure BuildBank2Address(Bank: Record "Bank Account"): Text
    var
        Country: Record "Country/Region";
        County: Record County;
        Addr: Text;
    begin
        if Bank.Address <> '' then
            Addr += Bank.Address;
        if Bank."Address 2" <> '' then
            Addr += ', ' + Bank."Address 2";
        if Bank."Post Code" <> '' then
            Addr += ', ' + Bank."Post Code";
        if Bank.City <> '' then
            Addr += ', ' + Bank.City;
        if Bank.County <> '' then
            If County.Get(Bank.County) then
                Addr += ', ' + County.Description;

        if Bank."Country/Region Code" <> '' then begin
            if Country.Get(Bank."Country/Region Code") then
                Addr += ', ' + Country.Name
            else
                Addr += ', ' + Bank."Country/Region Code"; // fallback if record missing
        end;

        exit(Addr);
    end;

}
