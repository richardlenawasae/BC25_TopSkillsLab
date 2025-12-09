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
                    ToolTip = 'Specifies the value of the HR E-Mail field.';
                }
                field("Employee Docs File Path"; Rec."Employee Docs File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Docs File Path field.';
                }
                field("File Path"; Rec."File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Path field.';
                }
                field("Activate HR Audit Trail"; Rec."Activate HR Audit Trail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activate HR Audit Trail field.';
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Base Calendar Code field.';
                }
            }
        }
        addafter("Automatically Create Resource")
        {
            field("Leave Nos."; Rec."Leave Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Leave Nos. field.';
            }
            field("Leave Plan Nos."; Rec."Leave Plan Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Leave Plan Nos. field.';
            }
            field("Leave Recall Nos."; Rec."Leave Recall Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Leave Recall Nos. field.';
            }
            field("Job Application Nos."; Rec."Job Application Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job Application Nos. field.';
            }
            field("Performance Contract Nos."; Rec."Performance Contract Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Performance Contract Nos. field.';
            }
            field("Job List Nos."; Rec."Job List Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job List Nos. field.';
            }
            field("HR Audit Nos."; Rec."HR Audit Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HR Audit Nos. field.';
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