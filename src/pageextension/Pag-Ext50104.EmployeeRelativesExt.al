pageextension 50104 EmployeeRelativesExt extends "Employee Relatives"
{
    layout
    {
        addafter("Phone No.")
        {
            field("Relation Type"; Rec."Relation Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Relation Type field.';
            }
            field("Id No"; Rec."Id No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Id No field.';
            }
            field("Allocation(%)"; Rec."Allocation(%)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allocation(%) field.';
            }
            field(Age; Rec.Age)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Age field.';
            }
            // field(Relationship;Rec.Relationship)
            // {
            //     ApplicationArea = All;
            // }
        }
    }
}