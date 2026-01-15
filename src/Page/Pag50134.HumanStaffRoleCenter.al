
page 50134 "Human Staff Role Center"
{
    Caption = 'Human Resource Staff Role Center', Comment = 'Use same translation as ''Profile Description'' ';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part(Headline; "Headline Staff RC HR")
            {
                ApplicationArea = All;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Job Queue Tasks Activities"; "Job Queue Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }

            part(Control14; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control4; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            // part(Control21; "Report Inbox Part")
            // {
            //     AccessByPermission = TableData "Report Inbox" = R;
            //     ApplicationArea = Suite;
            // }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("New Leave Application")
            {
                RunPageMode = Create;
                Caption = 'New Leave Application';
                ToolTip = 'Click here to create a new leave application';
                Image = New;
                RunObject = page "Leave Application Card";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action(Employees)
            {
                Caption = 'My Staff Card';
                RunObject = Page "Staff List";
                ToolTip = 'Executes the My Staff Card action.';
            }
            action("Absence Registration")
            {
                Caption = 'Absence Registration';
                RunObject = Page "Absence Registration";
                ToolTip = 'Register an employee''s absence.';
            }
        }

        area(processing)
        {
            action(MyStaffCard)
            {
                Caption = 'My Staff Card';
                RunObject = Page "Staff List";
                ApplicationArea = All;
                ToolTip = 'Executes the My Staff Card action.';
            }
            action("Staff Leave List")
            {
                Caption = 'Staff Leave List';
                RunObject = Page "Staff Leave List";
                ApplicationArea = All;
                ToolTip = 'Executes the Staff Leave List action.';
            }
            action("Staff Leave Pending Approval")
            {
                Caption = 'Leave Pending Approval';
                RunObject = Page "Staff Leave Pending Approval";
                ApplicationArea = All;
                ToolTip = 'Executes the Leave Pending Approval action.';
            }
            action("Approved Leave Application")
            {
                Caption = 'My Approved Leaves';
                RunObject = Page "Approved Leave Application";
                ApplicationArea = All;
                ToolTip = 'Executes the My Approved Leaves action.';
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
        }
    }
}

