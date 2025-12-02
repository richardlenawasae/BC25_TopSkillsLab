page 50115 "Headline RC HR"
{
    // NOTE: If you are making changes to this page you might want to make changes to all the other Headline RC pages

    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field(GreetingText1; RCHeadlinesPageCommon.GetGreetingText())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                }
                field(GreetingText; StrSubstNo(Text000, UserId))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Control2)
            {
                field(ActiveEmployeeText; StrSubstNo(Text001, EmployeeCount))
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    trigger OnDrillDown();
                    begin
                        Employee.Reset();
                        Employee.SetRange("Employee Status", Employee.Status);
                        if Employee.FindSet() then
                            page.Run(5201, Employee);
                    end;

                }
            }
            group(Control3)
            {
                field(LeaveText; StrSubstNo(Text002, LeaveCount))
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                }
            }
            group(Control4)
            {
                // Visible = SeeBirthday;
                field(BirthdayText; StrSubstNo(Text003, BirthdayCount))
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                }
            }
            group(Control5)
            {
                // Visible = SeeBirthday;
                field(ProbationText; StrSubstNo(Text004, ProbationCount))
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                }
            }
            group(Control6)
            {
                // Visible = SeeBirthday;
                field(SeparationText; StrSubstNo(Text005, separationCount, CompanyInfo.Name))
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        GetEmployees();
        LeaveTodayCount();
        CompanyInfo.Get;

        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Order Processor");
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
    end;

    var

        DefaultFieldsVisible: Boolean;

        UserGreetingVisible: Boolean;
        Employee: Record Employee;
        EmployeeCount: Integer;
        BirthdayCount: Integer;
        EmployeesOnLeave: Integer;
        LeaveCount: Integer;
        ProbationCount: Integer;
        SeparationCount: Integer;
        BirthdayNames: Text;
        LeaveApplications: Record "Leave Application";
        DimensionValue: Record "Dimension Value";
        HRSummary: Record "HR Summary";
        SeeBirthday: Boolean;
        InputDate: Date;
        //separation: Record Separation;
        EmployeeStatus: Enum "Employee Status";
        Text000: Label 'Welcome %1';
        Text001: Label 'There are %1 active Employees';
        Text002: Label '%1 Employees are on leave today';
        Text003: Label '%1 Employees are celebrating their birthday today';
        Text004: Label '%1 Employees are on probation';
        Text005: Label '%1 Employees have left %2';
        CompanyInfo: Record "Company Information";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";

    local procedure GetEmployees()
    begin
        SeeBirthday := false;
        Employee.Reset();
        Employee.setrange(Status, EmployeeStatus::Active);
        if Employee.FindSet() then begin
            EmployeeCount := Employee.Count;
            //InputDate := TODAY;
            repeat
                IF Employee."Date of Birth" <> 0D THEN BEGIN
                    IF (Date2DMY(Employee."Date of Birth", 1)) = (Date2DMY(Today, 1)) THEN BEGIN
                        IF (Date2DMY(Employee."Date of Birth", 2)) = (Date2DMY(Today, 2)) THEN BEGIN
                            BirthdayCount += 1;
                        END;
                    END;
                END;
            until employee.Next() = 0;
            if BirthdayCount <> 0 then begin
                //  SeeBirthday := true;
            end;
        end;
        Employee.Reset();
        Employee.setrange("Employee Status", Employee."Employee Status"::Probation);
        if Employee.FindSet() then begin
            ProbationCount := Employee.Count;
        end;
        Employee.Reset();
        Employee.setrange("Employee Status", Employee."Employee Status"::Terminated);
        if Employee.FindSet() then begin
            SeparationCount := Employee.Count;
        end;
    end;

    local procedure LeaveTodayCount()
    begin
        LeaveApplications.Reset();
        LeaveApplications.SetRange(Status, LeaveApplications.Status::Released);
        LeaveApplications.SetFilter("Approved Start Date", '<%1', TODAY);
        LeaveApplications.SetFilter("Approved End Date", '>%1', TODAY);
        if LeaveApplications.FindSet() then begin
            repeat
                LeaveCount += 1;
            until LeaveApplications.Next() = 0;
        end;
    end;

    local procedure UpdateSummary()
    var
        i: Integer;
        j: Integer;
        k: Integer;
    begin
        HRSummary.Reset();
        HRSummary.DeleteAll();

        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", 'BRANCH');
        if DimensionValue.FindSet() then begin
            repeat
                HRSummary.Init();
                HRSummary.Branch := DimensionValue.Code;
                Employee.Reset();
                Employee.SetRange("Global Dimension 1 Code", DimensionValue.Code);
                if Employee.FindSet() then begin
                    repeat
                        if Employee."Employee Status" = Employee."Employee Status"::Active then
                            i += 1;
                        if Employee."Employee Status" = Employee."Employee Status"::Probation then
                            j += 1;
                    until Employee.Next() = 0;
                    k := Employee.Count;
                end;
                HRSummary."Active Employees" := i;
                HRSummary."Employees on Probation" := j;
                HRSummary."Total Employees" := k;
                HRSummary.Insert();
            until DimensionValue.Next() = 0;
        end;
    end;
}