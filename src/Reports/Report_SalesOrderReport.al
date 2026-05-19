report 50208 SalesOrderReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/SalesOrderReport_v1.rdl';
    Caption = 'Sales Order';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Sales Header";
    EnableHyperlinks = True;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
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
            column(CompanyTIN; CompanyInfo."ADY E-INV TIN No.")
            {
            }
            column(CompanyMSICCode; CompanyMSICCode)
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
            column(ReportTitle; ReportTitle)
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
            column(BilltoPhoneNo; BilltoPhoneNo)
            {
            }
            column(Billtomobileno; Billtomobileno)
            {
            }
            column(BillToAddrTxt; BillToAddrTxt)
            {
            }
            column(BIllpostcodecitycountrycounty; BIllpostcodecitycountrycounty)
            {

            }
            column(ShipToAddrTxt; ShipToAddrTxt) { }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Shippostcodecitycountrycounty; ShippostcodecitycountrycountyTxt)
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
            column(Currency; "Currency Code") { }
            column(SSTExemption; "SST Exemption registration No.") { }
            column(EffectiveDate; Format(EffectiveDate, 0, '<day,2>.<month,2>.<year4>')) { }
            column(SalesTaxPercent; SalesTaxPercent) { }
            column(Currency_Code; Currency_Code) { }
            column(OwnCollectTxt; OwnCollectTxt) { }
            column(AmountIncldingVAT; "Sales Header"."Amount Including VAT") { }
            column(TermsandConditions; SalesReceivablesSetup."Terms and Conditions Sales") { }
            column(TermsQRCode; TermsQRCode) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Header";
                column(Type; "Sales Line"."Type")
                {
                }
                column(Variant_Code; Variant_Code)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(ItemCode; "Sales Line"."Item Reference No.")
                {
                }
                column(Noofplts; Noofplts)
                {
                }
                column(NoofpltsLabel; GetNoofpltsLabel())
                {
                }
                column(UnitPrice; "Sales Line"."Price Per Piece")
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
                column(Quantity; "Sales Line"."Quantity Pieces")
                {
                }
                column(QuantityPcsLabel; GetQuantityPcsLabel())
                {
                }
                column(QuantityPcsValue; GetQuantityPcsValue())
                {
                }
                column(No_; "Sales Line"."Shortcut Dimension 2 Code")
                {

                }
                column(Description; "Sales Line"."Description")
                {

                }
                column(Amount; "Sales Line"."Line Amount")
                {

                }

                column(AmountWithoutVAT; "Sales Line"."Amount")
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
                begin

                    ShowAmount := "Sales Line"."Line Amount";
                    SalesTax := "Sales Line"."Amount Including VAT" - "Sales Line"."Amount";
                    TotalShowAmount := ShowAmount + TotalShowAmount + SalesTax;
                    if "Sales Line".Type = "Sales Line".Type::Item then begin
                        if ItemCard.Get("No.") then begin
                            Variant_Code := ItemCard."Pack Size";
                            if Packsize.Get(Variant_Code) then begin
                                Packing := Packsize."Qty Per Pack";
                            end
                            else
                                Clear(Packing);
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
                        SubTotal += "Sales Line"."Amount";
                    end;
                    If "Unit of Measure Code" = 'PCS' then
                        Noofplts := 0
                    else
                        Noofplts := Quantity;
                end;

                trigger OnPreDataItem()
                begin
                    "Sales Line".SetFilter(Type, '<>%1', "Sales Line".Type::" ");
                end;
            }


            trigger OnAfterGetRecord()
            var
                CountryRegion: Record "Country/Region";
                Customer: Record "Customer";
                VATPostingSetup: Record "VAT Posting Setup";
                salesline: Record "Sales Line";
            begin

                // Start - Added by NF on 22/05/2024 to calculate Total Amount including Sales Tax (For multi select)
                Clear(TotalShowAmount);
                Clear(SubTotal);
                Clear(LineNo);
                Clear(ShowAmount);
                Clear(SalesTax);
                Clear(ShipToAddrTxt);
                Clear(BillToAddrTxt);
                Clear(ShipCountry);
                Clear(BIllCountry);
                Clear(ShippostcodecitycountrycountyTxt);
                cr := 13;
                lf := 10;
                // End - Added by NF on 22/05/2024 to calculate Total Amount including Sales Tax (For multi select)

                Clear(EffectiveDate);
                Clear(SalesTaxPercent);

                If SalesPersonPurch.Get("Salesperson Code") then;
                if not Currency.Get("Currency Code") then
                    Currency.InitRoundingPrecision();
                if CountryRegion.Get("Ship-to Country/Region Code") then
                    ShipCountry := CountryRegion.Name;
                If ShipmentMethod.Get("Shipment Method Code") then
                    If ShipmentMethod.Code = 'OWN COLLEC' then
                        OwnCollectTxt := ShipmentMethod.Description;
                if "Sell-to Customer No." <> '' then begin
                    if Customer.Get("Bill-to Customer No.") then begin
                        If Customer.Address <> '' then
                            BillToAddrTxt += Customer.Address + Format(cr) + Format(lf);
                        If Customer."Address 2" <> '' then
                            BillToAddrTxt += Customer."Address 2" + Format(cr) + Format(lf);
                        If Customer."Post Code" <> '' then
                            BillToAddrTxt += Customer."Post Code" + ' ';
                        If Customer.City <> '' then
                            BillToAddrTxt += Customer.City + ', ';


                        BilltoPhoneNo := Customer."Phone No.";
                        Billtomobileno := Customer."Mobile Phone No.";
                        if CountryRegion.Get(Customer."Country/Region Code") then
                            BIllCountry := CountryRegion.Name;
                        // Build BIllpostcodecitycountrycounty with Hide in Documents check
                        BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City;
                        if Customer.County <> '' then
                            if FindCountyByNameOrDescription(Customer.County, County) then begin
                                if not County."Hide in Documents" then
                                    BIllpostcodecitycountrycounty += ', ' + County.Description;
                            end else
                                BIllpostcodecitycountrycounty += ', ' + Customer.County;
                        if BIllCountry <> '' then
                            BIllpostcodecitycountrycounty += ', ' + BIllCountry;

                        If Customer.County <> '' then
                            if FindCountyByNameOrDescription(Customer.County, County) then begin
                                if not County."Hide in Documents" then begin
                                    If BIllCountry <> '' then
                                        BillToAddrTxt += County.Description + ', '
                                    else
                                        BillToAddrTxt += County.Description;
                                end;
                            end else begin
                                If BIllCountry <> '' then
                                    BillToAddrTxt += Customer.County + ', '
                                else
                                    BillToAddrTxt += Customer.County;
                            end;
                        If BIllCountry <> '' then
                            BillToAddrTxt += BIllCountry;
                    end else begin
                        Clear(Bill_to_Address);
                        Clear(BilltoPhoneNo);
                        Clear(Billtomobileno);
                        Clear(BIllpostcodecitycountrycounty);
                        Clear(BIllCountry);
                    end;

                end;

                If "Ship-to Address" <> '' then
                    ShipToAddrTxt += "Ship-to Address" + Format(cr) + Format(lf);
                If "Ship-to Address 2" <> '' then
                    ShipToAddrTxt += "Ship-to Address 2" + Format(cr) + Format(lf);
                If "Ship-to Post Code" <> '' then
                    ShipToAddrTxt += "Ship-to Post Code" + ' ';
                If "Ship-to City" <> '' then
                    ShipToAddrTxt += "Ship-to City" + ', ';


                If "Ship-to County" <> '' then
                    If FindCountyByNameOrDescription("Ship-to County", County) then begin
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

                // Build ShippostcodecitycountrycountyTxt with Hide in Documents check
                ShippostcodecitycountrycountyTxt := "Ship-to Post Code" + ', ' + "Ship-to City";
                if "Ship-to County" <> '' then
                    if FindCountyByNameOrDescription("Ship-to County", County) then begin
                        if not County."Hide in Documents" then
                            ShippostcodecitycountrycountyTxt += ', ' + County.Description;
                    end else
                        ShippostcodecitycountrycountyTxt += ', ' + "Ship-to County";
                if ShipCountry <> '' then
                    ShippostcodecitycountrycountyTxt += ', ' + ShipCountry;

                "Sales Header".CalcFields("Amount Including VAT");
                CodeCheck.InitTextVariable();
                CodeCheck.FormatNoText(NoText, Abs("Sales Header"."Amount Including VAT"), "Currency Code");
                AmountInWordCal := NoText[1] + ' ' + NoText[2];
                if ("Currency Code" = '') then begin
                    AmountInWords := 'Malaysian Ringgit ' + AmountInWordCal;
                    Currency_Code := 'MYR';
                end
                else begin
                    AmountInWords := AmountInWordCal;
                    Currency_Code := "Currency Code";
                end;
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", "No.");
                SalesLine.SetFilter("VAT %", '>%1', 0);
                if SalesLine.FindFirst() then
                    SalesTaxPercent := 'Sales Tax ' + SalesLine."VAT %".ToText() + ' %'
                Else
                    SalesTaxPercent := 'Sales Tax ' + '0 %';


                SSTExemption.Reset();
                SSTExemption.SetRange("Customer No.", "Sell-to Customer No.");
                SSTExemption.SetRange("SST Exemption Registration No.", "SST Exemption Registration No.");
                If SSTExemption.FindFirst() then
                    EffectiveDate := SSTExemption."Effective Date";

                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                TermsString := Format(SalesReceivablesSetup."Terms and Conditions Sales");
                TermsString := DelChr(TermsString, '=', ' ');
                BarcodeFontProvider.ValidateInput(TermsString, BarcodeSymbology);
                TermsQRCode := BarcodeFontProvider2D.EncodeFont(TermsString, BarcodeSymbology2D);

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
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
                group("Sales Header")
                {
                    field(ScrapFilter; ScrapFilterValue)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Scrap';
                        ToolTip = 'Filter sales orders by scrap status.';
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
        BarcodeSymbology := Enum::"Barcode Symbology"::Code128;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
        SalesReceivablesSetup.Get();
    end;

    var
        LineNo: Integer;
        SubTotal: Decimal;
        IsCharge: Boolean;
        Currency_Code: Text;
        SalesTaxPercent: Text;
        CompanyCounty: Text;
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
        County: Record County;
        SalesPerson: Text[100];
        BIllpostcodecitycountrycounty: Text;
        Billtomobileno: Text;
        BilltoPhoneNo: Text;
        SalesTax: Decimal;
        ShipCountry: text;
        ShippostcodecitycountrycountyTxt: Text;
        BIllCountry: Text;
        AmountInWords: text;
        NoText: array[2] of Text;
        CodeCheck: Codeunit 50200;
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        EffectiveDate: Date;
        SSTExemption: Record "SST Exemption Details";
        ScrapFilterValue: Boolean;
        UOM: Record "Unit of Measure";
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        SalesPersonPurch: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ADYEInvCompMSICSetup: Record "ADY e-Inv Comp MSIC Setup";
        CompanyMSICCode: Code[20];
        OwnCollectTxt: Text[100];
        ReportTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        BillToAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        BillToAddrTxt: Text[200];
        ShipToAddrTxt: Text[200];
        Shiptotxt: Text[100];
        TotalShowAmount: Decimal;
        ShowAmount: Decimal;
        cr: Char;
        lf: Char;
        Noofplts: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        TermsString: Text[150];
        TermsQRCode: Text[500];
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        BarcodeFontProvider: Interface "Barcode Font Provider";
        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";

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
            exit("Sales Line"."Unit of Measure Code")
        else
            If "Sales Line"."Unit of Measure Code" = 'PCS' then
                exit(Format("Sales Line"."Quantity"))
            else
                exit(Format(Packing * "Sales Line"."Quantity"));
    end;

    local procedure GetUnitPriceValue(): Decimal
    begin
        if (ScrapFilterValue) or ("Sales Line"."Unit of Measure Code" = 'PCS') then begin
            exit("Sales Line"."Unit Price");
        end else
            exit("Sales Line"."Price Per Piece");
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