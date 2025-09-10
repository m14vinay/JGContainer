report 50211 "Sales Quotation Report"
{
    ApplicationArea = All;
    Caption = 'Sales Quotation Report';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/Reports/Layouts/SalesQuotation.rdlc';
    UsageCategory = ReportsAndAnalysis; 

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";

            // --- Company Info ---
            column(companyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyAddress) { }
            column(companyPhone; CompanyInfo."Phone No.") { }
            column(companyFax; CompanyInfo."Fax No.") { }
            column(companyEmail; CompanyInfo."E-mail") { }
            column(companySSTReg; CompanyInfo."VAT Registration No.") { }
            column(companyPicture; CompanyInfo.Picture) { }
            column(companyLogo1; CompanyInfo."Company Logo 1") { }
            column(companyLogo2; CompanyInfo."Company Logo 2") { }
            column(companyLogo3; CompanyInfo."Company Logo 3") { }
            column(Marketing_Email; CompanyInfo."Marketing Email") { }
            column(Marketing_Phone; CompanyInfo."Marketing Phone No") { }
            column(Registration_Number; CompanyInfo."Registration No.") { }
            column(CompanyPrintName; CompanyInfo."Print Name") { }
#pragma warning disable AL0432
            column(companyHomePage; CompanyInfo."Home Page") { }
#pragma warning restore AL0432

            // --- Bank Info ---
            column(Bank1_AccountNo; Bank1_AccountNo) { }
            column(Bank1_Name; Bank1_Name) { }
            column(Bank2_AccountNo; Bank2_AccountNo) { }
            column(Bank2_FullName; Bank2_FullName) { }
            column(Bank2_Swift; Bank2_Swift) { }
            column(Bank2_Name; Bank2_Name) { }
            column(Bank2_AddressFull; Bank2_AddressFull) { }

            // --- Sales Header fields ---
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; GetFullBillAddress()) { }
            column(GetBillPostCityCountReg; GetBillPostCityCountReg()) { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Ship_to_Phone_No_; "Ship-to Phone No.") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(GetFullShipAddress; GetFullShipAddress()) { }
            column(GetShipPostCityCountReg; GetShipPostCityCountReg()) { }
            column(SalesHead_Document_Date; "Document Date") { }
            column(SalesHead_No_; "No.") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Salesperson_Code; "Salesperson Code") { }
            column(Incoterms; Incoterms) { }
            column(Work_Description; WorkDescriptionTxt) { }

            column(AmountInWords; AmtInWords) { }

            column(TotalTransportCharge; TotalTransportCharge) { }

            // --- Related Customer ---
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Bill-to Customer No.");
                column(Customers_Mobile_Phone_No_; "Mobile Phone No.") { }
            }

            // --- Sales Lines (excluding Charge Items) ---
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."),
                "Document Type" = field("Document Type");
                column(No_; "No.") { }
                column(Description; Description) { }
                column(Amount; Amount) { }
                column(Amount__ACY_; "Amount (ACY)") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Amount_Including_VAT__ACY_; "Amount Including VAT (ACY)") { }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
                column(Quantity__Base_; "Quantity (Base)") { }
                column(Quantity; Quantity) { }
                column(Type; Type) { }
                column(Quantity_Pieces; "Quantity Pieces") { }
                column(Price_Per_Piece; "Price Per Piece") { }

                dataitem(Item; "Item")
                {
                    DataItemLink = "No." = field("No.");
                    column(Variant_code; "No.") { }
                    column(Pack_Size; "Pack Size") { }
                }

                trigger OnPreDataItem()
                begin
                    // Show all lines EXCEPT Charge (Item) type
                    // SetFilter(Type, '<>%1', "Sales Line".Type::"Charge (Item)");
                end;
            }

            // --- Transport Charges (only Charge Items) ---
            dataitem(TransportCharges; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."),
                "Document Type" = field("Document Type");

                // Fixed: Added missing Amount column
                column(Amount_Charge; Amount) { }
                column(Amount__ACY_Charge; "Amount (ACY)") { }
                column(Description_charge; Description) { }
                column(No_Charge; "No.") { }
                column(Type_Charge; Type) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Type, TransportCharges.Type::"Charge (Item)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GetCompanyInfo();
                AmountInWords();
                CalculateTransportCharges();
                LoadWorkDescription();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName) { }
            }
        }
        actions
        {
            area(Processing) { }
        }
    }

    trigger OnInitReport()
    begin
        GetCompanyInfo();
        SalesHeader.SetAutoCalcFields("Work Description");
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.SetAutoCalcFields("Company Logo 1");
        CompanyInfo.SetAutoCalcFields("Company Logo 2");
        CompanyInfo.SetAutoCalcFields("Company Logo 3");
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CountryRegion: Record "Country/Region";
        Bank: Record "Bank Account";

        Bank1_AccountNo: Text;
        Bank1_Name: Text;
        Bank2_AccountNo: Text;
        Bank2_FullName: Text;
        Bank2_Swift: Text;
        WorkDescriptionTxt: Text[2048];

        CheckCU: Codeunit 50200;
        TotalAmountLCY: Decimal;
        NoText: array[2] of Text[80];
        AmtInWords: Text[250];
        Bank2_Name: Text[100];
        Bank2_AddressFull: Text[250];
        TotalTransportCharge: Decimal;

    trigger OnPreReport()
    begin
        TotalAmountLCY := 0;
        TotalTransportCharge := 0;
    end;

    local procedure LoadWorkDescription()
    var
        InStr: InStream;
    begin
        Clear(WorkDescriptionTxt);
        SalesHeader.CalcFields("Work Description");
        if SalesHeader."Work Description".HasValue then begin
            SalesHeader."Work Description".CreateInStream(InStr, TEXTENCODING::UTF8);
            InStr.ReadText(WorkDescriptionTxt);
        end;
    end;


    local procedure GetCompanyInfo()
    var
        Country: Record "Country/Region";
    begin
        if not CompanyInfo.Get() then
            CompanyInfo.Init();

        // Build company address
        CompanyAddress := CompanyInfo.Address;
        if CompanyInfo."Address 2" <> '' then
            CompanyAddress += ', ' + CompanyInfo."Address 2";
        if CompanyInfo."Post Code" <> '' then
            CompanyAddress += ', ' + CompanyInfo."Post Code";
        if CompanyInfo.City <> '' then
            CompanyAddress += ', ' + CompanyInfo.City;
        if CompanyInfo."Country/Region Code" <> '' then
            if Country.Get(CompanyInfo."Country/Region Code") then
                CompanyAddress += ', ' + Country.Name;

        // Bank 1
        Clear(Bank1_AccountNo);
        Clear(Bank1_Name);
        if CompanyInfo."Alternative Bank 1" <> '' then
            if Bank.Get(CompanyInfo."Alternative Bank 1") then begin
                Bank1_AccountNo := Bank."Bank Account No.";
                Bank1_Name := Bank.Name;
            end;

        // Bank 2 - FIXED: Added missing assignments
        Clear(Bank2_AccountNo);
        Clear(Bank2_FullName);
        Clear(Bank2_Swift);
        Clear(Bank2_Name);
        Clear(Bank2_AddressFull);

        if CompanyInfo."Alternative Bank 2" <> '' then
            if Bank.Get(CompanyInfo."Alternative Bank 2") then begin
                Bank2_AccountNo := Bank."Bank Account No.";
                Bank2_Swift := Bank."SWIFT Code";
                Bank2_Name := Bank.Name;
                Bank2_FullName := BuildBank2FullName(Bank);  // This includes country
                Bank2_AddressFull := BuildBank2Address(Bank); // This also includes country now
            end;
    end;

    local procedure GetFullBillAddress(): Text
    begin
        exit(Format(SalesHeader."Bill-to Address" + ', ' + SalesHeader."Bill-to Address 2"));
    end;

    local procedure GetBillPostCityCountReg(): Text
    var
        CountryRegion: Record "Country/Region";
        CountryName: Text;
    begin
        if SalesHeader."Bill-to Country/Region Code" <> '' then
            if CountryRegion.Get(SalesHeader."Bill-to Country/Region Code") then
                CountryName := CountryRegion.Name;

        exit(Format(SalesHeader."Bill-to Post Code" + ', '
                  + SalesHeader."Bill-to City" + ', '
                  + SalesHeader."Bill-to County" + ', '
                  + CountryName));
    end;

    local procedure GetFullShipAddress(): Text
    begin
        exit(Format(SalesHeader."Ship-to Address" + ', ' + SalesHeader."Ship-to Address 2"));
    end;

    local procedure CalculateTransportCharges()
    var
        SalesLineTemp: Record "Sales Line";
    begin
        TotalTransportCharge := 0;
        SalesLineTemp.SetRange("Document No.", SalesHeader."No.");
        SalesLineTemp.SetRange("Document Type", SalesHeader."Document Type");
        SalesLineTemp.SetRange(Type, SalesLineTemp.Type::"Charge (Item)");

        if SalesLineTemp.FindSet() then
            repeat
                TotalTransportCharge += SalesLineTemp."Amount (ACY)";
            until SalesLineTemp.Next() = 0;
    end;

    local procedure GetShipPostCityCountReg(): Text
    var
        CountryRegion: Record "Country/Region";
        CountryName: Text;
    begin
        if SalesHeader."Ship-to Country/Region Code" <> '' then
            if CountryRegion.Get(SalesHeader."Ship-to Country/Region Code") then
                CountryName := CountryRegion.Name;

        exit(Format(SalesHeader."Ship-to Post Code" + ', '
                  + SalesHeader."Ship-to City" + ', '
                  + SalesHeader."Ship-to County" + ', '
                  + CountryName));
    end;

    local procedure BuildBank2FullName(Bank: Record "Bank Account"): Text
    var
        Country: Record "Country/Region";
        Addr: Text;
    begin
        // Addr := Bank.Name;

        if Bank.Address <> '' then
            Addr += ', ' + Bank.Address;
        if Bank."Address 2" <> '' then
            Addr += ', ' + Bank."Address 2";
        if Bank."Post Code" <> '' then
            Addr += ', ' + Bank."Post Code";
        if Bank.City <> '' then
            Addr += ', ' + Bank.City;
        if Bank.County <> '' then
            Addr += ', ' + Bank.County;
        if Bank."Country/Region Code" <> '' then
            if Country.Get(Bank."Country/Region Code") then
                Addr += ', ' + Country.Name;

        exit(Addr);
    end;

    local procedure AmountInWords()
    var
        SalesLineTemp: Record "Sales Line";
        CurrencyCodeToUse: Code[10];
        GLSetup: Record "General Ledger Setup";
    begin
        TotalAmountLCY := 0;
        SalesLineTemp.SetRange("Document No.", SalesHeader."No.");
        SalesLineTemp.SetRange("Document Type", SalesHeader."Document Type");
        // Exclude charge items from total amount calculation if needed
        // SalesLineTemp.SetFilter(Type, '<>%1', SalesLineTemp.Type::"Charge (Item)");

        if SalesLineTemp.FindSet() then
            repeat
                TotalAmountLCY += SalesLineTemp."Amount (ACY)";
            until SalesLineTemp.Next() = 0;

        CurrencyCodeToUse := SalesLineTemp."Currency Code";
        if CurrencyCodeToUse = '' then
            if GLSetup.Get() then
                CurrencyCodeToUse := GLSetup."LCY Code";

        CheckCU.InitTextVariable();
        CheckCU.FormatNoText2(NoText, Abs(TotalAmountLCY), CurrencyCodeToUse);
        AmtInWords := NoText[1] + ' ' + NoText[2];
    end;

    local procedure BuildBank2Address(Bank: Record "Bank Account"): Text
    var
        Country: Record "Country/Region";
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
            Addr += ', ' + Bank.County;

        if Bank."Country/Region Code" <> '' then begin
            if Country.Get(Bank."Country/Region Code") then
                Addr += ', ' + Country.Name
            else
                Addr += ', ' + Bank."Country/Region Code"; // fallback if record missing
        end;

        exit(Addr);
    end;

}