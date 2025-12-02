tableextension 50103 EmployeeRelativeExt extends "Employee Relative"
{
    fields
    {
        field(50100; "Relation Type"; Option)
        {
            OptionMembers = "Next of Kin",Dependant,"Emergency Contact";
            DataClassification = CustomerContent;
        }
        field(50101; "Id No"; code[30])
        {
            DataClassification = CustomerContent;
        }
        field(50102; "Allocation(%)"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(50103; Age; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(50104; Relationship; code[100])
        {
            DataClassification = CustomerContent;

        }
    }
    keys
    {
    }

}