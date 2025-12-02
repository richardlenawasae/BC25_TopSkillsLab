report 50111 "Staff Due For Leave"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Staff Due For Leave.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1; "Leave Application")
        {
            DataItemTableView = WHERE(Status = FILTER(Released));
            column(EmployeeNo_LeaveApplication; "Employee No.")
            {
            }
            column(StartDate_LeaveApplication; "Start Date")
            {
            }
            column(EndDate_LeaveApplication; "End Date")
            {
            }
            column(ApplicationDate_LeaveApplication; "Application Date")
            {
            }
            column(Leavebalance_LeaveApplication; "Leave balance")
            {
            }
            column(TotalLeaveDaysTaken_LeaveApplication; "Total Leave Days Taken")
            {
            }
            column(DutiesTakenOverBy_LeaveApplication; "Duties Taken Over By")
            {
            }
            column(MobileNo_LeaveApplication; "Mobile No.")
            {
            }
            column(LeaveEarnedtoDate_LeaveApplication; "Leave Earned to Date")
            {
            }
            column(DateofJoiningCompany_LeaveApplication; "Employment Date")
            {
            }
            column(JobTitle_LeaveApplication; "Job Title")
            {
            }
            column(EmploymentDate_LeaveApplication; "Employment Date")
            {
            }
            column(DaysApplied_LeaveApplication; "Days Applied")
            {
            }
            column(ResumptionDate_LeaveApplication; "Resumption Date")
            {
            }
            column(ReasonforLeave_LeaveApplication; "Reason for Leave")
            {
            }
            column(Picturse; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(Address; CompanyInformation.Address)
            {
            }
            column(Status_LeaveApplication; Status)
            {
            }
            column(LeaveCode_LeaveApplication; "Leave Code")
            {
            }
            column(ApplicationNo_LeaveApplication; "No.")
            {
            }
            column(EmployeeName_LeaveApplication; "Employee Name")
            {
            }
            column(Branch_LeaveApplication; "Branch Code")
            {
            }
            column(Department_LeaveApplication; Department)
            {
            }
            column(CompanyInformation_City; CompanyInformation.City)
            {
            }
            column(HeaderText; HeaderText)
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF "Approved Start Date" < TODAY THEN
                    CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInformation.GET;
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        LeaveApplication: Record "Leave Application";
        HeaderText: Label 'Staff Due For Leave';
}

