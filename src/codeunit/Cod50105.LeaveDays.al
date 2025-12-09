codeunit 50105 "Leave Days"
{
    trigger OnRun()
    begin
        LeaveTypes.RESET();
        LeaveTypes.SetRange("Annual Leave", true);
        IF LeaveTypes.FINDSET() THEN begin
            REPEAT
                Employee.RESET();
                Employee.SETRANGE("Employee Type", Employee."Employee Type"::Permanent);
                if Employee.FindSet() then BEGIN
                    repeat
                        LeaveLedgerEntry.Reset();
                        LeaveLedgerEntry.SetRange("Leave Period");
                        LeaveLedgerEntry.SetRange("Employee No.", Employee."No.");
                        if not LeaveLedgerEntry.FindFirst() then begin
                            LeaveLedgerEntry.Reset();
                            if LeaveLedgerEntry.FindLast() then
                                myInt := LeaveLedgerEntry."Entry No." + 1;
                            LeaveLedgerEntry.INIT();
                            LeaveLedgerEntry."Entry No." := myInt;
                            LeaveLedgerEntry."Leave Period" := Format(Date2DMY(Today, 3));
                            LeaveLedgerEntry.Closed := false;
                            LeaveLedgerEntry."Employee No." := Employee."No.";
                            LeaveLedgerEntry."Employee Name" := Employee.FullName();
                            LeaveLedgerEntry."Posting Date" := Today;
                            LeaveLedgerEntry."User ID" := UserId;
                            LeaveLedgerEntry."Leave Code" := LeaveTypes.Code;
                            LeaveLedgerEntry.Days := LeaveTypes.Days;
                            LeaveLedgerEntry."Earned Leave Days" := true;
                            LeaveLedgerEntry."Document No" := 'LEAVE-' + FORMAT(DATE2DMY(TODAY, 3));
                            LeaveLedgerEntry.Description := 'Leave Days earned ' + FORMAT(TODAY);
                            LeaveLedgerEntry."Entry Type" := LeaveLedgerEntry."Entry Type"::Positive;
                            LeaveLedgerEntry.INSERT();
                        end;
                    UNTIL Employee.Next() = 0;
                end;
            UNTIL LeaveTypes.Next() = 0;
        end;

        LeaveTypes.RESET();
        LeaveTypes.SetRange("Earn Basis", LeaveTypes."Earn Basis"::Monthly);
        IF LeaveTypes.FINDSET() THEN begin
            REPEAT
                Employee.RESET();
                //  Employee.SETRANGE("Employee Type", Employee."Employee Type"::Permanent);
                Employee.SETFILTER("Employee Status", '%1|%2|%3|%4', Employee."Employee Status"::Active, Employee."Employee Status"::Confirmed,
                    Employee."Employee Status"::Probation, Employee."Employee Status"::Suspended);
                if Employee.FindSet() then BEGIN
                    repeat
                        LeaveLedgerEntry.Reset();
                        if LeaveLedgerEntry.FindLast() then
                            myInt := LeaveLedgerEntry."Entry No." + 1;
                        LeaveLedgerEntry.INIT();
                        LeaveLedgerEntry."Entry No." := myInt;
                        LeaveLedgerEntry."Leave Period" := Format(Date2DMY(Today, 3));
                        LeaveLedgerEntry.Closed := false;
                        LeaveLedgerEntry."Employee No." := Employee."No.";
                        LeaveLedgerEntry."Employee Name" := Employee.FullName();
                        LeaveLedgerEntry."Posting Date" := Today;
                        LeaveLedgerEntry."User ID" := UserId;
                        LeaveLedgerEntry."Leave Code" := LeaveTypes.Code;
                        LeaveLedgerEntry.Days := LeaveTypes."Days Earned Per Month";
                        LeaveLedgerEntry."Earned Leave Days" := true;
                        LeaveLedgerEntry."Document No" := 'LEAVE-' + FORMAT(DATE2DMY(TODAY, 3));
                        LeaveLedgerEntry.Description := 'Leave Days earned ' + FORMAT(TODAY);
                        LeaveLedgerEntry."Entry Type" := LeaveLedgerEntry."Entry Type"::Positive;
                        LeaveLedgerEntry.INSERT();
                    UNTIL Employee.Next() = 0;
                end;
            UNTIL LeaveTypes.Next() = 0;
        end;
        LeaveTypes.RESET();
        LeaveTypes.SetRange("Earn Basis", LeaveTypes."Earn Basis"::Annually);
        LeaveTypes.SetRange("Calc Leave Days", false);
        if LeaveTypes.FindSet() then begin
            REPEAT
                Employee.RESET();
                Employee.SETRANGE("Employee Type", Employee."Employee Type"::Permanent);
                Employee.SETFILTER("Employee Status", '%1|%2|%3|%4', Employee."Employee Status"::Active, Employee."Employee Status"::Confirmed,
                Employee."Employee Status"::Probation, Employee."Employee Status"::Suspended);
                if Employee.FindSet() then BEGIN
                    repeat
                        LeaveLedgerEntry.Reset();
                        if LeaveLedgerEntry.FindLast() then
                            myInt := LeaveLedgerEntry."Entry No." + 1;
                        LeaveLedgerEntry.INIT();
                        LeaveLedgerEntry."Entry No." := myInt;
                        LeaveLedgerEntry."Leave Period" := Format(Date2DMY(Today, 3));
                        LeaveLedgerEntry.Closed := false;
                        LeaveLedgerEntry."Employee No." := Employee."No.";
                        LeaveLedgerEntry."Employee Name" := Employee.FullName();
                        LeaveLedgerEntry."Posting Date" := Today;
                        LeaveLedgerEntry."User ID" := UserId;
                        LeaveLedgerEntry."Earned Leave Days" := true;
                        LeaveLedgerEntry."Leave Code" := LeaveTypes.Code;
                        LeaveLedgerEntry.Days := LeaveTypes.Days;
                        LeaveLedgerEntry."Document No" := 'LEAVE-' + FORMAT(DATE2DMY(TODAY, 3));
                        LeaveLedgerEntry.Description := 'Leave Days earned ' + FORMAT(TODAY);
                        LeaveLedgerEntry."Entry Type" := LeaveLedgerEntry."Entry Type"::Positive;
                        LeaveLedgerEntry.INSERT();
                    UNTIL Employee.Next() = 0;
                end;
                LeaveTypes."Calc Leave Days" := TRUE;
                LeaveTypes.Modify();
            UNTIL LeaveTypes.Next() = 0;
        end;
    end;

    var
        myInt: Integer;
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        LeaveTypes: Record "Leave Type";
        Employee: Record Employee;
}
