report 50211 "Sales Quotation Report"
{
    ApplicationArea = All;
    Caption = 'Sales Quotation Report';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/Reports/Layouts/SalesQuotation.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            // Modify
            // --- Company Info ---
            column(companyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompInfoBankName; CompanyInfo."Bank Name") { }
            column(BankAccountNo; CompanyInfo."Bank Account No.") { }
            column(companyPhone; CompanyInfo."Phone No.") { }
            column(companyFax; CompanyInfo."Fax No.") { }
            column(companyEmail; CompanyInfo."E-mail") { }
            column(companySSTReg; CompanyInfo."ADY E-INV SST Reg No.") { }
            column(ShipToAddrTxt; ShipToAddrTxt) { }
            column(companyPicture; CompanyInfo.Picture) { }
            column(CompanyTIN; CompanyInfo."ADY E-INV TIN No.") { }
            column(CompanyMSICCode; CompanyMSICCode) { }
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
            column(SalesHead_Document_Date; Format("Document Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(SalesHead_No_; "No.") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Salesperson_Code; SalesPersonPurch.Name) { }
            column(Incoterms; "ADY E-INV Incoterms Code") { }
            column(Work_Description; WorkDescriptionTxt) { }

            column(AmountInWords; AmtInWords) { }

            column(TotalTransportCharge; TotalTransportCharge) { }
            column(SalesTaxPercent; SalesTaxPercent)
            {

            }
            column(Currency_Code; Currency_Code) { }

            // --- Related Customer ---
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Bill-to Customer No.");
                column(Customers_Mobile_Phone_No_; "Mobile Phone No.") { }
                column(BillToAddrTxt; BillToAddrTxt) { }
                trigger OnAfterGetRecord()
                begin
                    Clear(BillToAddrTxt);
                    cr := 13;
                    lf := 10;
                    If Customer.Address <> '' then
                        BillToAddrTxt += Customer.Address + Format(cr) + Format(lf);
                    If Customer."Address 2" <> '' then
                        BillToAddrTxt += Customer."Address 2" + Format(cr) + Format(lf);
                    If Customer."Post Code" <> '' then
                        BillToAddrTxt += Customer."Post Code" + ' ';
                    If Customer.City <> '' then
                        BillToAddrTxt += Customer.City + ', ';
                    Clear(CountryName);
                    if CountryRegion.Get(Customer."Country/Region Code") then
                        CountryName := CountryRegion.Name;
                    If Customer.County <> '' then
                        if County1.Get(Customer.County) then begin
                            If CountryName <> '' then
                                BillToAddrTxt += County1.Description + ', '
                            else
                                BillToAddrTxt += County1.Description;
                        end else begin
                            If CountryName <> '' then
                                BillToAddrTxt += Customer.County + ', '
                            else
                                BillToAddrTxt += Customer.County;
                        end;
                    If CountryName <> '' then
                        BillToAddrTxt += CountryName;
                end;
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
                column(QtyPerPack; "Qty Per Pack") { }
                column(IsCharge; IsCharge)
                {

                }
                column(SubTotal; SubTotal)
                {

                }
                column(LineNo; LineNo)
                {

                }
                dataitem(Item; "Item")
                {
                    DataItemLink = "No." = field("No.");
                    column(Variant_code; "No.") { }
                    column(Pack_Size; "Pack Size") { }
                }


                trigger OnAfterGetRecord()
                var
                    ItemCard: Record "Item";
                begin
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
                        SubTotal += Amount;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    "Sales Line".SetFilter(Type, '<>%1', "Sales Line".Type::" ");
                end;
            }

            trigger OnAfterGetRecord()
            var
                Salesline: Record "Sales Line";
                VATPostingSetup: Record "VAT Posting Setup";
                TempCheckCU: Codeunit 50200;
                TempNoText: array[2] of Text[80];
            begin
                GetCompanyInfo();
                Clear("Amount Including VAT");
                Clear(SubTotal);
                Clear(LineNo);
                Clear(Amount);
                Clear(AmtInWords);
                Clear(TempNoText);
                Clear(ShipToAddrTxt);
                cr := 13;
                lf := 10;
                //CalculateTransportCharges();
                LoadWorkDescription();
                SalesHeader.CalcFields("Amount Including VAT");
                TempCheckCU.InitTextVariable();
                TempCheckCU.FormatNoText(TempNoText, Abs(SalesHeader."Amount Including VAT"), SalesHeader."Currency Code");
                AmtInWords := TempNoText[1] + ' ' + TempNoText[2];
                if ("Currency Code" = '') then begin
                    Currency_Code := 'MYR';
                    AmtInWords := 'Malaysian Ringgit ' + AmtInWords;
                end
                else begin
                    Currency_Code := "Currency Code";
                end;
                Salesline.SetRange("Document No.", "No.");
                Salesline.SetRange(Type, Salesline.Type::Item);
                SalesLine.SetFilter("VAT %", '>%1', 0);
                if Salesline.FindFirst() then
                    SalesTaxPercent := 'Sales Tax ' + Salesline."VAT %".ToText() + ' %'
                Else
                    SalesTaxPercent := 'Sales Tax ' + '0 %';
                If SalesPersonPurch.Get("Salesperson Code") then;

                If "Ship-to Address" <> '' then
                    ShipToAddrTxt += "Ship-to Address" + Format(cr) + Format(lf);
                If "Ship-to Address 2" <> '' then
                    ShipToAddrTxt += "Ship-to Address 2" + Format(cr) + Format(lf);
                If "Ship-to Post Code" <> '' then
                    ShipToAddrTxt += "Ship-to Post Code" + ' ';
                If "Ship-to City" <> '' then
                    ShipToAddrTxt += "Ship-to City" + ', ';
                Clear(CountryName);
                if CountryRegion.Get("Ship-to Country/Region Code") then
                    CountryName := CountryRegion.Name;
                If "Ship-to County" <> '' then
                    if County1.Get("Ship-to County") then begin
                        If CountryName <> '' then
                            ShipToAddrTxt += County1.Description + ', '
                        else
                            ShipToAddrTxt += County1.Description;
                    end else begin
                        If CountryName <> '' then
                            ShipToAddrTxt += "Ship-to County" + ', '
                        else
                            ShipToAddrTxt += "Ship-to County";
                    end;
                If CountryName <> '' then
                    ShipToAddrTxt += CountryName;


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
        LineNo: Integer;
        SubTotal: Decimal;
        IsCharge: Boolean;
        Currency_Code: Text;
        SalesTaxPercent: Text;
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CountryRegion: Record "Country/Region";
        Bank: Record "Bank Account";
        SalesPersonPurch: Record "Salesperson/Purchaser";
        BillCustomer: Record Customer;
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
        BillToAddrTxt: Text[200];
        ShipToAddrTxt: Text[200];
        Shiptotxt: Text[100];
        cr: Char;
        lf: Char;
        CountryName: Text;
        County1: Record County;
        CountyName: Text;
        ADYEInvCompMSICSetup: Record "ADY e-Inv Comp MSIC Setup";
        CompanyMSICCode: Code[20];

    trigger OnPreReport()
    begin
        TotalAmountLCY := 0;
        TotalTransportCharge := 0;
        Clear(NoText);
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
        County: Record County;
        CountyName: Text;

    begin
        if not CompanyInfo.Get() then
            CompanyInfo.Init();

        // Lookup MSIC Code from ADY e-Inv Comp MSIC Setup
        Clear(CompanyMSICCode);
        if ADYEInvCompMSICSetup.FindFirst() then
            if ADYEInvCompMSICSetup."ADY Name" = CompanyInfo.Name then
                CompanyMSICCode := ADYEInvCompMSICSetup."ADY E-INV MSIC CODE";

        // Build company address
        CompanyAddress := CompanyInfo.Address;
        if CompanyInfo."Address 2" <> '' then
            CompanyAddress += ', ' + CompanyInfo."Address 2";
        if CompanyInfo."Post Code" <> '' then
            CompanyAddress += ', ' + CompanyInfo."Post Code";
        if CompanyInfo.City <> '' then
            CompanyAddress += ' ' + CompanyInfo.City;
        if (CompanyInfo.County <> '') then
            if County.Get(CompanyInfo.County) then
                CountyName := County.Description;
        CompanyAddress += ', ' + CountyName;
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

        // Bank 2 
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
    // c
    local procedure GetBillPostCityCountReg(): Text
    var
        CountryRegion: Record "Country/Region";
        CountryName: Text;
        County: Record County;
        CountyName: Text;

    begin
        if SalesHeader."Bill-to Country/Region Code" <> '' then
            if CountryRegion.Get(SalesHeader."Bill-to Country/Region Code") then
                CountryName := CountryRegion.Name;

        if (CompanyInfo.County <> '') then
            if County.Get(CompanyInfo.County) then
                CountyName := County.Description;

        exit(Format(SalesHeader."Bill-to Post Code" + ', '
                  + SalesHeader."Bill-to City" + ', '
                  + CountyName + ', '
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
        County: Record County;
        CountyName: Text;

    begin
        if SalesHeader."Ship-to Country/Region Code" <> '' then
            if CountryRegion.Get(SalesHeader."Ship-to Country/Region Code") then
                CountryName := CountryRegion.Name;

        if (CompanyInfo.County <> '') then
            if County.Get(CompanyInfo.County) then
                CountyName := County.Description;

        exit(Format(SalesHeader."Ship-to Post Code" + ', '
                  + SalesHeader."Ship-to City" + ', '
                  + CountyName + ', '
                  + CountryName));
    end;

    local procedure BuildBank2FullName(Bank: Record "Bank Account"): Text
    var
        Country: Record "Country/Region";
        County: Record County;
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
            If County.Get(Bank.County) then
                Addr += ', ' + County.Description;
        if Bank."Country/Region Code" <> '' then
            if Country.Get(Bank."Country/Region Code") then
                Addr += ', ' + Country.Name;

        exit(Addr);
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