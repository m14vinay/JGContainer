page 50206 Salesperson
{
    APIGroup = 'apiGroup';
    APIPublisher = 'commit';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'salesperson';
    Editable = false;
    EntityName = 'salesperson';
    EntitySetName = 'salespersons';
    PageType = API;
    SourceTable = "Salesperson/Purchaser";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("salespersoncode"; Rec."Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(salespersonname; Rec.Name)
                {
                    Caption = 'Salesperson Name';
                }
            }
        }
    }
}
