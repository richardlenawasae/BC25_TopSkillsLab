report 50113 "Employee Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Employee Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1; 5200)
        {
            RequestFilterFields = "No.";

            column(No_Employee; "No.")
            {
            }
            column(Department_Code; "Department Code")
            {
            }
            column(JobTitle_Employee; "Job Title")
            {
            }
            column(EmploymentDate_Employee; "Employment Date")
            {
            }
            column(Name; Name)
            {
            }
            column(Status_Employee; Status)
            {
            }
            column(Gender_Employee; Gender)
            {
            }
            column(BirthDate_Employee; "Birth Date")
            {
            }
            column(Age_Employee; Age)
            {
            }
            column(MaritalStatus_Employee; "Marital Status")
            {
            }
            column(IDNumber_Employee; "National ID")
            {
            }
            column(NSSF_Employee; NSSF)
            {
            }
            column(NHIF_Employee; NHIF)
            {
            }
            column(PINNumber_Employee; "PIN Number")
            {
            }
            column(ResidentialAddress_Employee; Address)
            {
            }
            column(Name_CompanyInformation; CompanyInformation.Name)
            {
            }
            column(Address_CompanyInformation; CompanyInformation.Address)
            {
            }
            column(PostCode_CompanyInformation; CompanyInformation."Post Code")
            {
            }
            column(City_CompanyInformation; CompanyInformation.City)
            {
            }
            column(Pic_CompanyInformation; CompanyInformation.Picture)
            {
            }
            column(Branch_Code; "Branch Code")
            {
            }
            column(serialno; serialno)
            {
            }
            column(HeaderTxt; HeaderTxt)
            {
            }

            trigger OnAfterGetRecord();
            begin
                serialno += 1;
                Name := FullName;

                IF YearFilter <> 0 THEN BEGIN
                    if Status = Status::Active THEN BEGIN
                        IF "Employment Date" = 0D THEN
                            CurrReport.SKIP
                        ELSE
                            IF STRLEN(FORMAT(YearFilter)) <> 4 THEN
                                ERROR('Invalid Year')
                            ELSE
                                IF DATE2DMY("Employment Date", 3) <> YearFilter THEN
                                    CurrReport.SKIP;
                    END ELSE
                        CurrReport.Skip();
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field("Year"; YearFilter)
                {
                    ApplicationArea = All;
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
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    begin
        serialno := 0;
    end;

    var
        CompanyInformation: Record "Company Information";
        serialno: Integer;
        Emp: Record Employee;
        BranchName: Text;
        DimensionValue: Record 349;
        Name: Text;
        HeaderTxt: Label 'Employees Report';
        YearFilter: Integer;
}

