report 50114 "Employees Relative Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/EmployeeRelative.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "Employee Relative")
        {
            column(Employee_No_; "Employee No.")
            { }
            column(Relative_Code; "Relative Code")
            { }
            column(Phone_No_; "Phone No.") { }
            column(Birth_Date; "Birth Date") { }
            column(Relation_Type; "Relation Type") { }
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
            column(Fullname; Fullname)
            {

            }
            column(HeaderText; HeaderText)
            { }
            trigger OnAfterGetRecord();
            begin
                IF "Employee No." <> '' THEN BEGIN
                    Employee.GET("Employee No.");
                    Fullname := Employee.FullName();
                END;
            END;
        }
    }
    trigger OnInitReport();
    begin
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        HeaderText: Label 'Employee Relative Report';
        Employee: Record Employee;
        Fullname: Text[200];
}