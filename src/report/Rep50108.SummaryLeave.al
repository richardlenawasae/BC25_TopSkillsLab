report 50108 "Summary Leave"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Leave Summaries Report.rdl';
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

            dataitem(DataItem2; "Leave Ledger Entry")
            {
                DataItemLink = "leave Code" = field(Code);
                // DataItemTableView = sorting("Employee No.") order(ascending);
                RequestFilterFields = "Employee No.";
                column(Employee_No_; "Employee No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Days; Days)
                {
                }
                column(Employee_Name; "Employee Name")
                {
                }
            }
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

}
