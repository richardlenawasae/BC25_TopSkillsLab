pageextension 50105 HumanResourcesSetupExt extends "Human Resources Setup"
{
    layout
    {
        addbefore(Numbering)
        {
            group(General)
            {
                field("HR E-Mail"; Rec."HR E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Employee Docs File Path"; Rec."Employee Docs File Path")
                {
                    ApplicationArea = All;
                }
                field("File Path";Rec."File Path")
                {
                    ApplicationArea = All;
                }
                field("Activate HR Audit Trail"; Rec."Activate HR Audit Trail")
                {
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Automatically Create Resource")
        {
            field("Leave Nos."; Rec."Leave Nos.")
            {
                ApplicationArea = All;
            }
            field("Leave Plan Nos."; Rec."Leave Plan Nos.")
            {
                ApplicationArea = All;
            }
            field("Leave Recall Nos."; Rec."Leave Recall Nos.")
            {
                ApplicationArea = All;
            }
            field("Job Application Nos."; Rec."Job Application Nos.")
            {
                ApplicationArea = All;
            }
            field("Performance Contract Nos."; Rec."Performance Contract Nos.")
            {
                ApplicationArea = All;
            }
            field("Job List Nos."; Rec."Job List Nos.")
            {
                ApplicationArea = All;
            }
            field("HR Audit Nos."; Rec."HR Audit Nos.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Numbering)
        {
            group("Leave Setup")
            {

            }
        }
    }
}