report 50106 "Leave Utilization Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Leave Utilization Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1; 5200)
        {
            column(No_Employee; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(BranchName_Employee; "Global Dimension 1 Code")
            {
            }
            column(DepartmentName_Employee; "Global Dimension 2 Code")
            {
            }
            column(EmploymentDate_Employee; "Employment Date")
            {
            }
            column(Status_Employee; Status)
            {
            }
            column(JobTitle_Employee; "Job Title")
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
            column(SNo; SNo)
            {
            }
            column(BalanceBroughtForward; LeaveDays[1])
            {
            }
            column(AddedBackDays; LeaveDays[2])
            {
            }
            column(LeaveEntitlement; LeaveDays[3])
            {
            }
            column(TotalLeaveDays; LeaveDays[4])
            {
            }
            column(LeavePlan; LeaveDays[5])
            {
            }
            column(DaysTaken; LeaveDays[6])
            {
            }
            column(LeaveBalance; LeaveDays[7])
            {
            }
            column(Variance; LeaveDays[8])
            {
            }
            column(UtilizationStatus; UtilizationStatus)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if "Employee Status" <> "Employee Status"::Active then
                    CurrReport.skip();
                IF Status <> Status::Active THEN
                    CurrReport.SKIP();
                Name := FullName();
                SNo += 1;
                LeaveDays[1] := 0;
                LeaveDays[2] := 0;
                LeaveDays[3] := 0;
                LeaveDays[4] := 0;
                LeaveDays[5] := 0;
                LeaveDays[6] := 0;
                LeaveDays[7] := 0;
                LeaveDays[8] := 0;
                GetLeaveEntitlement();
                GetLeaveBalances("No.");
                GetLeavePlanDays("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Date Filter"; DateFilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DateFilter field.';
                }
            }
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
        CompanyInformation.GET();
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        Name: Text;
        CompanyInformation: Record "Company Information";
        SNo: Integer;
        LeaveDays: array[10] of Decimal;
        HRManagement: Codeunit "HR Management";
        DateFilter: Date;
        UtilizationStatus: Option Excess,Deficit;
        HeaderText: Label 'Leave Utilization Report';
        LeaveType: enum "Leave Type";

    local procedure GetLeaveBalances(EmployeeNo: Code[20]);
    begin
        LeaveDays[1] := HRManagement.GetBalanceBroughtForward(EmployeeNo, LeaveType::Annual, DateFilter);
        LeaveDays[2] := HRManagement.GetAddedBackDays(EmployeeNo, LeaveType::Annual, DateFilter);
        LeaveDays[4] := LeaveDays[1] + LeaveDays[2] + LeaveDays[3];
        LeaveDays[6] := HRManagement.GetUsedLeaveDays(EmployeeNo, LeaveType::Annual, DateFilter);
        LeaveDays[7] := LeaveDays[4] - LeaveDays[6];
        LeaveDays[8] := LeaveDays[5] - LeaveDays[7];
        IF LeaveDays[8] < 0 THEN
            UtilizationStatus := UtilizationStatus::Deficit
        ELSE
            UtilizationStatus := UtilizationStatus::Excess;
    end;

    local procedure GetLeavePlanDays(EmployeeNo: Code[20]);
    var
        LeavePlan: Record "Leave Plan Header";
        LeavePlanLines: Record "Leave Plan Line";
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE(Year, DATE2DMY(TODAY, 3));
        LeavePlan.SETRANGE("Employee No", EmployeeNo);
        IF LeavePlan.FINDLAST() THEN BEGIN
            LeavePlanLines.RESET();
            LeavePlanLines.SETRANGE("No.", LeavePlan."No.");
            LeavePlanLines.SETFILTER("Start Date", '<=%1', DateFilter);
            IF LeavePlanLines.FINDSET() THEN BEGIN
                REPEAT
                    LeaveDays[5] += LeavePlanLines.Days;
                UNTIL LeavePlanLines.NEXT() = 0;
            END;
        END;
    end;

    local procedure GetLeaveEntitlement();
    var
        LeaveType: Record "Leave Type";
    begin
        LeaveType.RESET();
        LeaveType.SETRANGE("Annual Leave", TRUE);
        IF LeaveType.FINDFIRST() THEN;
        LeaveDays[3] := LeaveType.Days;
    end;
}

