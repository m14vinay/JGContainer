report 50201 DeliveryOrderReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/DeliveryOrderReport_v1.rdl';
    Caption = 'Print Delivery Order';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Sales Shipment Header";

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
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
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoEmail; CompanyInfo."E-Mail")
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
            column(ReportTitle; ReportTitle)
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
            column(postcodecitycountrycounty; "Ship-to Post Code" + ', ' + "Ship-to City" + ', ' + "Ship-to County" + ', ' + Country)
            {

            }
            column(Ship_to_Phone_No_; "Ship-to Phone No.")
            {
            }
            column(Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(Document_Date; Format("Document Date"))
            {
            }
            column("selltocustomercode"; "Sell-to Customer No.")
            {

            }
            column(VehicleNo; "Vehicle No.")
            {
            }
            column(SystemModifiedBy; "User ID")
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
            column(ShowAmount; -ShowAmount)
            {
            }
            column(CurrencyCodeCurrencyCode; CurrencyCode("Currency Code"))
            {
            }
            column(AmountInWords; AmountInWords)
            {
            }
            column(TotalShowAmount; -TotalShowAmount)
            {
            }
            column(HeaderOrderNo; "Order No.")
            {

            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Shipment Header";
                column(Order_No_; "Order No.")
                {

                }
                column(Variant_Code; Variant_Code)
                {

                }
                column(PoNum; '')
                {

                }
                column(SoNum; '')
                {

                }
                column(NoofPlts; "Quantity")
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
                trigger OnAfterGetRecord()
                var
                    ItemCard: Record Item;
                    Packsize: Record "Pack Size";
                begin
                    if ItemCard.Get("No.") then begin
                        Variant_Code := ItemCard."Pack Size";   // Custom field from Item
                        if Packsize.Get(Variant_Code) then begin
                            Packing := Packsize."Qty Per Pack";
                        end
                        else
                            Clear(Packing);
                    end else
                        Clear(Variant_Code);  // 
                end;

                trigger OnPreDataItem()
                begin
                    "Sales Shipment Line".Setfilter(Quantity, '>%1', 0);
                end;
            }

            trigger OnAfterGetRecord()
            var
                CountryRegion: Record "Country/Region";
            begin
                if not Currency.Get("Currency Code") then
                    Currency.InitRoundingPrecision();
                TotalShowAmount := ShowAmount + TotalShowAmount;
                CodeCheck.InitTextVariable();
                CodeCheck.FormatNoText(NoText, Abs(TotalShowAmount), "Currency Code");
                AmountInWords := NoText[1] + ' ' + NoText[2];
                if CountryRegion.Get("Ship-to Country/Region Code") then
                    Country := CountryRegion.Name;
            end;

            trigger OnPreDataItem()
            var
                CountryRegion: Record "Country/Region";
                County: Record "County";
            begin
                CompanyInfo.Get();
                FormatAddr.Company(CompanyAddr, CompanyInfo);

                begin

                    if CountryRegion.Get(CompanyInfo."Country/Region Code") then
                        CompanyCountry := CountryRegion.Name;
                    if County.Get(CompanyInfo."County") then
                        CompanyCounty := County."Description";
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
        Packing: Decimal;
        Variant_Code: Text;
        CompanyCountry: Text;
        Country: text;
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