report 50107 "Leave Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Leave Summary Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItemName; "Leave Type")
        {
            DataItemTableView = sorting(Code) order(ascending);
            column(Code; Code)
            {
            }
            column(Description; Description)
            {
            }
            column(NoofPosLeaves; NoofPosLeaves)
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

            dataitem(DataItem2; "Leave Application")
            {
                DataItemLink = "leave Code" = field(Code);
                DataItemTableView = sorting("Employee No.") order(ascending);
                RequestFilterFields = "Employee No.";
                column(No_Leave; "No.")
                {
                }
                column(Employee_No_; "Employee No.")
                {
                }
                column(Employee_Name; "Employee Name")
                {
                }
                column(Approved_Start_Date; "Approved Start Date")
                {
                }
                column(Approved_End_Date; "Approved End Date")
                {
                }
                column(Leave_Code; "Leave Code")
                {
                }
                column(Application_Date; "Application Date")
                {
                }
                column(Approved_Days; "Approved Days")
                {
                }
                column(Date_First_Approved; "Date First Approved")
                {
                }
                column(Date_Second_Approved; "Date Second Approved")
                {
                }
                column(Leave_balance; "Leave balance")
                {
                }
                column(RemainingDays; RemainingDays)
                {

                }

                trigger OnPreDataItem();
                begin
                    // if LeaveApplication.GETFILTER("Employee No.") = '' then
                    ///   ERROR('Please specify the employee No.');
                end;

                trigger OnAfterGetRecord();
                BEGIN
                    IF Status <> Status::Released THEN
                        CurrReport.SKIP;

                    RemainingDays := GetLeaveBalance("Employee No.", "Leave Code");
                END;
            }
            trigger OnAfterGetRecord();
            begin
                NoofPosLeaves := 0;
            end;
        }
        dataitem(DataItem3; "Leave Recall")
        {
            DataItemTableView = sorting("Employee No") order(ascending);
            column(Recall_Date; "Recall Date")
            {
            }
            column(Recalled_Days; "Recalled Days")
            {
            }
            column(Recalled_By; "Recalled By")
            {
            }
            column(Recalled_From; "Recalled From")
            {
            }
            column(Recalled_To; "Recalled To")
            {
            }
            trigger OnAfterGetRecord();
            begin
                //   if status <> status::Released then
                // CurrReport.Skip();
            end;
        }

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
        HeaderText: Label 'LEAVE SUMMARY REPORT';
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        NoofPosLeaves: Decimal;
        LeaveApplication: Record "Leave Application";
        RemainingDays: Decimal;

    procedure GetLeaveBalance(EmployeeNo: Code[100]; LeaveCode: enum "Leave Type"): Decimal;
    begin
        LeaveLedgerEntry.RESET;
        LeaveLedgerEntry.SETRANGE(LeaveLedgerEntry."Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE(LeaveLedgerEntry."Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::Positive);
        IF LeaveLedgerEntry.FindSet() THEN begin
            repeat
                NoofPosLeaves += LeaveLedgerEntry.Days;
            until LeaveLedgerEntry.Next() = 0;
        end;
        LeaveLedgerEntry.RESET;
        LeaveLedgerEntry.SETRANGE(LeaveLedgerEntry."Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE(LeaveLedgerEntry."Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::Negative);
        IF LeaveLedgerEntry.FindSet() THEN BEGIN
            repeat
                NoofPosLeaves -= LeaveLedgerEntry.Days;
            until LeaveLedgerEntry.Next() = 0;
        END;
        exit(NoofPosLeaves);
    end;
}
