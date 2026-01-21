pageextension 50107 EmployeeListExt extends "Employee List"
{
    layout
    {
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        addafter("Search Name")
        {
            field(Gender; Rec.Gender)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Branch Code';
            }
            field("Supervisor Name"; Rec."Supervisor Name")
            {
                ApplicationArea = All;
            }
            field("Leave Days"; Rec."Leave Days")
            {
                ApplicationArea = All;
                Caption = 'Leave Days Balance';
            }
        }
    }
}