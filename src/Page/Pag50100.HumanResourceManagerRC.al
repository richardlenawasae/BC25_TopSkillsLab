page 50100 "Human Resource Manager RC"
{
    ApplicationArea = All;
    Caption = 'Human Resource Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Headline; "Headline RC HR")
            {
                ApplicationArea = All;
            }
            part(Activities; HRCuePage)
            {
                ApplicationArea = All;
            }
            // part("Report Inbox Part"; "Report Inbox Part")
            // {
            //     ApplicationArea = All;
            // }
            // part(EmployeeChart; "Employee Analysis Chart")
            // {
            //     ApplicationArea = All;
            // }
            // part(Control104; "Headline RC Order Processor")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
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
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control14; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control1907692008; "My Customers")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control1; "Trailing Sales Orders Chart")
            {
                AccessByPermission = TableData "Sales Shipment Header" = R;
                ApplicationArea = Basic, Suite;
            }
            part(Control4; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1905989608; "My Items")
            {
                AccessByPermission = TableData "My Item" = R;
                ApplicationArea = Basic, Suite;
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control21; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
                ApplicationArea = Suite;
            }
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
        area(Processing)
        {
            group(Setups)
            {
                action("HR Setup")
                {
                    Caption = 'HR Setup';
                    RunObject = page "Human Resources Setup";
                    Image = Setup;
                    ApplicationArea = All;
                    ToolTip = 'Executes the HR Setup action.';
                }
            }
            group(Tasks)
            {
                action("Leave Types")
                {
                    Caption = 'Leave Types';
                    Image = Process;
                    RunObject = page "Leave Types";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Leave Types action.';
                }
                action("Create New Leave Period")
                {
                    Caption = 'Create New Leave Period';
                    Image = Process;
                    RunObject = page "Leave Periods";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create New Leave Period action.';
                }
            }
            group(Reports)
            {
                group("Leave Reports")
                {
                    action("Leave Balance Report")
                    {
                        Caption = 'Leave Balance Report';
                        ToolTip = 'Leave Balance Report';
                        Image = Report;
                        RunObject = report "Leave Balance";
                        ApplicationArea = All;
                    }
                    action("Total Leave Balance Report")
                    {
                        Caption = 'Total Leave Balance Report';
                        ToolTip = 'Total Leave Balance Report';
                        Image = Report;
                        RunObject = report "Total Leave Balance";
                        ApplicationArea = All;
                    }
                    action("Used Leave Days Report")
                    {
                        Caption = 'Used Leave days Report';
                        ToolTip = 'Used Leave days Report';
                        Image = Report;
                        RunObject = report "Used Leave days Report";
                        ApplicationArea = All;
                    }
                    /*  action("Leave Utilization Report.")
                      {
                          Caption = 'Leave Utilization Report';
                          Image = Report;
                          RunObject = report "Leave Utilization Report";
                          ApplicationArea = All;
                      }*/
                    /*  action("Leave Plan Report")
                      {
                          Caption = 'Leave Plan Report';
                          Image = Report;
                          RunObject = report "Leave Calendar Plan";
                          ApplicationArea = All;
                      }*/
                    action("Leave Recall Report.")
                    {
                        Caption = 'Leave Recall Report';
                        Image = Report;
                        RunObject = report "Leave Recall Report";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Recall Report action.';
                    }
                    action("Staff On Leave Report")
                    {
                        Caption = 'Staff On Leave';
                        Image = Report;
                        RunObject = report "Staff On Leave";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Staff On Leave action.';
                    }
                    action("Staff Due For Leave Report")
                    {
                        Caption = 'Staff Due For Leave';
                        Image = Report;
                        RunObject = report "Staff Due For Leave";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Staff Due For Leave action.';
                    }
                }
            }
            group(History)
            {
                action("Approved Leave Applications")
                {
                    RunPageMode = View;
                    Image = ListPage;
                    RunObject = page "Approved Leave Application";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Approved Leave Applications action.';
                }
                // action("Approved Training Requests.")
                // {
                //     Caption = 'Approved Training Requests';
                //     RunPageMode = View;
                //     Image = ListPage;
                //     RunObject = page "Approved Training Requests";
                //     ApplicationArea = All;
                // }
                // action("Approved Recruitment Requests")
                // {
                //     RunPageMode = View;
                //     Image = ListPage;
                //     RunObject = page RecruitmentApproved;
                //     ApplicationArea = All;
                // }
            }
        }
        area(Reporting)
        {
            action("Employee Listing")
            {
                Caption = 'Employee Listing Report';
                ToolTip = 'Employee Listing';
                Image = Report;
                RunObject = report "Employee Report";
                ApplicationArea = All;
            }
            action("Report per Employee")
            {
                Caption = 'Report per Employee';
                ToolTip = 'Report per Employee';
                Image = Report;
                //RunObject = report "Report Per Employee";
                ApplicationArea = All;
            }

        }
        area(Embedding)
        {
            ToolTip = 'Manage sales processes, view KPIs, and access your favorite items and customers.';
            action("Employee List")
            {
                RunObject = page "Employee List";
                ApplicationArea = All;
                ToolTip = 'Executes the Employee List action.';
            }
            action("Leave Applications2")
            {
                Caption = 'New Leave Application';
                RunObject = page "Leave Application List";
                ApplicationArea = All;
                ToolTip = 'Executes the New Leave Application action.';
            }
        }
        area(Sections)
        {
            group("Group")
            {
                Caption = 'Employees';
                action("Employees")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    RunObject = page "Employee List";
                    ToolTip = 'Executes the Employees action.';
                }
                action("Absence Registration")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Absence Registration';
                    RunObject = page "Absence Registration";
                    ToolTip = 'Executes the Absence Registration action.';

                }
                action("Leave Applications")
                {
                    Caption = 'New Leave Application';
                    RunObject = page "Leave Application List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the New Leave Application action.';
                }
            }
            group("Leave Management")
            {
                group("Leave Application")
                {
                    action("Leave Application List")
                    {
                        Caption = 'New Leave Application';
                        RunObject = Page "Leave Application List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the New Leave Application action.';
                    }
                    action("Leave Application Pending Approval")
                    {
                        Caption = 'Leave Application Pending Approval';
                        RunObject = page "Leave App. Pending Approval HR";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Application Pending Approval action.';
                    }
                    action("Leave Application Pending 2nd Approval")
                    {
                        Caption = 'Leave Application 2nd Pending Approval';
                        RunObject = page "Leave Appl Pending Approval";
                        ApplicationArea = All;
                        Visible = False;
                        ToolTip = 'Executes the Leave Application 2nd Pending Approval action.';

                    }
                    action("Approved Leave")
                    {
                        RunObject = Page "Approved Leave App";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Approved Leave action.';
                    }
                    action("Rejected Leave")
                    {
                        RunObject = Page "Rejected  Leave Application";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Rejected Leave action.';
                    }
                    action("Leave Ledger Entry")
                    {
                        RunObject = page "Leave Ledger Entry";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Ledger Entry action.';
                    }
                    action("Leave Journal")
                    {
                        RunObject = page "Leave Journal";
                        ApplicationArea = all;
                        ToolTip = 'Executes the Leave Journal action.';
                    }
                }
                group("Employee Leave Plan")
                {
                    action("Create Leave Plan")
                    {
                        Caption = 'New Leave Plan';
                        RunObject = Page "Employee Leave Plan List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the New Leave Plan action.';
                    }
                    action("Submitted Leave Plan")
                    {
                        RunObject = page "Submitted Leave Plan";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Submitted Leave Plan action.';
                    }
                }

                group("Leave Recalls")
                {
                    action("Leave Recall")
                    {
                        RunObject = Page "Leave Recalls List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Recall action.';
                    }
                    action("Submitted Leave Recall")
                    {
                        RunObject = page "Submitted Leave Recalls";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Submitted Leave Recall action.';
                    }

                }
                group("Leave Report")
                {
                    action("Leave Balance")
                    {
                        RunObject = report "Leave Balance";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Balance action.';
                    }
                    /* action("Total Leave Balance")
                     {
                         RunObject = report "Total Leave Balance";
                         ApplicationArea = All;
                     }*/

                    action("Staff on Leave")
                    {
                        RunObject = report "Staff on Leave";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Staff on Leave action.';
                    }
                    action("Staff due For Leave")
                    {
                        RunObject = report "Staff Due For Leave";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Staff due For Leave action.';
                    }
                    /*    action("Leave Utilization Report")
                        {
                            RunObject = report "Leave Utilization Report";
                            ApplicationArea = All;
                        }*/

                    action("Leave Recall Report")
                    {
                        RunObject = report "Leave Recall Report";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Recall Report action.';
                    }
                    action("Leave Summary Report")
                    {
                        //RunObject = report "Overall Leave Bal";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Summary Report action.';
                    }
                    action("Used Leave days")
                    {
                        RunObject = report "Used Leave days Report";

                        ApplicationArea = All;
                        ToolTip = 'Executes the Used Leave days action.';
                    }
                    action("Leave Balance Quarterly Report")
                    {
                        RunObject = report "Leave Balance Quarterly";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Balance Quarterly Report action.';
                    }

                    /*   action("Leave Calender Plan Report")
                       {
                           RunObject = report "Leave Calendar Plan";
                           ApplicationArea = All;
                       }*/

                    /* action("Calculate Leave Days")
                     {
                         RunObject = report "Calculate Leave Days Earned";

                         ApplicationArea = All;
                     }*/
                    /* action("Leave Summary Balance")
                  {
                      RunObject = report "Leave Summary Report";
                      ApplicationArea = All;
                  }*/

                }
            }
            group("HR Approvals")
            {
                // action("Training Approvals")
                // {
                //     RunObject = page "Training Approvals";
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // action("Recruitment Approvals")
                // {
                //     RunObject = page "Recruitment & Selection";
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                action("Leave Approvals")
                {
                    RunObject = page "Leave Approvals";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Leave Approvals action.';
                }

            }
            group("Staff Leave Application")
            {
                action("Employee Leave Application")
                {
                    Caption = 'New Leave Application';
                    RunObject = Page "Staff Leave List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the New Leave Application action.';
                }
                action("Pending Employee Leave Application")
                {
                    RunObject = page "Staff Leave Pending Approval";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Pending Employee Leave Application action.';
                }
                action("Approved Employee Leave Application")
                {

                    RunObject = page "Approved Leave Application";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Approved Employee Leave Application action.';
                }
                action("Rejected Employee Leave Application")
                {
                    RunObject = Page "Rejected  Leave Application";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Rejected Employee Leave Application action.';
                }
            }
            group("Staff Leave Plan")
            {
                action("New Leave Plan")
                {
                    Caption = 'New Leave Plan';
                    RunObject = Page "Employee Leave Plan List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the New Leave Plan action.';
                }
                action("Submitted Staff Leave Plan")
                {
                    RunObject = page "Submitted Leave Plan";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Submitted Staff Leave Plan action.';
                }

            }
            group("Leave Pending Approvals")
            {
                action("Leave App. Pending Approval")
                {
                    Caption = 'Leave Application Pending Approval';
                    RunObject = page "Leave App. Pending Approval";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Leave Application Pending Approval action.';
                }
                action("Leave App. Pending 2nd Approval")
                {
                    Caption = 'Leave Application 2nd Pending Approval';
                    RunObject = page "Leave Appl Pending Approval";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Leave Application 2nd Pending Approval action.';
                }
            }
            group("Group2")
            {
                Caption = 'Setup';
                action("Human Resources Setup")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Human Resources Setup';
                    RunObject = page "Human Resources Setup";
                    ToolTip = 'Executes the Human Resources Setup action.';
                }
                action("Human Resources Units of Measu")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Human Resources Units of Measure';
                    RunObject = page "Human Res. Units of Measure";
                    ToolTip = 'Executes the Human Resources Units of Measure action.';
                }
                action("Causes of Inactivity")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Causes of Inactivity';
                    RunObject = page "Causes of Inactivity";
                    ToolTip = 'Executes the Causes of Inactivity action.';
                }
                action("Grounds for Termination")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Grounds for Termination';
                    RunObject = page "Grounds for Termination";
                    ToolTip = 'Executes the Grounds for Termination action.';
                }
                action("Unions")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Unions';
                    RunObject = page "Unions";
                    ToolTip = 'Executes the Unions action.';
                }
                action("Employment Contracts")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employment Contracts';
                    RunObject = page "Employment Contracts";
                    ToolTip = 'Executes the Employment Contracts action.';
                }
                action("Relatives")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Relatives';
                    RunObject = page "Relatives";
                    ToolTip = 'Executes the Relatives action.';
                }
                action("Misc. Articles")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Misc. Articles';
                    RunObject = page "Misc. Articles";
                    ToolTip = 'Executes the Employee Misc. Articles action.';
                }
                action("Confidential")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Confidential';
                    RunObject = page "Confidential";
                    ToolTip = 'Executes the Confidential action.';
                }
                action("Qualifications")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Qualifications';
                    RunObject = page "Qualifications";
                    ToolTip = 'Executes the Qualifications action.';
                }
                action("Employee Statistics Groups")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Statistics Groups';
                    RunObject = page "Employee Statistics Groups";
                    ToolTip = 'Executes the Employee Statistics Groups action.';
                }
            }
            group("Group1")
            {
                Caption = 'Reports';
                action("Employee - Absences by Causes")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Absences by Causes';
                    RunObject = report "Employee - Absences by Causes";
                    ToolTip = 'Executes the Employee Absences by Causes action.';
                }
                action("Employee - Addresses")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Addresses';
                    RunObject = report "Employee - Addresses";
                    ToolTip = 'Executes the Employee Addresses action.';
                }
                action("Employee - Alt. Addresses")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Alt. Addresses';
                    RunObject = report "Employee - Alt. Addresses";
                    ToolTip = 'Executes the Employee Alt. Addresses action.';
                }
                action("Employee - Birthdays")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Birthdays';
                    RunObject = report "Employee - Birthdays";
                    ToolTip = 'Executes the Employee Birthdays action.';
                }
                action("Employee - Confidential Info.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Confidential Info.';
                    RunObject = report "Employee - Confidential Info.";
                    ToolTip = 'Executes the Employee Confidential Info. action.';
                }
                action("Employee - Contracts")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Contracts';
                    RunObject = report "Employee - Contracts";
                    ToolTip = 'Executes the Employee Contracts action.';
                }
                action("Employee - Labels")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Labels';
                    RunObject = report "Employee - Labels";
                    ToolTip = 'Executes the Employee Labels action.';
                }
                action("Employee - List")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee List';
                    RunObject = report "Employee - List";
                    ToolTip = 'Executes the Employee List action.';
                }
                action("Employee - Misc. Article Info.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Misc. Article Info.';
                    RunObject = report "Employee - Misc. Article Info.";
                    ToolTip = 'Executes the Employee Misc. Article Info. action.';
                }
                action("Employee - Qualifications")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Qualifications';
                    RunObject = report "Employee - Qualifications";
                    ToolTip = 'Executes the Employee Qualifications action.';
                }
                action("Employee - Relatives")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Relatives';
                    RunObject = report "Employee - Relatives";
                    ToolTip = 'Executes the Employee Relatives action.';
                }
                action("Employee - Staff Absences")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Staff Absences';
                    RunObject = report "Employee - Staff Absences";
                    ToolTip = 'Executes the Staff Absences action.';
                }
                action("Employee - Unions")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employee Unions';
                    RunObject = report "Employee - Unions";
                    ToolTip = 'Executes the Employee Unions action.';
                }
            }
        }
    }
}
profile HRProfile
{
    ProfileDescription = 'HUMAN RESOURCES';
    RoleCenter = "Human Resource Manager RC";
    Caption = 'HUMAN RESOURCES';
}