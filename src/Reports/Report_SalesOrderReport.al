report 50208 SalesOrderReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/SalesOrderReport_v1.rdl';
    Caption = 'Sales Order';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Sales Header";

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
            column(Incoterm; "Incoterms")
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
                column(ItemCode; "Sales Line"."Item Reference No.")
                {

                }
                column(Noofplts; "Sales Line"."Quantity")
                {

                }
                column(UnitPrice; "Sales Line"."Price Per Piece")
                {

                }
                column(Packing; Packing)
                {

                }
                column(Quantity; "Sales Line"."Quantity Pieces")
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
                    SalesTax := "Sales Line"."Amount Including VAT" - "Sales Line"."Line Amount";
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
                        SubTotal += "Sales Line"."Line Amount";
                    end;
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
                // End - Added by NF on 22/05/2024 to calculate Total Amount including Sales Tax (For multi select)

                Clear(EffectiveDate);
                Clear(SalesTaxPercent);
                If SalesPersonPurch.Get("Salesperson Code") then;
                if not Currency.Get("Currency Code") then
                    Currency.InitRoundingPrecision();
                if CountryRegion.Get("Ship-to Country/Region Code") then
                    ShipCountry := CountryRegion.Name;
                Customer.Get("Bill-to Customer No.");
                Bill_to_Address := Customer.Address;
                BilltoPhoneNo := Customer."Phone No.";
                Billtomobileno := Customer."Mobile Phone No.";
                BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + Customer.County + ', ' + BIllCountry;
                if CountryRegion.Get(Customer."Country/Region Code") then
                    BIllCountry := CountryRegion.Name;
                BIllpostcodecitycountrycounty := Customer."Post Code" + ', ' + Customer.City + ', ' + Customer.County + ', ' + BIllCountry;
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
                end;

                GLSetup.Get();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
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
        SalesPerson: Text[100];
        BIllpostcodecitycountrycounty: Text;
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
        EffectiveDate: Date;
        SSTExemption: Record "SST Exemption Details";
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        SalesPersonPurch: Record "Salesperson/Purchaser";
        ReportTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        TotalShowAmount: Decimal;
        ShowAmount: Decimal;

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