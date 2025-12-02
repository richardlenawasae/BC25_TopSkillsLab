report 50112 "Staff On Leave"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Staff On Leave.rdl';
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
            column(StartDate_LeaveApplication; "Approved Start Date")
            {
            }
            column(EndDate_LeaveApplication; "Approved End Date")
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
            column(DaysApplied_LeaveApplication; "Approved Days")
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
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address)
            {
            }
            column(CompanyInformation_City; CompanyInformation.City)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyInformation_PostCode; CompanyInformation."Post Code")
            {
            }
            column(HeaderText; HeaderText)
            {
            }

            trigger OnAfterGetRecord();
            begin

                IF "Approved Start Date" > TODAY THEN
                    CurrReport.SKIP;

                IF "Approved End Date" < TODAY THEN
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
        HeaderTxt = 'Staff On Leave';
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
        HeaderText: Label 'Staff On Leave';
}

