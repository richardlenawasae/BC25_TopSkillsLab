pageextension 50103 EmployeeCardExt extends "Employee Card"
{
    layout
    {
        addafter("Employment Date")
        {
            field("Employee Type"; Rec."Employee Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salespers./Purch. Code")
        {
            field("Supervisor ID"; Rec."Supervisor ID")
            {
                ApplicationArea = All;
            }
            field("Supervisor Name"; Rec."Supervisor Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Privacy Blocked")
        {
            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = All;
            }
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Social Security No.")
        {
            field("PIN Number"; Rec."PIN Number")
            {
                ApplicationArea = All;
            }
            // field(NSSF; Rec.NSSF)
            // {
            //     ApplicationArea = All;
            //     Caption = 'SHA';
            // }
            field(NHIF; Rec.NHIF)
            {
                ApplicationArea = All;
            }
            field("National ID"; Rec."National ID")
            {
                ApplicationArea = All;
            }
            field("Passport Number"; Rec."Passport Number")
            {
                ApplicationArea = All;
            }
        }
        addafter("SWIFT Code")
        {
            field("Basic Pay"; Rec."Basic Pay")
            {
                ApplicationArea = All;
            }
            field("Pay Tax"; Rec."Pay Tax")
            {
                ApplicationArea = All;
            }
            field("Taxable Income"; Rec."Taxable Income")
            {
                ApplicationArea = All;
            }
            field(Pensonable; Rec.Pensonable)
            {
                ApplicationArea = All;
            }
        }
        addafter(Payments)
        {
            group("Leave Information")
            {
                field("Leave Days"; Rec."Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Leave Allowance sent"; Rec."Leave Allowance sent")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Birth Date")
        {
            field(Age; Rec.Age)
            {
                ApplicationArea = All;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = All;
            }
        }
    }
}