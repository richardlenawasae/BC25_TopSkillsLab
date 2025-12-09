page 50135 "Headline Staff RC HR"
{
    // NOTE: If you are making changes to this page you might want to make changes to all the other Headline RC pages

    Caption = 'Staff Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;
    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the Greeting headline field.';
                }
                field(GreetingText; StrSubstNo(Text000, UserId))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TodayLeaveDays; StrSubstNo(Text002, EmployeeRec."Leave Days"))
                {
                    ApplicationArea = All;
                    Editable = false;;
                }
            }

            group(Control4)
            {
                // Visible = SeeBirthday;
                field(BirthdayText; StrSubstNo(Text003, NextBirthday))
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    ToolTip = 'Specifies the value of the StrSubstNo(Text003, BirthdayCount) field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        GetEmployees();
        CompanyInfo.Get();

        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Order Processor");
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();

        userSetup.Get(UserId);
        EmployeeRec.SetRange("No.", userSetup."Employee No.");
        if EmployeeRec.FindFirst() then
            GetNextBirthday(EmployeeRec."Birth Date");

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
        Text002: Label 'You have %1 leave days remaing for this calender Year';
        Text003: Label 'Your birthday date will be %1';
        Text004: Label '%1 Employees are on probation';
        Text005: Label '%1 Employees have left %2';
        CompanyInfo: Record "Company Information";
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
        EmployeeRec: Record Employee;
        userSetup: Record "User Setup";
        NextBirthday: Date;
        TodayLeaveCount: Decimal;

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

    local procedure LeaveTodayCount(Leavedays: Decimal): Decimal
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

    procedure GetNextBirthday(DOB: Date): Date
    var
        Year: Integer;
    begin
        Year := Date2DMY(Today(), 3);

        // Construct birthday for the current year
        NextBirthday := DMY2Date(Date2DMY(DOB, 1), Date2DMY(DOB, 2), Year);

        // If birthday already passed, use next year
        if NextBirthday < Today() then
            NextBirthday := DMY2Date(Date2DMY(DOB, 1), Date2DMY(DOB, 2), Year + 1);

        exit(NextBirthday);
    end;

}