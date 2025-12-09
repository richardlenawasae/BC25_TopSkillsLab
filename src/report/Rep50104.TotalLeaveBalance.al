report 50104 "Total Leave Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Total Leave Balance.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1; "Leave Balances Management")
        {
            RequestFilterFields = "Employee No.";
            column(Leave_Code; "Leave Code")
            {

            }
            column(Leave_Name; "Leave Name")
            {

            }
            column(Employee_Name; "Employee Name")
            {

            }
            column(Employee_No_; "Employee No.")
            {

            }
            column(Total_Balance; "Total Balance")
            {

            }
            Column(Balance_as_at_Date; "Balance as at Date")
            {

            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(serialno; SNo)
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

                SNo += 1;
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
        // Label = 'Leave Balance Report';
    }

    trigger OnInitReport();
    begin
        SNo := 0;
        CompanyInformation.GET();
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.CALCFIELDS(Picture);
        IF DateFilter = 0D THEN BEGIN
            //  ERROR('Please specify a date filter!');
        END;
    end;


    var
        CompanyInformation: Record "Company Information";
        HeaderText: Label 'Total Leave Balances Report';
        Name: Text[50];
        CompanyInfo: Record "Company Information";
        ANNUAL_LEAVE_BALANCE_CaptionLbl: Label '"ANNUAL LEAVE BALANCE "';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Staff_No_CaptionLbl: Label 'Staff No.';
        NameCaptionLbl: Label 'Name';
        Balance_B_FCaptionLbl: Label 'Balance B/F';
        BalanceCaptionLbl: Label 'Balance';
        EntitlmentCaptionLbl: Label 'Entitlment';
        Days_TakenCaptionLbl: Label 'Days Taken';
        Days_RecalledCaptionLbl: Label 'Days Recalled';
        Days_AbsentCaptionLbl: Label 'Days Absent';
        DateFilter: Date;
        StartDate: Date;
        EndDate: Date;
        LeaveDays: array[10] of Decimal;
        LeaveDay: array[10] of Code[90];
        LeaveTypeDay: array[10] of Decimal;
        HRManagement: Codeunit "HR Management";
        SNo: Integer;
        LeaveFilter: enum "Leave Type";
        LeaveType: Record "Leave Type";
        LeaveBal: record "Leave Balances Management";
        Leave: Decimal;
        Employee: Record Employee;

    local procedure GetLeaveBalances(EmployeeNo: Code[10]; LeaveFilter: enum "Leave Type"): Decimal
    begin
        LeaveDays[1] := HRManagement.GetBalanceBroughtForward(EmployeeNo, LeaveFilter, DateFilter);
        LeaveDays[2] := HRManagement.GetEarnedLeaveDays(EmployeeNo, LeaveFilter, DateFilter);
        LeaveDays[3] := HRManagement.GetLostDays(EmployeeNo, LeaveFilter, DateFilter);
        LeaveDays[4] := HRManagement.GetUsedLeaveDays(EmployeeNo, LeaveFilter, DateFilter);
        LeaveDays[5] := HRManagement.GetRecalledDays(EmployeeNo, LeaveFilter, DateFilter);
        LeaveDays[6] := HRManagement.GetAddedBackDays(EmployeeNo, LeaveFilter, DateFilter);
        LeaveDays[7] := LeaveDays[1] + LeaveDays[2] + LeaveDays[3] + LeaveDays[5] + LeaveDays[6] - LeaveDays[4];
        exit(LeaveDays[7]);
    end;

}

