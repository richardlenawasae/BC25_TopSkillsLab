pageextension 50103 EmployeeCardExt extends "Employee Card"
{
    layout
    {
        addafter("Employment Date")
        {
            field("Employee Type"; Rec."Employee Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee Type field.';
            }
        }
        addafter("Salespers./Purch. Code")
        {
            field("Supervisor ID"; Rec."Supervisor ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supervisor ID field.';
            }
            field("Supervisor Name"; Rec."Supervisor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supervisor Name field.';
            }
        }
        addafter("Privacy Blocked")
        {
            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Department Code field.';
            }
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Branch Code field.';
            }
        }
        addafter("Social Security No.")
        {
            field("PIN Number"; Rec."PIN Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PIN Number field.';
            }
            // field(NSSF; Rec.NSSF)
            // {
            //     ApplicationArea = All;
            //     Caption = 'SHA';
            // }
            field(NHIF; Rec.NHIF)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NHIF field.';
            }
            field("National ID"; Rec."National ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the National ID field.';
            }
            field("Passport Number"; Rec."Passport Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Passport Number field.';
            }
        }
        addafter("SWIFT Code")
        {
            field("Basic Pay"; Rec."Basic Pay")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Basic Pay field.';
            }
            field("Pay Tax"; Rec."Pay Tax")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pay Tax field.';
            }
            field("Taxable Income"; Rec."Taxable Income")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Taxable Income field.';
            }
            field(Pensonable; Rec.Pensonable)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pensonable field.';
            }
        }
        addafter(Payments)
        {
            group("Leave Information")
            {
                field("Leave Days"; Rec."Leave Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Days field.';
                }
                field("Leave Allowance sent"; Rec."Leave Allowance sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Allowance sent field.';
                }
            }
        }
        addafter("Birth Date")
        {
            field(Age; Rec.Age)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Age field.';
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Marital Status field.';
            }
        }
    }
}