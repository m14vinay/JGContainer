tableextension 50226 "County Ext" extends County
{
    fields
    {
        field(50200; "Hide in Documents"; Boolean)
        {
            Caption = 'Hide in Documents';
            DataClassification = CustomerContent;
        }
    }
}
