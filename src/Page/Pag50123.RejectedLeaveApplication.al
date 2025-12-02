page 50123 "Rejected  Leave Application"
{
    CardPageID = "Leave Application Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Leave Application";
    SourceTableView = WHERE(Status = FILTER('Rejected'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date";  Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Employee No";  Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec. "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec. "Mobile No.")
                {
                    ApplicationArea = All;
                }
                field(Branch;  Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Job Title";  Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec. "Employment Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec. "User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec. Status)
                {
                    ApplicationArea = All;
                }
                field("Start Date";  Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date";  Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;
}

