report 50203 "Item Label Print"
{
    ApplicationArea = All;
    Caption = 'Item Label Print';
    UsageCategory = Tasks;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/Reports/Layouts/PrintLabelPrint.rdl';
    dataset
    {
        dataitem(ItemLabelPrint; "Item Label Print")
        {
            column(ItemNo; "Item No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Location; Location)
            {
            }
            column(BinCode; "Bin Code")
            {
            }
            column(UOM; UOM)
            {
            }
            column(BatchNo; "Batch No")
            {
            }
            column(GTINQRCode; GTINQRCode) { }
            column(CompInfoName; CompInfo.Name) { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(OutputNo; OutputNo) { }
                }
                trigger OnAfterGetRecord()
                begin
                    OutputNo := OutputNo + 1;
                    //ItemLabelBufferTemp := ItemLabelBufferTemp;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies);
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 0;

                end;
            }
            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeFontProvider: Interface "Barcode Font Provider";
                BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";

            begin
                // Declare the barcode provider using the barcode provider interface and enum
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;

                // Set data string source 
                if "Batch No" <> '' then
                    BarcodeString := "Batch No"
                else
                    BarcodeString := "Item No.";
                // Validate the input

                If BarcodeString <> '' then begin
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    // Encode the data string to the barcode font
                    GTINBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    GTINQRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
                    //BarcodeFontProvider2D.SetSize(BarcodeSymbology2D, Enum::"Barcode 2D Size"::Small);
                end
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
                    field(NoofCopies;
                    NoOfCopies)
                    {
                        ApplicationArea = Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the label to print.';
                    }
                }
            }
        }
    }
    var
        NoOfCopies: Integer;
        ItemQuantity: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        GTINBarCode: Text;
        GTINQRCode: Text;
        CompInfo: Record "Company Information";

    trigger OnInitReport()
    begin

        CompInfo.Get();
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
    end;
}
