report 50110 "Used Leave days Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Used Leave Days.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem2; "Leave Application")
        {
            RequestFilterFields = "Employee No.", Status, "Leave Code";
            DataItemTableView = WHERE(Status = FILTER(Released));

            column(Employee_No_; "Employee No.")
            {

            }
            column(Employee_Name; "Employee Name")
            {

            }
            column(Leave_Code; "Leave Code")
            {

            }
            column(Approved_Start_Date; "Approved Start Date")
            {

            }
            column(Approved_End_Date; "Approved End Date")
            {

            }
            column(Approved_Days; "Approved Days")
            {

            }
            column(Status; Status)
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

                IF "Approved End Date" > TODAY THEN
                    CurrReport.SKIP;
                IF Format("Approved End Date") = '' then
                    CurrReport.SKIP;
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
        HeaderText: Label 'Employee Used Leave Days Report';
}