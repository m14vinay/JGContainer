report 50200 CommercialInvoiceReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/CommercialInvoiceReport_v1.rdl';
    Caption = 'Commercial Invoice';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Sales Header";

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
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
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
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
            column(PrintName; CompanyInfo."Print Name")
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
            column(DueDate; Format("Due Date"))
            {
            }
            column(PaymentTerms; "Payment Terms Code")
            {
            }
            column(CustomerCode; "Sell-to Customer No.")
            {
            }
            column(SalesPerson; "Salesperson Code")
            {
            }
            column(Document_Date; Format("Document Date"))
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
            column(Shipment_From; "Shipment From")
            {

            }
            column(Shipment_To; "Shipment To")
            {

            }
            column(Measurement; UnitVolume)
            {

            }
            column(FeederVesselName; "Vessel")
            {

            }
            column(MotherVesselName; "Vessel")
            {

            }
            column(NettWeight; NettWeight)
            {

            }
            column(GrossWeight; GrossWeight)
            {

            }
            column(HSCode; TariffNumber)
            {

            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = where(Type = const(Item));
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
                column(UnitPrice; "Sales Line"."Price Per Piece")
                {

                }
                column(Packing; Packing)
                {

                }
                column(Quantity; "Quantity")
                {

                }
                column(No_; "Shortcut Dimension 2 Code")
                {

                }
                column(Description; "Description")
                {

                }
                column(Amount; "Line Amount")
                {

                }
                trigger OnAfterGetRecord()
                var
                    ItemCard: Record Item;
                    Packsize: Record "Pack Size";
                    SalesPrice: Record "Sales Price";
                begin
                    NettWeight += "Net Weight";
                    GrossWeight += "Gross Weight";
                    UnitVolume += "Unit Volume";
                    ShowAmount := "Line Amount";
                    SalesTax := "Amount Including VAT" - "Line Amount";
                    TotalShowAmount := ShowAmount + TotalShowAmount + SalesTax;
                    if ItemCard.Get("No.") then begin
                        Variant_Code := ItemCard."Pack Size";   // Custom field from Item
                        TariffNumber := ItemCard."Tariff No.";
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
                        Clear(Variant_Code);  //                

                end;
            }

            trigger OnAfterGetRecord()
            var
                CountryRegion: Record "Country/Region";
                Customer: Record "Customer";
                SalesInvoiceLine: Record "Sales Invoice Line";
            begin
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
                "Sales Header".CalcFields("Amount Including VAT");
                CodeCheck.InitTextVariable();
                CodeCheck.FormatNoText(NoText, Abs("Sales Header"."Amount Including VAT"), "Currency Code");
                AmountInWordCal := NoText[1] + ' ' + NoText[2];
                if ("Currency Code" = '') then begin
                    AmountInWords := 'Malaysian Ringgit ' + AmountInWordCal;
                end;
                SalesInvoiceLine.SetRange("Document No.", "No.");
                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                if SalesInvoiceLine.FindFirst() then begin
                    DONo := SalesInvoiceLine."Shipment No.";
                end;
            end;

            trigger OnPreDataItem()
            var
                CountryRegion: Record "Country/Region";
                BankAccount: Record "Bank Account";
                County: Record "County";
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
                        AlternateBankAddress2 := BankAccount."Address";
                        AlternateBankSwiftCode2 := BankAccount."SWIFT Code";
                    end;
                end;
                GLSetup.Get();
            end;
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
        CompanyCounty: Text;
        UnitVolume: Decimal;
        TariffNumber: Code[20];
        NettWeight: Decimal;
        GrossWeight: Decimal;
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

        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
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

}