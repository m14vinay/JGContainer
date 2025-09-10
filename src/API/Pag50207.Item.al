page 50207 Item
{
    APIGroup = 'apiGroup';
    APIPublisher = 'commit';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'item';
    Editable = false;
    EntityName = 'item';
    EntitySetName = 'items';
    PageType = API;
    SourceTable = Item;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemcode; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
            }
        }
    }
}
