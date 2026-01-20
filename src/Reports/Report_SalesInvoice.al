report 50207 SalesInvoiceReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/SalesInvoiceReport_v1.rdl';
    Caption = 'Sales Invoice';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Sales Invoice Header";

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
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
            column(CompanyState; CompanyCounty)
            {
            }
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
            column(CompanyTIN; CompanyInfo."ADY E-INV TIN No.")
            {
            }
            column(CompanyMSICCode; CompanyMSICCode)
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
            column(ReportTitle; ReportTitle)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Bill_to_Address; Bill_to_Address)
            {
            }
            column(Bill_to_Address2; "Bill-to Address 2")
            {
            }
            column(ShipToAddrTxt; ShipToAddrTxt) { }
            column(BillToAddrTxt; BillToAddrTxt) { }
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
            column(Shippostcodecitycountrycounty; Shippostcodecitycountrycounty_g) { }
            column(Ship_to_Phone_No_; "Ship-to Phone No.")
            {
            }
            column(Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(DueDate; Format("Due Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(PaymentTerms; "Payment Terms Code")
            {
            }
            column(CustomerCode; "Sell-to Customer No.")
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
            column(DONo; DONo)
            {

            }
            column(Work_Description; GetWorkDescription())
            {

            }
            column(No; "No.")
            {

            }
            column(ShowAmount; ShowAmount)
            {
            }
            column(CurrencyCodeCurrencyCode; CurrencyCode("Currency Code"))
            {
            }
            column(AmountInWords; AmountInWords)
            {
            }
            column(TotalShowAmount; TotalShowAmount)
            {
            }
            column(SalesTax; "SalesTax")
            {

            }
            column(AlternateBankName1; AlternateBankName1)
            {

            }
            column(AlternateBankName2; AlternateBankName2)
            {

            }
            column(AlternateBankAccountNo2; AlternateBankAccountNo2)
            {

            }
            column(AlternateBankAddress2; AlternateBankAddress2)
            {

            }
            column(AlternateBankSwiftCode2; AlternateBankSwiftCode2)
            {

            }
            column(AlternateBankAccountNo1; AlternateBankAccountNo1)
            {

            }
            column(Currency; "Currency Code")
            {

            }
            column(SSTExemption; "SST Exemption registration No.")
            {

            }
            column(EffectiveDate; Format(EffectiveDate, 0, '<day,2>.<month,2>.<year4>')) { }
            column(SalesTaxPercent; SalesTaxPercent)
            {

            }
            column(Currency_Code; Currency_Code) { }
            column(GTINQRCode; "ADY E-INV QR Code") { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                column(Type; "Type")
                {

                }
                column(Variant_Code; Variant_Code)
                {

                }
                column(ItemCode; "Item Reference No.")
                {

                }
                column(Noofplts; "Quantity")
                {

                }
                column(NoofpltsLabel; GetNoofpltsLabel())
                {

                }
                column(UnitPrice; "Price Per Piece")
                {

                }
                column(UnitPriceLabel; GetUnitPriceLabel())
                {

                }
                column(UnitPriceValue; GetUnitPriceValue())
                {

                }
                column(Packing; Packing)
                {

                }
                column(Quantity; "Quantity")
                {

                }
                column(QuantityPcsLabel; GetQuantityPcsLabel())
                {

                }
                column(QuantityPcsValue; GetQuantityPcsValue())
                {

                }
                column(No_; "Shortcut Dimension 2 Code")
                {

                }
                column(SalesHeaderNo_; "Order No.")
                {
                }

                column(Description; "Description")
                {

                }
                column(Amount; "Line Amount")
                {

                }
                column(IsCharge; IsCharge)
                {

                }
                column(SubTotal; SubTotal)
                {

                }
                column(LineNo; LineNo)
                {

                }
                trigger OnAfterGetRecord()
                var
                    ItemCard: Record Item;
                    Packsize: Record "Pack Size";
                    SalesPrice: Record "Sales Price";
                begin
                    ShowAmount := "Line Amount";
                    SalesTax := "Amount Including VAT" - "Amount";
                    TotalShowAmount := ShowAmount + TotalShowAmount + SalesTax;

                    if Type = Type::Item then begin
                        if ItemCard.Get("No.") then begin
                            Variant_Code := ItemCard."Pack Size";
                            if Packsize.Get(Variant_Code) then begin
                                Packing := Packsize."Qty Per Pack";
                            end
                            else
                                Clear(Packing);
                            SalesPrice.SetRange("Item No.", "No.");
                            SalesPrice.SetRange("Sales Code", "Sell-to Customer No.");
                            SalesPrice.SetRange("Unit of Measure Code", "Unit of Measure Code");
                            if SalesPrice.FindFirst() then begin
                                Unit_Price := SalesPrice."Price Per Piece";
                            end;
                        end else
                            Clear(Variant_Code);
                    end;

                    IsCharge := false;
                    if Type = Type::"Charge (Item)" then
                        IsCharge := true
                    else
                        if Type = Type::Item then begin
                            if ItemCard.Get("No.") then
                                if ItemCard."Print Charges in Footer" then
                                    IsCharge := true;
                        end;

                    if not IsCharge then begin
                        LineNo := LineNo + 1;
                        SubTotal += "Sales Invoice Line"."Line Amount";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    "Sales Invoice Line".SetRange("Document No.", "Sales Invoice Header"."No.");
                    "Sales Invoice Line".SetFilter("Sales Invoice Line".Type, '<>%1', "Sales Invoice Line".Type::" ");


                end;
            }

            trigger OnAfterGetRecord()
            var
                CountryRegion: Record "Country/Region";
                County: Record County;
                Customer: Record "Customer";
                SalesInvoiceLine: Record "Sales Invoice Line";
                VATPostingSetup: Record "VAT Posting Setup";
                TempCodeCheck: Codeunit 50200;
                TempNoText: array[2] of Text;
            begin
                Clear(EffectiveDate);
                Clear(LineNo);
                Clear(SubTotal);
                Clear(TotalShowAmount);
                Clear(SalesTax);
                Clear(ShowAmount);
                Clear(SalesPersonPurch);
                Clear(DONo);
                CalcFields("ADY E-INV QR Code");
                Clear(ShipToAddrTxt);
                Clear(BillToAddrTxt);
                Clear(ShipCountry);
                Clear(BIllCountry);
                cr := 13;
                lf := 10;

                If SalesPersonPurch.Get("Salesperson Code") then;
                if not Currency.Get("Currency Code") then
                    Currency.InitRoundingPrecision();

                if CountryRegion.Get("Ship-to Country/Region Code") then
                    ShipCountry := CountryRegion.Name;

                If Customer.Get("Bill-to Customer No.") then;
                If Customer.Address <> '' then
                    BillToAddrTxt += Customer.Address + Format(cr) + Format(lf);
                If Customer."Address 2" <> '' then
                    BillToAddrTxt += Customer."Address 2" + Format(cr) + Format(lf);
                If Customer."Post Code" <> '' then
                    BillToAddrTxt += Customer."Post Code" + ' ';
                If Customer.City <> '' then
                    BillToAddrTxt += Customer.City + ', ';

                Bill_to_Address := Customer.Address;
                BilltoPhoneNo := Customer."Phone No.";
                Billtomobileno := Customer."Mobile Phone No.";
                if CountryRegion.Get(Customer."Country/Region Code") then
                    if CountryRegion.Name <> '' then;
                If Customer.County <> '' then
                    if FindCountyByNameOrDescription(Customer.County, County) then begin
                        if not County."Hide in Documents" then begin
                            If CountryRegion.Name <> '' then
                                BillToAddrTxt += County.Description + ', '
                            else
                                BillToAddrTxt += County.Description;
                        end;
                    end else begin
                        If CountryRegion.Name <> '' then
                            BillToAddrTxt += Customer.County + ', '
                        else
                            BillToAddrTxt += Customer.County;
                    end;

                BillToAddrTxt += CountryRegion.Name;

                if Customer.County <> '' then begin
                    if FindCountyByNameOrDescription(Customer.County, County) then begin
                        if not County."Hide in Documents" then
                            BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + County.Description + ', ' + BIllCountry
                        else
                            BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + BIllCountry;
                    end else
                        BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + Customer.County + ', ' + BIllCountry;
                end else
                    BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + BIllCountry;

                Clear(Shippostcodecitycountrycounty_g);
                if "Ship-to County" <> '' then begin
                    if FindCountyByNameOrDescription("Ship-to County", County) then begin
                        if not County."Hide in Documents" then
                            Shippostcodecitycountrycounty_g := "Ship-to Post Code" + ', ' + "Ship-to City" + ', ' + County.Description + ', ' + ShipCountry
                        else
                            Shippostcodecitycountrycounty_g := "Ship-to Post Code" + ', ' + "Ship-to City" + ', ' + ShipCountry;
                    end else
                        Shippostcodecitycountrycounty_g := "Ship-to Post Code" + ', ' + "Ship-to City" + ', ' + "Ship-to County" + ', ' + ShipCountry;
                end else
                    Shippostcodecitycountrycounty_g := "Ship-to Post Code" + ', ' + "Ship-to City" + ', ' + ShipCountry;

                If "Ship-to Address" <> '' then
                    ShipToAddrTxt += "Ship-to Address" + Format(cr) + Format(lf);
                If "Ship-to Address 2" <> '' then
                    ShipToAddrTxt += "Ship-to Address 2" + Format(cr) + Format(lf);
                If "Ship-to Post Code" <> '' then
                    ShipToAddrTxt += "Ship-to Post Code" + ' ';
                If "Ship-to City" <> '' then
                    ShipToAddrTxt += "Ship-to City" + ', ';
                If "Ship-to County" <> '' then
                    if FindCountyByNameOrDescription("Ship-to County", County) then begin
                        if not County."Hide in Documents" then begin
                            If ShipCountry <> '' then
                                ShipToAddrTxt += County.Description + ', '
                            else
                                ShipToAddrTxt += County.Description;
                        end;
                    end else begin
                        If ShipCountry <> '' then
                            ShipToAddrTxt += "Ship-to County" + ', '
                        else
                            ShipToAddrTxt += "Ship-to County";
                    end;
                If ShipCountry <> '' then
                    ShipToAddrTxt += ShipCountry;

                "Sales Invoice Header".CalcFields("Amount Including VAT");
                TempCodeCheck.InitTextVariable();
                TempCodeCheck.FormatNoText(TempNoText, Abs("Sales Invoice Header"."Amount Including VAT"), "Currency Code");
                AmountInWordCal := TempNoText[1] + ' ' + TempNoText[2];
                if ("Currency Code" = '') then begin
                    AmountInWords := 'Malaysian Ringgit ' + AmountInWordCal;
                    Currency_Code := 'MYR';
                end
                else begin
                    AmountInWords := AmountInWordCal;
                    Currency_Code := "Currency Code";
                end;

                SalesInvoiceLine.SetRange("Document No.", "No.");
                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                SalesInvoiceLine.SetFilter("VAT %", '>%1', 0);
                if SalesInvoiceLine.FindFirst() then begin
                    DONo := SalesInvoiceLine."Shipment No.";
                    SalesTaxPercent := 'Sales Tax ' + SalesInvoiceLine."VAT %".ToText() + ' %';
                end else begin
                    SalesTaxPercent := 'Sales Tax ' + '0 %';
                    SalesInvoiceLine.SetRange("Document No.", "No.");
                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    SalesInvoiceLine.SetRange("VAT %");
                    if SalesInvoiceLine.FindFirst() then
                        DONo := SalesInvoiceLine."Shipment No.";
                end;

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
                    if BankAccount.Get(CompanyInfo."Alternative Bank 1") then begin
                        AlternateBankAccountNo1 := BankAccount."Bank Account No.";
                        AlternateBankName1 := BankAccount.Name;
                    end;
                    if BankAccount.Get(CompanyInfo."Alternative Bank 2") then begin
                        AlternateBankAccountNo2 := BankAccount."Bank Account No.";
                        AlternateBankName2 := BankAccount.Name;
                        AlternateBankAddress2 := BuildBank2Address(BankAccount);
                        AlternateBankSwiftCode2 := BankAccount."SWIFT Code";
                    end;
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
        layout
        {
            area(Content)
            {
                group("Sales Invoice Header")
                {
                    field(ScrapFilter; ScrapFilterValue)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Scrap';
                        ToolTip = 'Filter sales invoices by scrap status.';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.SetAutoCalcFields("Company Logo 1");
        CompanyInfo.SetAutoCalcFields("Company Logo 2");
        CompanyInfo.SetAutoCalcFields("Company Logo 3");


    end;

    var
        LineNo: Integer;
        SubTotal: Decimal;
        IsCharge: Boolean;
        Currency_Code: Text;
        SalesTaxPercent: Text;
        CompanyCounty: Text;
        Unit_Price: Decimal;
        DONo: Code[20];
        Packing: Decimal;
        AmountInWordCal: Text;
        AlternateBankName1: Text;
        AlternateBankAccountNo1: Text;
        AlternateBankName2: Text;
        AlternateBankAccountNo2: Text;
        AlternateBankAddress2: Text;
        AlternateBankSwiftCode2: Text;
        Variant_Code: Text;
        CompanyCountry: Text;
        Bill_to_Address: Text;
        EQRCodeStream: InStream;
        BIllpostcodecitycountrycounty: Text;
        EffectiveDate: Date;
        SSTExemption: Record "SST Exemption Details";
        ScrapFilterValue: Boolean;
        UOM: Record "Unit of Measure";

        Billtomobileno: Text;
        BilltoPhoneNo: Text;
        SalesTax: Decimal;
        ShipCountry: text;
        BIllCountry: Text;
        AmountInWords: text;
        NoText: array[2] of Text;
        CodeCheck: Codeunit 50200;
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";

        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        ADYEInvCompMSICSetup: Record "ADY e-Inv Comp MSIC Setup";
        CompanyMSICCode: Code[20];
        ReportTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        TotalShowAmount: Decimal;
        ShowAmount: Decimal;
        SalesPersonPurch: Record "Salesperson/Purchaser";
        Shippostcodecitycountrycounty_g: Text;
        BillToAddrTxt: Text[200];
        ShipToAddrTxt: Text[200];
        Shiptotxt: Text[100];
        cr: Char;
        lf: Char;



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

    local procedure GetNoofpltsLabel(): Text
    begin
        if ScrapFilterValue then
            exit('Quantity')
        else
            exit('No of Plts');
    end;

    local procedure GetQuantityPcsLabel(): Text
    begin
        if ScrapFilterValue then
            exit('UOM')
        else
            exit('Quantity Pcs');
    end;

    local procedure GetUnitPriceLabel(): Text
    begin
        if ScrapFilterValue then
            exit('Rate')
        else
            exit('Unit Price/Pcs');
    end;

    local procedure GetQuantityPcsValue(): Text
    begin
        if ScrapFilterValue then
            exit("Sales Invoice Line"."Unit of Measure Code")
        else
            exit(Format(Packing * "Sales Invoice Line"."Quantity"));
    end;


    local procedure GetUnitPriceValue(): Decimal
    begin
        if ScrapFilterValue then begin
            exit("Sales Invoice Line"."Unit Price");
        end else
            exit("Sales Invoice Line"."Price Per Piece");
    end;

    local procedure FindCountyByNameOrDescription(CountyValue: Text; var CountyRec: Record County): Boolean
    begin
        // First try to find by Name (primary key)
        if CountyRec.Get(CountyValue) then
            exit(true);

        // If not found by Name, try to find by Description
        CountyRec.Reset();
        CountyRec.SetRange(Description, CountyValue);
        if CountyRec.FindFirst() then
            exit(true);

        exit(false);
    end;

}