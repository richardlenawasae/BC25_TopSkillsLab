table 50100 "Leave Application"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee."No." where(Status = filter(Active));
            // Editable = false;
            trigger OnValidate();
            var
                LeaveApp: record "Leave Application";
            begin
                IF Employee.GET("Employee No.") THEN BEGIN
                    IF UserSetup.GET(USERID) THEN begin
                        IF UserSetup."Employee No." <> Employee."No." THEN
                            ERROR('Kindly select your employee number');
                    end;
                    if Employee.Status <> Employee.Status::Active THEN
                        ERROR('Your employee status is not active');

                    LeaveApp.Reset();
                    LeaveApp.SetRange("Employee No.", rec."Employee No.");
                    LeaveApp.SetFilter("No.", '<>%1', rec."No.");
                    LeaveApp.SetRange(Status, LeaveApp.Status::Open);
                    if LeaveApp.FindFirst() then
                        Error('You have an existing new leave application');

                    LeaveApp.Reset();
                    LeaveApp.SetRange("User ID", UserId);
                    LeaveApp.SetFilter("No.", '<>%1', rec."No.");
                    LeaveApp.SetRange(Status, LeaveApp.Status::Open);
                    if LeaveApp.FindFirst() then
                        Error('You have an existing new leave application');

                    "Employee Name" := Employee.FullName();
                    "Branch Code" := Employee."Global Dimension 1 Code";
                    "Job Title" := Employee."Employee Job Title";
                    Department := Employee.Department;
                    "Employment Date" := Employee."Employment Date";
                    "Mobile No." := Employee."Mobile Phone No.";
                END;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Start Date"; Date)
        {
            trigger OnValidate()
            begin
                VALIDATE("Leave Code");
                VALIDATE("Leave balance");
            end;


        }
        field(5; "End Date"; Date)
        {

            trigger OnValidate();
            begin
                HRManagement.CalculateResumptionDate(Rec);
            end;
        }
        field(6; "Application Date"; Date)
        {
            Editable = false;
        }
        field(7; "Leave balance"; Decimal)
        {
            Editable = false;

            trigger OnValidate();
            begin
                // "Leave balance" := "Balance brought forward" + "Leave Earned to Date" + "Recalled Days" + "Added Back Days" - "Total Leave Days Taken";
            end;
        }

        field(8; "Total Leave Days Taken"; Decimal)
        {
            Editable = false;
        }
        field(9; "Duties Taken Over By"; Code[30])
        {
            TableRelation = Employee WHERE(Status = FILTER(Active));

            trigger OnValidate();
            begin
                IF Employee.GET("Duties Taken Over By") THEN BEGIN
                    "Duties Taken Over By" := Employee.FullName();
                END;
            end;
        }
        field(10; "Duties Taken Over By (2)"; Code[150])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                IF Employee.GET("Duties Taken Over By (2)") THEN BEGIN
                    "Duties Taken Over By (2)" := Employee.FullName();
                END;
            end;
        }
        field(12; "Mobile No."; Code[20])
        {
            Editable = false;
        }
        field(13; "Balance Brought Forward"; Decimal)
        {
            Editable = false;
        }
        field(14; "Leave Earned to Date"; Decimal)
        {
            Editable = false;
        }
        field(16; "Recalled Days"; Decimal)
        {
            Editable = false;
        }
        field(17; "User ID"; Code[30])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(18; "Branch Code"; Text[50])
        {
            Editable = false;
        }
        field(19; "Job Title"; Text[70])
        {
            Editable = false;
        }
        field(20; "Lost Days"; Decimal)
        {
            Editable = false;
        }
        field(21; "Employment Date"; Date)
        {
            Editable = false;
        }
        field(22; "Leave Code"; enum "Leave Type")
        {
            // TableRelation = "Leave Type" WHERE(Status = FILTER(Active));

            trigger OnValidate();
            var
                Employee: Record Employee;

            begin
                IF xRec.Status <> Status::Open THEN begin
                    ERROR(Error000);
                end;
                if Employee.Get("Employee No.") then begin
                    Employee.CalcFields("Leave Days");
                    "Leave balance" := Employee."Leave Days";
                end;

                IF LeaveType.GET("Leave Code") THEN BEGIN
                    "Leave Entitlment" := LeaveType.Days;
                END;

                HRManagement.ValidateLeaveTypeByGender(Rec);
                HRManagement.ValidateLeaveTypeByEmployeeType(Rec);
                HRManagement.ValidateLeaveTypeByConfirmationStatus(Rec);


                "Total Leave Days Taken" := HRManagement.GetUsedLeaveDays("Employee No.", "Leave Code", TODAY);
                "Leave Earned to Date" := HRManagement.GetEarnedLeaveDays("Employee No.", "Leave Code", TODAY);
                "Recalled Days" := HRManagement.GetRecalledDays("Employee No.", "Leave Code", TODAY);
                "Lost Days" := HRManagement.GetLostDays("Employee No.", "Leave Code", TODAY);
                "Added Back Days" := HRManagement.GetAddedBackDays("Employee No.", "Leave Code", TODAY);
                "Balance brought forward" := HRManagement.GetBalanceBroughtForward("Employee No.", "Leave Code", TODAY);
                //Message('%1', "Balance Brought Forward");
                VALIDATE("Leave balance");
            END;

        }
        field(23; "Days Applied"; Decimal)
        {

            trigger OnValidate();
            var
                TotalAnnualDaysTaken: decimal;
                LeaveEarnedtoDate: decimal;
                RecalledDays: decimal;
                LostDays: decimal;
                AddedBackDays: decimal;
                Balancebroughtforward: Decimal;
                AnnualLeavebalance: decimal;
                FullPaySickLeave: Decimal;
            begin
                if "Leave Code" = "Leave Code"::Study THEN begin
                    TotalLeaveDaysTaken := HRManagement.GetUsedLeaveDays("Employee No.", "Leave Code"::Annual, TODAY);
                    LeaveEarnedtoDate := HRManagement.GetEarnedLeaveDays("Employee No.", "Leave Code"::Annual, TODAY);
                    RecalledDays := HRManagement.GetRecalledDays("Employee No.", "Leave Code"::Annual, TODAY);
                    LostDays := HRManagement.GetLostDays("Employee No.", "Leave Code"::Annual, TODAY);
                    AddedBackDays := HRManagement.GetAddedBackDays("Employee No.", "Leave Code"::Annual, TODAY);
                    Balancebroughtforward := HRManagement.GetBalanceBroughtForward("Employee No.", "Leave Code"::Annual, TODAY);
                    AnnualLeavebalance := LeaveEarnedtoDate + RecalledDays + LostDays + AddedBackDays + Balancebroughtforward - TotalLeaveDaysTaken;
                    if AnnualLeavebalance > 0.6 then
                        error('You dont qualify for study leave because you have annual leave days');
                end;
                IF "Days Applied" = 0 THEN BEGIN
                    VALIDATE("Leave balance");
                END ELSE BEGIN
                    //"Leave balance" := "Leave balance" - "Days Applied";
                    IF LeaveType.GET("Leave Code") THEN BEGIN
                        if "Leave Code" = "Leave Code"::"Sick Leave-Half Pay" then begin
                            FullPaySickLeave := HRManagement.GetUsedLeaveDays("Employee No.", "Leave Code"::"Sick Leave-Full Pay", TODAY);
                            if FullPaySickLeave < LeaveType.Days then
                                error('Kindly utilize your sick leave-full days first');
                        end;
                        if ("Leave balance" = 0) OR ("Days Applied" > "Leave balance") then begin
                            if "Leave balance" + "Days Applied" > LeaveType."Max Days Allowed" then
                                error('Kindly note that you have exceeded the days allowed');
                        end;
                        // if "Days Applied" > (LeaveType.Days - "Total Leave Days Taken") then
                        //     Error('You have exceeded days allowed');
                        IF LeaveType.Weekdays THEN BEGIN
                            "End Date" := HRManagement.CalculateLeaveEndDate("Days Applied", "Start Date");
                        END;
                        IF LeaveType."Calendar Days" THEN BEGIN
                            IF "Days Applied" MOD 1 = 0 THEN BEGIN
                                "End Date" := CALCDATE(FORMAT("Days Applied" - 1) + 'D', "Start Date");
                            END ELSE BEGIN
                                "End Date" := CALCDATE(FORMAT("Days Applied" DIV 1) + 'D', "Start Date");
                            END;
                        END;
                    END;
                    VALIDATE("End Date");
                END;

                "Approved Start Date" := "Start Date";
                "Approved End Date" := "End Date";
                "Approved Days" := "Days Applied";
            END;
        }
        field(24; "Resumption Date"; Date)
        {
        }
        field(25; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
        }
        field(26; Department; Text[50])
        {
            Editable = false;
        }
        field(27; "Reason for Cancelling"; Text[250])
        {
        }
        field(28; "Reason for Leave"; Text[250])
        {
        }
        field(29; "Leave Entitlment"; Decimal)
        {
            Editable = false;
        }
        field(30; "Off Days"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(31; "Added Back Days"; Decimal)
        {
            Editable = false;
        }
        field(32; "Approved Days"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Approved Days" > "Days Applied" then
                    Error('Approved days cannot be greater than applied days');
                "Approved End Date" := updateEndingDate("Approved Start Date", Format("Approved Days"));

            end;


        }
        field(33; "2nd Approval Comment"; Text[50])
        {
            trigger OnValidate();
            begin
                "Date Second Approved" := CurrentDateTime;
            end;
        }
        field(34; "Approved Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Approved Start Date" < Today then Error('Date Cannot be less than today');
                "Approved End Date" := updateEndingDate("Approved Start Date", Format("Approved Days"));
            end;

        }
        field(35; "Approved End Date"; Date)
        {

        }
        field(36; "First Approver"; Code[100])
        {
            Editable = false;
        }
        field(37; "Leave Allowance Payable"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Leave Allowance Payable" = true then begin
                    TotalLeaveDaysTaken := 0;
                    TotalLeaveDaysTaken := HRManagement.GetUsedLeaveDays("Employee No.", "Leave Code", TODAY);
                    if TotalLeaveDaysTaken < 15 then
                        error('The total leave days must be above 15 days');
                    if Employee.GET("Employee No.") then begin
                        if Employee."Leave Allowance sent" = true then
                            error('A notification has already been sent to the HR/Payroll department')
                        else begin
                            HRManagement.NotifyHRDept(rec);
                            HRManagement.NotifyPayrollDept(Rec);
                            Employee."Leave Allowance sent" := true;
                            Employee.Modify();
                        end;
                    end;

                end;
            end;

        }
        field(38; "No of Approvals"; Decimal)
        {

        }
        field(39; "Second Approver"; Code[100])
        {
            Editable = false;
        }
        field(40; "1st Approval Comment"; Code[100])
        {
            trigger OnValidate();
            begin
                "Date First Approved" := CurrentDateTime;
            end;
        }
        field(41; "First Stage approval"; Boolean)
        {

        }
        field(42; "Second Stage approval"; Boolean)
        {

        }
        field(43; "Pending Approver"; Boolean)
        {

        }
        field(44; "Date First Approved"; DateTime)
        {
            Editable = False;
        }
        field(45; "Date Second Approved"; DateTime)
        {
            Editable = False;

        }
        field(46; "Leave Allowance sent"; Boolean)
        {
        }
        field(47; "Approver 1 Days"; Decimal)
        {
            trigger
            OnValidate()
            begin
                if "Approver 1 Days" > "Days Applied" then
                    Error('Approved days cannot be greater than applied days');
                "Approved End Date" := updateEndingDate("Approved Start Date", Format("Approver 1 Days"));
            end;
        }
        field(48; "Approver 2 Days"; Decimal)
        {
            trigger
            OnValidate()
            begin
                if "Approver 2 Days" > "Days Applied" then
                    Error('Approved days cannot be greater than applied days');
                "Approved End Date" := updateEndingDate("Approved Start Date", Format("Approver 2 Days"));
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        Key(Key2; "Employee No.")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Leave Code", "Employee No.", "Employee Name", "Start Date", "End Date", "Days Applied")
        {
        }
    }

    trigger OnInsert();
    begin

        HumanResourcesSetup.GET();
        "No." := NoSeries.GetNextNo(HumanResourcesSetup."Leave Nos.", TODAY, TRUE);
        "Application Date" := TODAY;
        "User ID" := USERID;
        IF UserSetup.GET(USERID) THEN BEGIN
            noofapprovals := 0;
            LeaveWorkflowSetup.RESET();
            LeaveWorkflowSetup.SETRANGE("User ID", UserSetup."User ID");
            IF LeaveWorkflowSetup.FindFirst() THEN BEGIN
                IF LeaveWorkflowSetup."First Approver" <> '' THEN BEGIN
                    noofapprovals += 1;
                    "First Approver" := LeaveWorkflowSetup."First Approver";
                END;
                IF LeaveWorkflowSetup."Second Approver" <> '' THEN BEGIN
                    noofapprovals += 1;
                    "Second Approver" := LeaveWorkflowSetup."Second Approver";
                END;
                "No of Approvals" := noofapprovals;
                /*  "Employee No." := UserSetup."Employee No.";
                  If Employee.GET("Employee No.") then begin
                      "Employee Name" := Employee.FullName();
                      "Branch Code" := Employee."Global Dimension 1 Code";
                      "Job Title" := Employee."Employee Job Title";
                      Department := Employee.Department;
                      "Employment Date" := Employee."Employment Date";
                      "Mobile No." := Employee."Mobile Phone No.";
                      "Leave Allowance sent" := Employee."Leave Allowance sent";
                  END;*/
            end;
        end;
        /* HRManagement.ValidateLeaveTypeByGender(Rec);
         HRManagement.ValidateLeaveTypeByEmployeeType(Rec);
         HRManagement.ValidateLeaveTypeByConfirmationStatus(Rec);


         "Total Leave Days Taken" := HRManagement.GetUsedLeaveDays("Employee No.", "Leave Code", TODAY);
         "Leave Earned to Date" := HRManagement.GetEarnedLeaveDays("Employee No.", "Leave Code", TODAY);
         "Recalled Days" := HRManagement.GetRecalledDays("Employee No.", "Leave Code", TODAY);
         "Lost Days" := HRManagement.GetLostDays("Employee No.", "Leave Code", TODAY);
         "Added Back Days" := HRManagement.GetAddedBackDays("Employee No.", "Leave Code", TODAY);
         "Balance brought forward" := HRManagement.GetBalanceBroughtForward("Employee No.", "Leave Code", TODAY);
         //Message('%1', "Balance Brought Forward");
         VALIDATE("Leave balance");*/
    end;


    trigger OnDelete();
    begin
        if Status = Status::Released then
            Error(Error000);
    end;

    var
        TotalLeaveDaysTaken: Decimal;
        Error000: Label 'You cannot delete this record!';
        Error001: Label 'You cannot modify this record!';
        Employee: Record Employee;
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        HumanResourcesSetup: Record "Human Resources Setup";
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        LeaveType: Record "Leave Type";
        NoofMonthsWorked: Integer;
        FiscalStart: Date;
        Nextmonth: Date;
        annualdays: Decimal;
        bfdays: Decimal;
        entitleddays: Decimal;
        HRManagement: Codeunit "HR Management";
        LeaveApplicationCard: Page "Leave Application Card";
        noofapprovals: Decimal;
        LeaveWorkflowSetup: Record "Leave WorkFlow Setup";
        // Employee: Record Employee;
        tyty: Codeunit 8901;
        yuyu: Codeunit 8904;

    local procedure updateEndingDate(ApprovedDate: Date; NoOfDays: Text): Date
    begin

        exit(CalcDate(NoOfDays + 'D', ApprovedDate));

    end;


}

