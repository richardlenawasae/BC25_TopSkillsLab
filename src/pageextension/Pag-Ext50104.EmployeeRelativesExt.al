pageextension 50104 EmployeeRelativesExt extends "Employee Relatives"
{
    layout
    {
        addafter("Phone No.")
        {
            field("Relation Type";Rec."Relation Type")
            {
                ApplicationArea = All;
            }
            field("Id No";Rec."Id No")
            {
                ApplicationArea = All;
            }
            field("Allocation(%)";Rec."Allocation(%)")
            {
                ApplicationArea = All;
            }
            field(Age;Rec.Age)
            {
                ApplicationArea = All;
            }
            // field(Relationship;Rec.Relationship)
            // {
            //     ApplicationArea = All;
            // }
        }
    }
}