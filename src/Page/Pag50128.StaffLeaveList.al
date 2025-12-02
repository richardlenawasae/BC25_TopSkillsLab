page 50128 "Staff Leave List"
{
    //CardPageID = " Staff Leave Application Card";
    PageType = List;
    SourceTable = "Leave Application";
    SourceTableView = WHERE(Status = FILTER('Open'));
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
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Employee No";Rec. "Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name";Rec. "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile No";Rec. "Mobile No.")
                {
                    ApplicationArea = All;
                }
                field(Branch;Rec. "Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
        UserSetup.GET(UserID);
        Rec.Filtergroup(2);
        Rec.Setrange("Employee No.", UserSetup."Employee No.");
        Rec.Filtergroup(0);
    end;

    var

        UserSetup: Record "User Setup";
}

