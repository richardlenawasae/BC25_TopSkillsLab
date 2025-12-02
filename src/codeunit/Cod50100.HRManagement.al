codeunit 50100 "HR Management"
{
    trigger OnRun();
    begin
    end;

    var
        FileManagement: Codeunit 419;
        TEXT001: Label '0001';
        TEXT002: Label 'Document';
        TEXT003: Label 'You cannot upload the same document twice.';
        TEXT004: Label 'Document Attached Successfully.';
        TEXT005: Label 'View this file?';
        TEXT006: Label 'Shortlisting Successful';
        TEXT007: Label 'Are you sure you want to process this separation request?';
        TEXT008: Label 'The correct Employee No has already been assigned!';
        TEXT009: Label 'The Employee No has been changed sucessfully';
        HumanResourcesSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        HostName: Text;
        HostIP: Text;
        HostMAC: Text;
        ChaiDescription: Text;
        Dialogue: Dialog;


    procedure ValidateLeaveTypeByGender(var LeaveApplication: Record "Leave Application");
    var
        LeaveType: Record "Leave Type";
        Employee: Record Employee;
        Error000: Label 'Leave Type %1 is only applicable to male employees!';
        Error001: Label 'Leave Type %1 is only applicable to female employees!';
    begin
        WITH LeaveApplication DO BEGIN
            IF LeaveType.GET("Leave Code") THEN BEGIN
                IF Employee.GET("Employee No.") THEN BEGIN
                    IF LeaveType.Gender = LeaveType.Gender::Male THEN BEGIN
                        IF Employee.Gender = Employee.Gender::Female THEN BEGIN
                            ERROR(FORMAT(Error000), LeaveType.Code);
                        END;
                    END;
                    IF LeaveType.Gender = LeaveType.Gender::Female THEN BEGIN
                        IF Employee.Gender = Employee.Gender::Male THEN BEGIN
                            ERROR(FORMAT(Error001), LeaveType.Code);
                        END;
                    END;
                END;
            END;
        END;
    end;

    procedure ValidateLeaveTypeByEmployeeType(var LeaveApplication: Record "Leave Application");
    var
        LeaveType: Record "Leave Type";
        Employee: Record Employee;
        Error000: Label 'Leave Type %1 is only applicable to permanent employees!';
        Error001: Label 'Leave Type %1 is only applicable to temporary employees!';
    begin
        WITH LeaveApplication DO BEGIN
            IF LeaveType.GET("Leave Code") THEN BEGIN
                IF Employee.GET("Employee No.") THEN BEGIN
                    IF LeaveType."Eligible Staff" = LeaveType."Eligible Staff"::Permanent THEN BEGIN
                        IF Employee."Employee Type" = Employee."Employee Type"::Permanent THEN BEGIN
                        END ELSE BEGIN
                            ERROR(FORMAT(Error000), LeaveType.Code);
                        END;
                    END ELSE BEGIN
                        IF LeaveType."Eligible Staff" <> LeaveType."Eligible Staff"::All THEN BEGIN
                            //      END ELSE BEGIN
                            IF Employee."Employee Type" = Employee."Employee Type"::Permanent THEN BEGIN
                                ERROR(FORMAT(Error001), LeaveType.Code);
                            END;
                        END;
                    END;
                END;
            END;
        END;
    END;

    procedure ValidateLeaveTypeByConfirmationStatus(var LeaveApplication: Record "Leave Application");
    var
        LeaveType: Record "Leave Type";
        Employee: Record Employee;
        Error000: Label 'Leave Type %1 is only applicable to confirmed employees!';
    begin
        WITH LeaveApplication DO BEGIN
            IF LeaveType.GET("Leave Code") THEN BEGIN
                IF Employee.GET("Employee No.") THEN BEGIN
                    IF LeaveType."Employment Status" = LeaveType."Employment Status"::Confirmed THEN BEGIN
                        ///  IF Employee.Status=Employee.Status::Probation THEN BEGIN
                        //  ERROR(FORMAT(Error000),LeaveType.Code);
                        //   END;
                    END;
                END;
            END;
        END;
    end;

    procedure GetEarnedLeaveDays(EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Date: Date): Decimal;
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        EarnedDays: Decimal;
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE("Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETRANGE("Earned Leave Days", TRUE);
        LeaveLedgerEntry.SetRange("Leave Period", getLeavePeriod());
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                EarnedDays += (LeaveLedgerEntry.Days);
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
        EXIT(EarnedDays);
    end;

    procedure GetUsedLeaveDays(EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Date: Date): Decimal;
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        UsedDays: Decimal;
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE("Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETRANGE("Entry Type", LeaveLedgerEntry."Entry Type"::Negative);
        LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', Today);
        LeaveLedgerEntry.SetRange(lieu, false);
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                UsedDays += (LeaveLedgerEntry.Days);
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
        EXIT(UsedDays);
    end;

    procedure GetBalanceBroughtForward(EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Date: Date): Decimal;
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        BroughtForwardDays: Decimal;
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE("Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETRANGE("Leave Entry Type", LeaveLedgerEntry."Leave Entry Type"::"Balance Brought Forward");
        LeaveLedgerEntry.SetRange("Leave Period", getLeavePeriod());
        //LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', Today);
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                BroughtForwardDays += (LeaveLedgerEntry.Days);
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
        EXIT(BroughtForwardDays);
    end;

    procedure GetRecalledDays(EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Date: Date): Decimal;
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        RecalledDays: Decimal;
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE("Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETRANGE(Recall, TRUE);
        LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', today);
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                RecalledDays += (LeaveLedgerEntry.Days);
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
        EXIT(RecalledDays);
    end;

    procedure GetLostDays(EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Date: Date): Decimal;
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        LostDays: Decimal;
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE("Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETRANGE("Lost Days", TRUE);
        LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', Today);
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                LostDays += (LeaveLedgerEntry.Days);
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
        EXIT(LostDays);
    end;

    procedure GetAddedBackDays(EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Date: Date): Decimal;
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        AddedBackDays: Decimal;
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE("Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETRANGE("Added Back Days", TRUE);
        LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', today);
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                AddedBackDays += (LeaveLedgerEntry.Days);
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
        EXIT(AddedBackDays);
    end;

    procedure GetLeaveBalance(EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Date: Date): Decimal;
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        LeaveBalance: Decimal;
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE("Leave Code", LeaveCode);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETFILTER("Posting Date", '<=%1', today);
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                LeaveBalance += LeaveLedgerEntry.Days;
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
        EXIT(LeaveBalance);
    end;

    procedure CalculateLeaveEndDate(LeaveDays: Decimal; StartDate: Date): Date;
    var
        BaseCalendarChange: Record 7601;
        Days: Decimal;
        FullDays: Decimal;
        HalfDays: Decimal;
        EndDate: Date;
        Date: Record Date;
        HrSetup: Record "Human Resources Setup";

    begin
        HrSetup.Get();
        FullDays := LeaveDays DIV 1;
        HalfDays := LeaveDays MOD 1;
        Days := FullDays + HalfDays;
        EndDate := StartDate;
        WHILE Days > 1 DO BEGIN
            EndDate := CALCDATE('1D', EndDate);
            IF NOT CheckDateStatus(HrSetup."Base Calendar Code", EndDate, ChaiDescription) THEN
                Days -= 1;
        END;
        EXIT(EndDate);
    end;

    procedure CalculatePreviousEndDate(LeaveDays: Decimal; StartDate: Date): Date;
    var
        BaseCalendarChange: Record 7601;
        Days: Decimal;
        FullDays: Decimal;
        HalfDays: Decimal;
        EndDate: Date;
        Date: Record Date;
        HrSetup: Record "Human Resources Setup";

    begin
        HrSetup.Get();
        FullDays := LeaveDays DIV 1;
        HalfDays := LeaveDays MOD 1;
        Days := FullDays + HalfDays;
        EndDate := StartDate;
        WHILE Days > 1 DO BEGIN
            EndDate := CALCDATE('-1D', EndDate);
            IF NOT CheckDateStatus(HrSetup."Base Calendar Code", EndDate, ChaiDescription) THEN
                Days -= 1;
        END;
        EXIT(EndDate);
    end;

    procedure CalculateResumptionDate(var LeaveApplication: Record "Leave Application");
    var
        BaseCalendarChange: Record "Base Calendar Change";
    begin
        WITH LeaveApplication DO BEGIN
            "Resumption Date" := CALCDATE('1D', "End Date");
            BaseCalendarChange.RESET();
            IF BaseCalendarChange.FINDSET() THEN BEGIN
                REPEAT
                    IF BaseCalendarChange.Date = "Resumption Date" THEN BEGIN
                        "Resumption Date" := CALCDATE('1D', "Resumption Date");
                    END;
                UNTIL BaseCalendarChange.NEXT() = 0;
            END;
        END;
    end;

    procedure InsertLeaveLedgerEntry(Period: Code[10]; DocumentNo: Code[20]; EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Description: Text; Days: Decimal; EntryType: Option; LostDays: Boolean; EarnedDays: Boolean; BalanceBroughtForward: Boolean; RecalledDays: Boolean; AddedBackDays: Boolean; lieu: Boolean);
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        Employee: Record Employee;
    begin
        LeaveLedgerEntry.INIT();
        LeaveLedgerEntry."Posting Date" := TODAY;
        LeaveLedgerEntry."Document No" := DocumentNo;
        LeaveLedgerEntry."Leave Code" := LeaveCode;
        LeaveLedgerEntry."Leave Period" := Period;
        LeaveLedgerEntry."Employee No." := EmployeeNo;
        IF Employee.GET(EmployeeNo) THEN;
        LeaveLedgerEntry."Employee Name" := Employee.FullName();
        LeaveLedgerEntry.Description := Description;
        LeaveLedgerEntry."Entry Type" := EntryType;
        LeaveLedgerEntry."User ID" := USERID;
        LeaveLedgerEntry.Days := Days * -1;
        LeaveLedgerEntry."Lost Days" := LostDays;
        LeaveLedgerEntry."Added Back Days" := AddedBackDays;
        LeaveLedgerEntry."Balance Brought Forward" := BalanceBroughtForward;
        LeaveLedgerEntry."Earned Leave Days" := EarnedDays;
        if lieu = true then begin
            LeaveLedgerEntry."Leave Entry Type" := "Leave Entry Type"::"Balance Brought Forward";
        end;
        LeaveLedgerEntry.Recall := RecalledDays;
        LeaveLedgerEntry.Lieu := lieu;
        if LeaveLedgerEntry.Days <> 0 then
            LeaveLedgerEntry.Insert();
    end;

    procedure InsertEarnedLedgerEntry(Period: Code[10]; DocumentNo: Code[20]; EmployeeNo: Code[20]; LeaveCode: enum "Leave Type"; Description: Text; Days: Decimal; EntryType: Option; EntryLeaveType: Enum "Leave Entry Type");
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        Employee: Record Employee;
        LeaveJournal: Record "Leave Journal";
        EntryNo: Integer;
        LeaveLedgerEntry1: Record "Leave Ledger Entry";
        Leaves: Record "Leave Ledger Entry";
    begin

        LeaveLedgerEntry1.Reset();
        if LeaveLedgerEntry1.FindLast() then
            EntryNo := LeaveLedgerEntry1."Entry No." else
            EntryNo := 1;
        LeaveLedgerEntry.INIT();
        LeaveLedgerEntry."Entry No." := EntryNo + 1;
        LeaveLedgerEntry."Posting Date" := TODAY;
        LeaveLedgerEntry."Document No" := DocumentNo;
        LeaveLedgerEntry."Leave Code" := LeaveCode;
        LeaveLedgerEntry."Leave Period" := Period;
        LeaveLedgerEntry."Employee No." := EmployeeNo;
        IF Employee.GET(EmployeeNo) THEN;
        LeaveLedgerEntry."Employee Name" := Employee.FullName();
        LeaveLedgerEntry.Description := Description;
        LeaveLedgerEntry."Entry Type" := EntryType;
        LeaveLedgerEntry."User ID" := USERID;
        LeaveLedgerEntry.Days := Days;
        LeaveLedgerEntry."Leave Entry Type" := EntryLeaveType;
        if LeaveLedgerEntry."Leave Entry Type" = LeaveLedgerEntry."Leave Entry Type"::"Earned Days" then begin
            LeaveLedgerEntry."Earned Leave Days" := true;
            LeaveLedgerEntry.Recall := false;
            LeaveLedgerEntry."Balance Brought Forward" := false;
        end;
        if LeaveLedgerEntry."Leave Entry Type" = LeaveLedgerEntry."Leave Entry Type"::"Balance Brought Forward" then begin
            LeaveLedgerEntry."Balance Brought Forward" := true;
            LeaveLedgerEntry."Earned Leave Days" := false;
            LeaveLedgerEntry.Recall := false;
        end;
        if Days <> 0 then
            LeaveLedgerEntry.Insert();

    end;

    procedure PostLeavesJournal(var LeaveJournal: Record "Leave Journal");
    var
        Selected: Integer;
        LeaveDays: Codeunit "Leave Days";
        Text000: Label 'Balance Brought Forward,Added back days,Lost Days,Annual Leave, OtherLeaveDays';
        Text001: Label 'Please confirm the type of posting';
    begin
        Selected := 0;
        Selected := DIALOG.STRMENU(Text000, 4, Text001);
        IF Selected <> 0 THEN BEGIN
            WITH LeaveJournal DO BEGIN
                IF Selected = 1 THEN BEGIN
                    InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), FORMAT(DATE2DMY(TODAY, 3)), "Employee No.", "Leave Type", Description, Days * -1, "Entry Type"::Positive, FALSE, FALSE, TRUE, FALSE, FALSE, false);
                END;
                IF Selected = 2 THEN BEGIN
                    InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), FORMAT(DATE2DMY(TODAY, 3)), "Employee No.", "Leave Type", Description, Days * -1, "Entry Type"::Positive, FALSE, FALSE, FALSE, FALSE, TRUE, false);
                END;
                IF Selected = 3 THEN BEGIN
                    InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), FORMAT(DATE2DMY(TODAY, 3)), "Employee No.", "Leave Type", Description, Days * -1, "Entry Type"::Positive, TRUE, FALSE, FALSE, FALSE, FALSE, false);
                END;
                IF Selected = 4 THEN BEGIN
                    LeaveDays.Run();
                    LeaveJournal.Reset();
                    LeaveJournal.SetRange(Select, true);
                    if LeaveJournal.FindSet() then begin
                        repeat
                            LeaveJournal.DeleteAll();
                            exit;
                        until LeaveJournal.Next() = 0;
                    end;

                END;
                IF Selected = 5 THEN BEGIN
                    InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), FORMAT(DATE2DMY(TODAY, 3)), "Employee No.", "Leave Type", Description, Days * -1, "Entry Type"::Positive, false, true, FALSE, FALSE, FALSE, false);
                END;
                LeaveJournal.DELETE();
            END;
        END;
    end;

    procedure PostLeaveJournal(var LeaveJournal: Record "Leave Journal");
    var

    begin


    end;

    procedure CloseLeaveYear();
    var
        LeavePeriod: Record "Leave Period";
        LeavePeriod2: Record "Leave Period";
        Text000: Label 'Leave Period has been closed successfully!';
    begin
        LeavePeriod.RESET();
        LeavePeriod.SETRANGE(Closed, FALSE);
        LeavePeriod.SETRANGE("New Fiscal Year", TRUE);
        IF LeavePeriod.FINDFIRST() THEN BEGIN
            LeavePeriod2.RESET();
            LeavePeriod2.SETFILTER("Starting Date", '%1..%2', LeavePeriod."Starting Date", CALCDATE('11M', LeavePeriod."Starting Date"));
            IF LeavePeriod2.FINDSET() THEN BEGIN
                REPEAT
                    LeavePeriod2.Closed := TRUE;
                    LeavePeriod2."Date Locked" := TRUE;
                    LeavePeriod2.MODIFY();
                UNTIL LeavePeriod2.NEXT() = 0;
                MESSAGE(Text000);
            END;
            UpdateLeaveBalances(DATE2DMY(LeavePeriod."Starting Date", 3));
        END;
    end;

    // procedure AttachHRDocs(HumanResourceDoc: Record "Human Resource Doc");
    // var
    //     FileName: Text[500];
    //     FileName2: Text[500];
    //     docname: Text;
    //     docname2: Text;
    //     filecu: Codeunit "File Management";
    //     EmployeeDocuments: Record "Employee Document";
    //     HRSetup: Record "Human Resources Setup";
    //     DocPath: Text;
    //     Text000: Label 'Select HR Document';
    //     Text001: Label 'HR Document';
    //     Text002: Label 'PDF Files (*.PDF)|*.PDF|All Files (*.*)|*.*';
    //     Text003: Label '_HR_Document';
    // begin
    //     WITH HumanResourceDoc DO BEGIN

    //         HRSetup.RESET();
    //         HRSetup.GET();
    //         HRSetup.TESTFIELD("Employee Docs File Path");


    //         docname := Text001;
    //         docname2 := Text002;
    //         docname := CONVERTSTR(docname, '/', '_');
    //         docname := CONVERTSTR(docname, '\', '_');
    //         docname := CONVERTSTR(docname, ':', '_');
    //         docname := CONVERTSTR(docname, '.', '_');
    //         docname := CONVERTSTR(docname, ',', '_');
    //         docname := CONVERTSTR(docname, ' ', '_');
    //         docname := CONVERTSTR(docname, ' ', '_');
    //         docname2 := CONVERTSTR(docname2, '/', '_');
    //         docname2 := CONVERTSTR(docname2, '\', '_');
    //         docname2 := CONVERTSTR(docname2, ':', '_');
    //         docname2 := CONVERTSTR(docname2, '.', '_');
    //         docname2 := CONVERTSTR(docname2, ',', '_');
    //         docname2 := CONVERTSTR(docname2, ' ', '_');
    //         docname2 := CONVERTSTR(docname2, ' ', '_');


    //         FileName2 := HRSetup."Employee Docs File Path" + docname + '_' + docname2 + Text003 + '_' + filecu.GetFileName(FileName);

    //         //  filecu.CopyClientFile();

    //         HumanResourceDoc.RESET;
    //         HumanResourceDoc.SETRANGE("Document Name", filecu.GetFileName(FileName));
    //         IF HumanResourceDoc.FIND('-') THEN BEGIN
    //             ERROR(Text003);
    //         END;

    //         HumanResourceDoc.INIT;
    //         HumanResourceDoc."Document Path" := FileName2;
    //         HumanResourceDoc."Document Name" := filecu.GetFileName(FileName);
    //         HumanResourceDoc."Upload By" := USERID;
    //         HumanResourceDoc."Upload date" := TODAY;
    //         HumanResourceDoc."Upload Time" := TIME;
    //         HumanResourceDoc.INSERT(TRUE);
    //         MESSAGE(TEXT004);
    //     END;
    // end;

    // procedure ViewHRDocs(HumanResourceDoc: Record "Human Resource Doc");
    // var
    //     lastno: Integer;
    //     HRDocumentView: Record "HR Document View";
    //     TempBlob: Codeunit "Temp Blob";
    //     FileManagement: Codeunit "File Management";
    //     DocumentStream: OutStream;
    //     FullFileName: Text;
    // begin
    //     WITH HumanResourceDoc DO BEGIN
    //         IF CONFIRM(TEXT005) THEN BEGIN
    //             //   Message("Document Path");
    //             //HYPERLINK("Document Path");

    //             FullFileName := "Document Name";
    //             TempBlob.CreateOutStream(DocumentStream);
    //             //   "Document Reference ID".ExportStream(DocumentStream);
    //             FileManagement.BLOBExport(TempBlob, FullFileName, true);

    //             HRDocumentView.RESET;
    //             IF HRDocumentView.FINDLAST THEN BEGIN
    //                 lastno := HRDocumentView."No." + 1;
    //             END;

    //             HRDocumentView.INIT;
    //             HRDocumentView."No." := lastno;
    //             HRDocumentView.User := USERID;
    //             HRDocumentView."Document Name" := "Document Name";
    //             HRDocumentView.Date := CURRENTDATETIME;
    //             HRDocumentView."View Date" := TODAY;
    //             HRDocumentView.INSERT;
    //         END;
    //     END;
    // end;

    procedure UpdateLeaveBalances(LeavePeriodClosed: Integer);
    var
        Employee: Record Employee;
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        Balance: Decimal;
        Balance2: Decimal;
        LeaveType: Record "Leave Type";
        Text000: Label '"BF "';
        Text001: Label '"LOST DAYS "';
    begin
        LeaveType.RESET();
        LeaveType.SETFILTER("Max Carry Forward Days", '<>%1', 0);
        IF LeaveType.FINDSET() THEN BEGIN
            REPEAT
                Employee.RESET();
                //  Employee.SETRANGE("Employee Type", Employee."Employee Type"::Permanent);
                Employee.SETFILTER(Status, '<>%1', Employee.Status::Terminated);
                IF Employee.FINDSET() THEN BEGIN
                    REPEAT
                        Balance := 0;
                        Balance := GetLeaveBalance(Employee."No.", LeaveType.Code, TODAY);
                        IF Balance > 0 THEN BEGIN
                            Balance2 := Balance - LeaveType."Max Carry Forward Days";
                            IF Balance2 = 0 THEN BEGIN
                                InsertLeaveLedgerEntry(FORMAT(LeavePeriodClosed + 1), Text000 + FORMAT(LeavePeriodClosed), Employee."No.", LeaveType.Code, '', Balance, LeaveLedgerEntry."Entry Type"::Positive, FALSE, FALSE, TRUE, FALSE, FALSE, false);
                            END;
                            IF Balance2 > 0 THEN BEGIN
                                InsertLeaveLedgerEntry(FORMAT(LeavePeriodClosed + 1), Text000 + FORMAT(LeavePeriodClosed), Employee."No.", LeaveType.Code, '', LeaveType."Max Carry Forward Days", LeaveLedgerEntry."Entry Type"::Positive, FALSE, FALSE, TRUE, FALSE, FALSE, false);
                                InsertLeaveLedgerEntry(FORMAT(LeavePeriodClosed + 1), Text001 + FORMAT(LeavePeriodClosed), Employee."No.", LeaveType.Code, '', Balance2, LeaveLedgerEntry."Entry Type"::Positive, TRUE, FALSE, FALSE, FALSE, FALSE, false);
                            END;
                            IF Balance2 < 0 THEN BEGIN
                                InsertLeaveLedgerEntry(FORMAT(LeavePeriodClosed + 1), Text000 + FORMAT(LeavePeriodClosed), Employee."No.", LeaveType.Code, '', Balance, LeaveLedgerEntry."Entry Type"::Positive, FALSE, FALSE, TRUE, FALSE, FALSE, false);
                            END;
                        END ELSE BEGIN
                            InsertLeaveLedgerEntry(FORMAT(LeavePeriodClosed + 1), Text000 + FORMAT(LeavePeriodClosed), Employee."No.", LeaveType.Code, '', Balance, LeaveLedgerEntry."Entry Type"::Positive, FALSE, FALSE, TRUE, FALSE, FALSE, false);
                        END;
                        CloseLeaveEntries(Employee."No.", LeavePeriodClosed);
                    UNTIL Employee.NEXT() = 0;
                END;
            UNTIL LeaveType.NEXT() = 0;
        END;
    end;

    local procedure CloseLeaveEntries(EmployeeNo: Code[20]; LeavePeriod: Integer);
    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
    begin
        LeaveLedgerEntry.RESET();
        LeaveLedgerEntry.SETRANGE(Closed, FALSE);
        LeaveLedgerEntry.SETRANGE("Employee No.", EmployeeNo);
        LeaveLedgerEntry.SETFILTER("Leave Period", FORMAT(LeavePeriod));
        IF LeaveLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                LeaveLedgerEntry.Closed := TRUE;
                LeaveLedgerEntry.MODIFY();
            UNTIL LeaveLedgerEntry.NEXT() = 0;
        END;
    end;

    // procedure PostStaffMovement(var EmployeeMovement: Record "Employee Movement"); //LENAWASAE
    // var
    //     Employee: Record Employee;
    //     Text000: Label 'Staff %1 has been posted successfully!';
    // begin
    //     WITH EmployeeMovement DO BEGIN
    //         IF Employee.GET("Employee No.") THEN BEGIN
    //             Employee."Branch Code" := "New Branch Code";
    //             Employee.VALIDATE("Branch Code");
    //             Employee."Department Code" := "New Department Code";
    //             Employee.VALIDATE("Department Code");
    //             Employee."Employee Job Title" := "New Job Title";
    //             Employee.Grade := "New Grade";
    //             Employee.Validate(Grade);
    //             IF "New Salary" <> 0 THEN;
    //             Employee."Basic Pay" := "New Salary";
    //             Employee."Supervisor ID" := "Supervisor ID";
    //             Employee.Validate("Supervisor ID");
    //             Employee."Second Supervisor ID" := "Supervisor ID 1";
    //             Employee.Validate("Second Supervisor ID");
    //             Employee."Employee Level" := " New Employee Level";
    //             IF Employee.MODIFY() THEN BEGIN
    //                 "Posted By" := USERID;
    //                 "Posted Date" := TODAY;
    //                 "Posted Time" := TIME;
    //                 Status := Status::Posted;
    //                 MODIFY(true);
    //                 MESSAGE(FORMAT(Text000), Type);
    //             END else
    //                 Error('The movement cannot be processed');
    //         END;
    //     END;
    // end;

    // procedure ViewEmployeeData(Employee: Record 5200);
    // var
    //     lastno: Integer;
    //     EmployeeDataView: Record "Employee Data View";
    // begin
    //     WITH Employee DO BEGIN

    //         EmployeeDataView.INIT;
    //         EmployeeDataView.User := USERID;
    //         EmployeeDataView."Employee No" := "No.";
    //         EmployeeDataView."Employee Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
    //         EmployeeDataView.Date := TODAY;
    //         EmployeeDataView.Time := TIME;
    //         EmployeeDataView.INSERT;

    //     END;
    // end;

    // procedure GetCurrentAppraisalPeriod(): Code[100]; //LENAWASAE
    // var
    //     AppraisalPeriod: Record "Appraisal Period";
    // begin
    //     AppraisalPeriod.RESET;
    //     AppraisalPeriod.SETRANGE(Active, TRUE);
    //     IF AppraisalPeriod.FINDFIRST THEN
    //         EXIT(AppraisalPeriod.Code)
    //     ELSE
    //         Error('Kindly setup an active appraisal period');
    // end;

    // procedure GetCurrentAppraisalYear(): Integer; //LENAWASAE
    // var
    //     AppraisalPeriod: Record "Appraisal Period";
    // begin
    //     AppraisalPeriod.RESET;
    //     AppraisalPeriod.SETRANGE(Active, TRUE);
    //     IF AppraisalPeriod.FINDFIRST THEN
    //         EXIT(AppraisalPeriod.Year)
    //     ELSE
    //         Error('Kindly setup an active appraisal year');
    // end;

    // procedure CreateAuditTrail(var Employee: Record Employee); //LENAWASAE
    // var
    //     ApprovalEntry: Record 454;
    //     WorkflowRecordChange: Record "Workflow - Record Change";
    //     RecRef: RecordRef;
    //     EmployeeHRAuditTrail: Record "Employee HR Audit Trail";
    // begin
    //     WITH Employee DO BEGIN
    //         EmployeeHRAuditTrail.INIT;
    //         EmployeeHRAuditTrail."User ID" := USERID;
    //         EmployeeHRAuditTrail.Type := EmployeeHRAuditTrail.Type::Change;
    //         EmployeeHRAuditTrail."Employee No" := "No.";
    //         EmployeeHRAuditTrail."Employee Name" := Employee.FullName();
    //         EmployeeHRAuditTrail."Change Date" := TODAY;
    //         EmployeeHRAuditTrail."Change Time" := TIME;
    //         EmployeeHRAuditTrail.Status := EmployeeHRAuditTrail.Status::"Approval Pending";
    //         EmployeeHRAuditTrail.INSERT(TRUE);
    //     END;
    // end;

    // procedure UpdateAuditTrail(WorkflowStepInstance: Record "Workflow Step Instance"; Stage: Integer);
    // var
    //     ApprovalEntry: Record 454;
    //     WorkflowRecordChange: Record "Workflow - Record Change";
    //     RecRef: RecordRef;
    //     EmployeeHRAuditTrail: Record "Employee HR Audit Trail";
    //     Employee: Record Employee;
    // begin
    //     WITH WorkflowStepInstance DO BEGIN
    //         WorkflowRecordChange.RESET();
    //         WorkflowRecordChange.SETRANGE("Workflow Step Instance ID", ID);
    //         IF WorkflowRecordChange.FINDFIRST() THEN BEGIN
    //             EmployeeHRAuditTrail.RESET;
    //             EmployeeHRAuditTrail.SETRANGE("User ID", USERID);
    //             EmployeeHRAuditTrail.SETRANGE("Change Date", TODAY);
    //             IF EmployeeHRAuditTrail.FINDLAST THEN BEGIN
    //                 WorkflowRecordChange.CALCFIELDS("Field Caption");
    //                 EmployeeHRAuditTrail."Field Caption" := WorkflowRecordChange."Field Caption";
    //                 EmployeeHRAuditTrail."Old Value" := WorkflowRecordChange."Old Value";
    //                 EmployeeHRAuditTrail."New Value" := WorkflowRecordChange."New Value";
    //                 CASE Stage OF
    //                     1:
    //                         BEGIN
    //                             EmployeeHRAuditTrail.Status := EmployeeHRAuditTrail.Status::Approved;
    //                             EmployeeHRAuditTrail."Approval Date" := TODAY;
    //                             EmployeeHRAuditTrail."Approval Time" := TIME;
    //                             EmployeeHRAuditTrail.Approver := USERID;
    //                         END;
    //                     2:
    //                         BEGIN
    //                             EmployeeHRAuditTrail.Status := EmployeeHRAuditTrail.Status::Rejected;
    //                             EmployeeHRAuditTrail."Approval Date" := TODAY;
    //                             EmployeeHRAuditTrail."Approval Time" := TIME;
    //                             EmployeeHRAuditTrail.Approver := USERID;
    //                         END;
    //                 END;
    //                 EmployeeHRAuditTrail.MODIFY(TRUE);
    //             END;
    //         END;
    //     END;
    // end;

    // procedure UpdateSeparationInfo(HRSeparation: Record Separation); //LENAWASAE
    //     Employee: Record Employee;
    //     Text000: Label '%1-%2 has been separated successfully.';
    // begin
    //     WITH HRSeparation DO BEGIN
    //         IF CONFIRM(TEXT007) THEN BEGIN
    //             IF "Separation Status" = "Separation Status"::Processing THEN BEGIN
    //                 "Separation Status" := "Separation Status"::Processed;
    //                 Status := Status::Approved;
    //                 IF Employee.GET("Employee No.") THEN;
    //                 Employee.Status := Employee.Status::Terminated;
    //                 Employee."Employee Status" := Employee."Employee Status"::Terminated;
    //                 Employee.Status := Employee.Status::Terminated;
    //                 if "Last Working Date(Employee)" = 0D then
    //                     Employee."Termination Date" := "Last Working Date(Employer)"
    //                 else
    //                     Employee."Termination Date" := "Last Working Date(Employee)";
    //                 Employee.MODIFY();
    //                 Employee.MODIFY();
    //                 IF MODIFY(TRUE) THEN BEGIN
    //                     MESSAGE(Text000, "Separation No", "Employee Name");
    //                 END;
    //             END;
    //         END;
    //     END;
    // end;

    /*
                      procedure ConfirmationMail(var Employee: Record 5200);
                      var
                          Text000: Label '%1 Confirmation Letter.pdf';
                          Text001: Label 'C:\Program Files\Microsoft Dynamics NAV\100\Web Client\Pics\';
                          ConfirmationLetter: Report 50286;
                          FileName: Text;
                          Text002: Label 'CONFIMATION LETTER';
                          Text003: Label 'Dear %1, </br>We are glad to inform you that you have been successfully confirmed upon successful completion of your probation period. </br>Please find the attached document with the details of your confirmation.</br>Kind Regards,';
                      begin
                          WITH Employee DO BEGIN
                              CLEARLASTERROR;
                              HumanResourcesSetup.GET;
                              CLEAR(ConfirmationLetter);
                              ConfirmationLetter.USEREQUESTPAGE(FALSE);
                              FileName := HumanResourcesSetup."File Path" + STRSUBSTNO(Text000, Employee.FullName);
                              IF ConfirmationLetter.SAVEASPDF(FileName) THEN BEGIN
                                  SendMail(Employee."E-Mail", Text002, STRSUBSTNO(Text003, Employee.FullName), Text002, FileName);
                              END ELSE
                                  MESSAGE(GETLASTERRORTEXT);
                          END;
                      end;

                      procedure ExtensionMail(var Employee: Record 5200);
                      begin
                      end;
          */
    // procedure CloseAppraisalPeriod(); //LENAWASAE
    // var
    //     Text000: Label 'Are you sure you want to close appraisal period %1 %2?';
    //     Text001: Label 'Appraisal Period %1 %2 has been closed successfully';
    //     AppraisalPeriod: Record "Appraisal Period";
    // begin
    //     AppraisalPeriod.RESET;
    //     AppraisalPeriod.SETRANGE(Active, TRUE);
    //     IF AppraisalPeriod.FINDFIRST THEN BEGIN
    //         IF CONFIRM(STRSUBSTNO(Text000, AppraisalPeriod.Code, AppraisalPeriod.Year)) THEN BEGIN
    //             AppraisalPeriod.Active := FALSE;
    //             AppraisalPeriod.Closed := TRUE;
    //             AppraisalPeriod.MODIFY;
    //             MESSAGE(STRSUBSTNO(Text001, AppraisalPeriod.Code, AppraisalPeriod.Year));
    //         END;
    //     END;
    // end;

    // procedure FetchJobCompetencyLines(var EmployeeNo: code[20]; var EmpPosition: Text; var Year: Integer; var Period: code[30]; var ReviewNo: Code[20]); //LENAWASAE
    // var
    //     PerformanceContract: Record "Performance Contract";
    //     QuantitativeGoals: Record "Quantitative Goals Line";
    //     QualitativeGoals: Record "Qualitative Goals Line";
    //     PerformanceCompetencyLineQt: Record "Performance Competency Line-Qt";
    //     PerformanceCompetencyLineQl: Record "Performance Competency Line-Ql";
    //     entryno: decimal;
    // begin
    //     PerformanceContract.RESET;
    //     PerformanceContract.SetRange("Appraisal Year", Year);
    //     PerformanceContract.SETrange("Appraisal Code", Period);
    //     PerformanceContract.SetRange("Employee No.", EmployeeNo);
    //     performanceContract.setrange(Submitted, true);
    //     IF PerformanceContract.FINDFIRST THEN BEGIN
    //         QuantitativeGoals.RESET;
    //         QuantitativeGoals.SETRANGE("No.", PerformanceContract."No.");
    //         IF QuantitativeGoals.FINDSET THEN BEGIN
    //             REPEAT
    //                 PerformanceCompetencyLineQT.reset;
    //                 if PerformanceCompetencyLineQt.findlast then
    //                     entryno := PerformanceCompetencyLineQt."Entry No." + 1;
    //                 PerformanceCompetencyLineQt.INIT;
    //                 PerformanceCompetencyLineQt.Period := Period;
    //                 PerformanceCompetencyLineQt."Employee No." := EmployeeNo;
    //                 PerformanceCompetencyLineQt."Review No." := ReviewNo;
    //                 PerformanceCompetencyLineQt.Code := QuantitativeGoals.Code;
    //                 PerformanceCompetencyLineQt.VALIDATE(Code);
    //                 PerformanceCompetencyLineQt.Objectives := QuantitativeGoals.Objectives;
    //                 PerformanceCompetencyLineQt.Indicators := QuantitativeGoals.Indicators;
    //                 PerformanceCompetencyLineQt."Action Plans" := QuantitativeGoals."Action Plans";
    //                 PerformanceCompetencyLineQt."Agreed Weighting" := QuantitativeGoals."Agreed Weighting";
    //                 PerformanceCompetencyLineQt."Entry No." := entryno;
    //                 PerformanceCompetencyLineQt.INSERT;
    //             UNTIL QuantitativeGoals.NEXT = 0;
    //         END;
    //         QualitativeGoals.RESET;
    //         QualitativeGoals.SETRANGE("No.", PerformanceContract."No.");
    //         IF QualitativeGoals.FINDSET THEN BEGIN
    //             REPEAT
    //                 PerformanceCompetencyLineQl.INIT;
    //                 PerformanceCompetencyLineQl.Period := Period;
    //                 PerformanceCompetencyLineQl."Employee No." := EmployeeNo;
    //                 PerformanceCompetencyLineQl."Review No." := ReviewNo;
    //                 PerformanceCompetencyLineQl.Code := QualitativeGoals.Code;
    //                 PerformanceCompetencyLineQl.VALIDATE(Code);
    //                 PerformanceCompetencyLineQl.INSERT;
    //             UNTIL QualitativeGoals.NEXT = 0;
    //         END;
    //     END;
    // END;

    procedure CheckDateStatus(CalendarCode: Code[10]; TargetDate: Date; VAR Description: Text[50]): Boolean
    var
        BaseCalChange: Record "Base Calendar Change";
    begin
        BaseCalChange.RESET();
        BaseCalChange.SETRANGE("Base Calendar Code", CalendarCode);
        IF BaseCalChange.FINDSET() THEN
            REPEAT
                CASE BaseCalChange."Recurring System" OF
                    BaseCalChange."Recurring System"::" ":
                        IF TargetDate = BaseCalChange.Date THEN BEGIN
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                    BaseCalChange."Recurring System"::"Weekly Recurring":
                        IF DATE2DWY(TargetDate, 1) = BaseCalChange.Day THEN BEGIN
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                    BaseCalChange."Recurring System"::"Annual Recurring":
                        IF (DATE2DMY(TargetDate, 2) = DATE2DMY(BaseCalChange.Date, 2)) AND
                           (DATE2DMY(TargetDate, 1) = DATE2DMY(BaseCalChange.Date, 1))
                        THEN BEGIN
                            Description := BaseCalChange.Description;
                            EXIT(BaseCalChange.Nonworking);
                        END;
                END;
            UNTIL BaseCalChange.NEXT() = 0;
        Description := '';
    end;

    // local procedure GetHostInfo()
    // var
    //     Dns: DotNet Dns;
    //     GetIPMac2: DotNet GetIPMac;
    //     IPHostEntry: DotNet IPHostEntry;
    //     IPAddress: DotNet IPAddress;
    // begin
    //     HostName := Dns.GetHostName();
    //     Clear(GetIPMac2);
    //     GetIPMac2 := GetIPMac2.GetIPMac();
    //     HostIP := GetIPMac2.GetIP(HostName);
    //     HostMac := GetIPMac2.GetMac();
    // end;

    procedure CaptureChangeRequest(TableID: Integer; ChangeType: Option; KeyValue: Text; FieldNo: Integer; Caption: Text; OldValue: Text; NewValue: Text; OldImage: Text; NewImage: Text)
    var
        HRRAuditTrail: Record "HR Audit Trail";
        HRRAuditTrail2: Record "HR Audit Trail";
        HRSetup: Record "Human Resources Setup";
        NoSeries: Codeunit "No. Series";
        RecRef: RecordRef;
        Bytes: DotNet Array;
        Convert: DotNet Convert;
        MemoryStream: DotNet MemoryStream;
    begin
        HRRAuditTrail.Init();
        HRSetup.GET();
        HRSetup.TestField("HR Audit Nos.");
        HRRAuditTrail."Entry No." := NoSeries.GetNextNo(HRSetup."HR Audit Nos.", Today, true);
        RecRef.Open(TableID);
        HRRAuditTrail."Table ID" := TableID;
        HRRAuditTrail."Table Name" := RecRef.Caption;
        HRRAuditTrail."Primary Key Value" := KeyValue;
        HRRAuditTrail.UserId := UserId;
        HRRAuditTrail."Type of Change" := ChangeType;
        HRRAuditTrail."Field No." := FieldNo;
        HRRAuditTrail."Field Caption" := Caption;
        HRRAuditTrail."Old Value" := OldValue;
        HRRAuditTrail."New Value" := NewValue;
        if OldImage <> '' then begin
            Bytes := Convert.FromBase64String(OldImage);
            MemoryStream := MemoryStream.MemoryStream(Bytes);
            HRRAuditTrail."Old Image".IMPORTSTREAM(MemoryStream, 'OldPicture', 'image/jpg');
        end;
        if NewImage <> '' then begin
            Bytes := Convert.FromBase64String(NewImage);
            MemoryStream := MemoryStream.MemoryStream(Bytes);
            HRRAuditTrail."New Image".IMPORTSTREAM(MemoryStream, 'NewPicture', 'image/jpg');
        end;
        HRRAuditTrail."Change Date" := Today;
        HRRAuditTrail."Change Time" := Time;
        //GetHostInfo();
        HRRAuditTrail."Change IP Address" := HostIP;
        HRRAuditTrail."Change MAC Address" := HostMAC;
        HRRAuditTrail.Status := HRRAuditTrail.Status::"Pending Approval";
        HRRAuditTrail.Insert();
    end;

    // procedure CheckifEntryExists(TableID: Integer; FieldNo: Integer; PrimaryKey: Code[20]; NewValue: text): boolean //LENAWASAE
    // var
    //     HRRAuditTrail: Record "Change Audit Trail";
    // begin
    //     HRRAuditTrail.Reset();
    //     HRRAuditTrail.SetRange(Status, HRRAuditTrail.Status::"Pending Approval");
    //     HRRAuditTrail.SetRange("Table ID", TableID);
    //     HRRAuditTrail.SetRange("Field No.", FieldNo);
    //     HRRAuditTrail.SetRange("Primary Key Value", PrimaryKey);
    //     if HRRAuditTrail.FindFirst() then begin
    //         exit(true);
    //     end else
    //         exit(false);

    // end;

    procedure ApproveChangeRequest(var HRRAuditTrail: Record "HR Audit Trail")
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        RecordID: RecordId;
        NewDateValue: Date;
        NewDecimalValue: Decimal;
        NewOptionValue: Text;
        NewEnumValue: Text;
        Text000: Label 'Change Approved Successfully';
    begin
        with HRRAuditTrail do begin
            RecRef.OPEN("Table ID");
            FieldRef := RecRef.Field(1);
            FieldRef.Value := "Primary Key Value";
            FieldRef.SetRange("Primary Key Value");
            if RecRef.FindFirst() then begin
                FieldRef := RecRef.Field(50069);
                FieldRef.Value := true;
                FieldRef := RecRef.Field("Field No.");
                if FieldRef.Type = FieldRef.Type::Date then begin
                    Evaluate(NewDateValue, "New Value");
                    FieldRef.Validate(NewDateValue);
                end;
                if FieldRef.Type = FieldRef.Type::Decimal then begin
                    Evaluate(NewDecimalValue, "New Value");
                    FieldRef.Validate(NewDecimalValue);
                end;
                if FieldRef.Type = FieldRef.Type::Option then begin
                    Evaluate(NewEnumValue, "New Value");
                    FieldRef.Value := NewEnumValue;

                end;
                if FieldRef.Type = FieldRef.Type::Option then begin
                    Evaluate(NewOptionValue, "New Value");
                    FieldRef.Value := NewOptionValue;
                    // FieldRef.Validate(NewOptionValue);
                end;
                if (FieldRef.Type = FieldRef.Type::Code) or (FieldRef.Type = FieldRef.Type::Text) then begin
                    FieldRef.Validate("New Value");
                end;
                if FieldRef.Type = FieldRef.Type::Media then begin
                    FieldRef.Validate("New Image");
                end;
            end;
            FieldRef := RecRef.Field(50069);
            FieldRef.Value := false;
            RecRef.Modify();

            Status := Status::Approved;
            "Approved By" := UserId;
            "Approved Date" := Today;
            "Approved Time" := Time;
            //GetHostInfo();
            "Approved IP Address" := HostIP;
            "Approved MAC Address" := HostMAC;
            Modify();

            Message(Text000);
        end;
    end;

    procedure RejectChangeRequest(var HRRAuditTRail: Record "HR Audit Trail")
    var
        Text000: Label 'Change Rejected Successfully';
    begin
        with HRRAuditTrail do begin
            Status := Status::Rejected;
            "Approved By" := UserId;
            "Approved Date" := Today;
            "Approved Time" := Time;
            //GetHostInfo();
            "Approved IP Address" := HostIP;
            "Approved MAC Address" := HostMAC;
            Modify();
            Message(Text000);
        end;
    end;

    // procedure "Shortlist Applicants"(RecruitmentCode: Code[10]); //LENAWASAE
    // var
    //     JobApplications: Record "Job Application";
    //     RecruitmentRequest: Record "Recruitment Request";
    // begin
    //     IF RecruitmentRequest.GET(RecruitmentCode) THEN BEGIN
    //         JobApplications.RESET;
    //         JobApplications.SETRANGE("Recruitment Request No.", RecruitmentCode);
    //         JobApplications.SETFILTER("No. Years of Experience", '>=%1', RecruitmentRequest."No. of Years of Experience");
    //         JobApplications.SETFILTER("Level of Education", RecruitmentRequest."Level of Education");
    //         IF JobApplications.FINDSET THEN BEGIN
    //             REPEAT
    //                 JobApplications.Status := JobApplications.Status::Shortlisted;
    //                 JobApplications.MODIFY;
    //             UNTIL JobApplications.NEXT = 0;
    //             MESSAGE(TEXT006);
    //         END;
    //     END;
    // end;


    procedure "Assign Employee Number"(ApplicationNo: Code[10]);
    var
        Employee: Record Employee;
        HumanREsourceSetup: Record "Human Resources Setup";
        NoSeries: Codeunit "No. Series";
        EmployeeNo: Code[50];
    begin
        Employee.RESET();
        Employee.SetRange("No.", ApplicationNo);
        IF Employee.FindFirst() THEN BEGIN
            IF (COPYSTR(Employee."No.", 1, 4) = 'APPL') THEN BEGIN
                IF Employee."Employee Type" = Employee."Employee Type"::Permanent THEN BEGIN
                    HumanResourceSetup.GET();
                    EmployeeNo := NoSeries.GetNextNo(HumanREsourceSetup."Permanant Employee Nos", 0D, TRUE);
                    IF Employee.Rename(EmployeeNo) THEN
                        Message(TEXT009);
                END ELSE
                    IF Employee."Employee Type" = Employee."Employee Type"::Contract THEN BEGIN
                        HumanResourceSetup.GET();
                        EmployeeNo := NoSeries.GetNextNo(HumanREsourceSetup."Contract Employee Nos", 0D, TRUE);
                        IF Employee.Rename(EmployeeNo) THEN
                            Message(TEXT009);
                    END ELSE
                        IF Employee."Employee Type" = Employee."Employee Type"::Intern THEN BEGIN
                            HumanResourceSetup.GET();
                            EmployeeNo := NoSeries.GetNextNo(HumanREsourceSetup."Intern Nos.", 0D, TRUE);
                            IF Employee.Rename(EmployeeNo) THEN
                                Message(TEXT009);
                        END;
            END ELSE
                Message(TEXT008);
        END;
    END;

    procedure AddAttachment(RecordID: Text[50]; DocumentNo: Code[20]; FileName: Text[200])
    var
        CBSAttachment: Record "HR Attachment";
        CBSAttachment2: Record "HR Attachment";
        EntryNo: Integer;
    begin
        CBSAttachment2.Reset();
        IF CBSAttachment2.FINDLAST THEN
            EntryNo := CBSAttachment2."Entry No."
        ELSE
            EntryNo := 0;
        CBSAttachment.Init();
        CBSAttachment."Entry No." := EntryNo + 1;
        CBSAttachment.RecordID := RecordID;
        CBSAttachment."Document No." := DocumentNo;
        CBSAttachment."File Name" := FileName;
        CBSAttachment.Attachment.IMPORT(FileName);
        CBSAttachment.INSERT;
    end;

    procedure CreateWithoutAttachmentMessage(SenderName: Text; SenderAddress: Text; Recipients: Text; Subject: Text; Body: Text)
    var
        Mail: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        //Recipients := 'josephine.machage@tangazoletu.com';
        Mail.Create(Recipients, Subject, Body, true);
        Email.Send(Mail, Enum::"Email Scenario"::Default);
    end;

    procedure NotifyMember(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE APPLICATION REQUEST: %1';
        Text0002: Label 'Dear %1 <br><br> Your Leave Application Request No<b> %2 </b> for %3 days from %4 to %5 has been forwarded to <b>%6 </b> for approval.<br><br> Kind Regards,<br><br> Human Resources Department<br><br> %7 <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";
        UserSetup: Record "User Setup";
    //Default: Codeunit "Default Management";
    begin
        Dialogue.Open('Sending Mail to Employee Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Employee.Reset();
        Employee.Get(LeaveApplication."Employee No.");
        // UserSetup.GET(LeaveApplication."Employee No.");
        UserSetup.RESET();
        UserSetup.SETRANGE("Employee No.", LeaveApplication."Employee No.");
        if UserSetup.findfirst() then begin
            Recipients := UserSetup."E-Mail";
        end;
        // Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, LeaveApplication."Employee Name", LeaveApplication."No.", LeaveApplication."Days Applied", LeaveApplication."Start Date", LeaveApplication."End Date", LeaveApplication."First Approver");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        Dialogue.Close();
    end;

    procedure NotifyFirstApprover(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE APPLICATION REQUEST : %1';
        Text0002: Label 'The following leave application request has been forwarded to you for approval. <br><br> Leave Application No <b> %1:%2 </b> for %3-%4 who has applied for %5 days from <b>%6</b> to <b>%7</b>.<br><br> Kind Regards,<br><br> %8 <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";
        UserSetup: Record "User Setup";
    //Default: Codeunit "Default Management";
    begin
        Dialogue.Open('Sending Mail to the first approver Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        UserSetup.GET(LeaveApplication."First Approver");
        Recipients := UserSetup."E-Mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, LeaveApplication."No.", LeaveApplication."Leave Code", LeaveApplication."Employee No.", LeaveApplication."Employee Name", LeaveApplication."Approved Days", LeaveApplication."Approved Start Date", LeaveApplication."Approved End Date");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        Dialogue.Close();
    end;

    procedure NotifySecondApprover(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE APPLICATION FINAL APPROVAL: %1';
        Text0002: Label 'The following leave application request has been forwarded to you for approval. <br><br> Leave Application No <b> %1:%2 </b> for %3-%4 who has applied for %5 days from <b>%6</b> to <b>%7</b>.<br><br> Kind Regards,<br><br>%8 <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";
        UserSetup: Record "User Setup";
    //Default: Codeunit "Default Management";
    begin
        Dialogue.Open('Sending Mail to the second approver Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        UserSetup.GET(LeaveApplication."Second Approver");
        Recipients := UserSetup."E-Mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, LeaveApplication."No.", LeaveApplication."Leave Code", LeaveApplication."Employee No.", LeaveApplication."Employee Name", LeaveApplication."Approved Days", LeaveApplication."Approved Start Date", LeaveApplication."Approved End Date");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        Dialogue.Close();
    end;

    procedure NotifyMemberOnSecondApprover(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE APPLICATION REQUEST: %1';
        Text0002: Label 'Dear %1 <br><br> Your Leave Application Request No<b> %2 </b> for %3 days from %4 to %5 has been forwarded to <b>%6 </b> for approval.<br><br> Kind Regards,<br><br> Mentor Sacco Society<br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";
        UserSetup: Record "User Setup";
    begin
        Dialogue.Open('Sending Mail to Employee Notifying him/her of the leave application status');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Employee.Reset();
        Employee.Get(LeaveApplication."Employee No.");
        UserSetup.RESET();
        UserSetup.SETRANGE("Employee No.", LeaveApplication."Employee No.");
        if UserSetup.findfirst() then begin
            Recipients := UserSetup."E-Mail";
        end;
        //  Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, LeaveApplication."Employee Name", LeaveApplication."No.", LeaveApplication."Approved Days", LeaveApplication."Approved Start Date", LeaveApplication."Approved End Date", LeaveApplication."Second Approver");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        Dialogue.Close();
    end;

    procedure NotifyHR(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE APPLICATION REQUEST: %1';
        Text0002: Label 'Please note that Employee No %1-%2 is scheduled to go on leave for %3 day(s) from %4 to %5.<br><br> Kind Regards,<br><br> %6 <br><br> Mentor Sacco Society<br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";

    begin
        Dialogue.Open('Sending Mail to Employee Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Employee.Reset();
        Employee.Get(LeaveApplication."Employee No.");
        Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, Employee."No.", LeaveApplication."Employee Name", LeaveApplication."Approved Days", LeaveApplication."Approved Start Date", LeaveApplication."Approved End Date", Employee.FullName());
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        Dialogue.Close();
    end;

    procedure NotifyMemberApproval(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE APPLICATION REQUEST: %1';
        Text0002: Label 'Dear %1 <br><br> Please Note that your leave request has been approved. Your Leave type: <b> %2 </b> of %3 day(s) is to start on <b> %4 </b> and end on <b> %5 </b>.<br><br> Kind Regards,<br><br> Mentor Sacco Society Ltd <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";

    begin
        Dialogue.Open('Sending Mail to Employee Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Employee.Reset();
        Employee.Get(LeaveApplication."Employee No.");
        Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, Employee.FullName(), LeaveApplication."Leave Code", LeaveApplication."Approved Days", LeaveApplication."Approved Start Date", LeaveApplication."Approved End Date");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        Dialogue.Close();
    end;

    procedure NotifyLeavePlanEmployee(LeaveNo: Code[20]; LeaveCode: enum "Leave Type"; LeaveDays: Decimal; StartDate: Date; EndDate: Date; EmployeeNo: Code[20])
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE PLAN NOTIFICATION: %1';
        Text0002: Label 'Dear %1 <br><br> Dear <b>%1,</b> <br><br> Please Note that as per your submitted leave plan of leave type %2 you are supposed to go on leave for %3 day(s) from %4 to %5. Kindly log into your system to send your leave application for approval.<br><br> Kind Regards,<br><br> Human Resources Department<br><br> Mentor Sacco Society Ltd <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";

    begin
        //  Dialogue.Open('Sending Mail to Employee Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Employee.Reset();
        Employee.Get(EmployeeNo);
        Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveNo);
        Mailbody := StrSubstNo(Text0002, Employee.FullName(), LeaveCode, LeaveDays, StartDate, EndDate);
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        Dialogue.Close();
    end;

    procedure NotifyEmployeeRecall(LeaveRecall: Record "Leave Recall")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE RECALL NOTIFICATION: %1';
        Text0002: Label 'Dear %1 <br><br> Please Note that you have been recalled to work from <b>%2</b> to <b>%3</b>.<br><br> Kindly note that the unutilized %4 day(s) have been reimbursed.<br><br> Kind Regards,<br><br> Human Resources Department<br><br> %5 <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";
    //Default: Codeunit "Default Management";
    begin
        //  Dialogue.Open('Sending Mail to Employee Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Employee.Reset();
        Employee.Get(LeaveRecall."Employee No");
        Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveRecall."No.");
        Mailbody := StrSubstNo(Text0002, Employee.FullName(), LeaveRecall."Recalled From", LeaveRecall."Recalled To", LeaveRecall."Remaining Days");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        // Dialogue.Close();
    end;

    procedure NotifyHRonProbation(EmployeeNo: Code[20]; EmployeeName: Text[100]; EmployeeEmail: Text[80])
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'END OF PROBATION NOTIFICATION';
        Text0002: Label 'Please Note that %1-%2''s probation period has ended. Kindly log into the system and update his/her employee status.<br><br> Kind Regards,<br><br> Human Resources Department<br><br> Mentor Sacco Society Ltd <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";

    begin
        //  Dialogue.Open('Sending Mail to Employee Notifying him/her of the leave application');
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Recipients := EmployeeEmail;
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001);
        Mailbody := StrSubstNo(Text0002, EmployeeNo, EmployeeName);
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
        // Dialogue.Close();
    end;

    procedure NotifyPayrollDept(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE ALLOWANCE PAYABLE NOTIFICATION';
        Text0002: Label 'Dear Payroll Department, <br><br> Please Note that %1''s leave allowance payable has been attained. Kindly reach out to him/her. Kind Regards,<br><br> Mentor Sacco Society Ltd <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";
    //PayrollSetup: Record "CBS Payroll Setup";
    begin
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        //PayrollSetup.Get();
        //PayrollSetup.TestField();
        Employee.Reset();
        Employee.Get(LeaveApplication."Employee No.");
        Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, Employee.FullName(), LeaveApplication."Leave Code", LeaveApplication."Approved Days", LeaveApplication."Approved Start Date", LeaveApplication."Approved End Date");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
    end;

    procedure NotifyHRDept(LeaveApplication: Record "Leave Application")
    var
        mailheader: Text;
        Mailbody: Text;
        Sendername: Text;
        Text0001: Label 'LEAVE ALLOWANCE PAYABLE NOTIFICATION';
        Text0002: Label 'Dear HR Department, <br><br> Please Note that %1''s leave allowance payable has been attained. Kindly reach out to him/her. Kind Regards,<br><br> Mentor Sacco Society Ltd <br><br>';
        SenderAddress: Text;
        Recipients: Text;
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        Leaveworkflow: Record "Leave WorkFlow Setup";
    begin
        HRSetup.GET();
        HRSetup.TestField("HR E-Mail");
        Employee.Reset();
        Employee.Get(LeaveApplication."Employee No.");
        Recipients := Employee."E-mail";
        SenderAddress := HRSetup."HR E-Mail";
        mailheader := StrSubstNo(Text0001, LeaveApplication."No.");
        Mailbody := StrSubstNo(Text0002, Employee.FullName(), LeaveApplication."Leave Code", LeaveApplication."Approved Days", LeaveApplication."Approved Start Date", LeaveApplication."Approved End Date");
        CreateWithoutAttachmentMessage(Sendername, SenderAddress, Recipients, mailheader, Mailbody);
    end;

    /* procedure InsertEmployeeMembershipDetails(ApplicationNo: Code[90]) //LENAWASAE
     var
         NewEmployeeApplication: Record "New Employee Application";
         NewEmployeeRelative: Record "New Employee Relative";
         EmployeeRelative: Record "Employee Relative";
         NoseriesManagement: Codeunit "No. Series";
         Employee: Record Employee;
         HumanResourceSetup: Record "Human Resources Setup";
         EmployeeNo: code[100];
         LineNo: Integer;
         ProffessionalMembership: Record "Proffessional Membership";
         ProffessionalMemberships: Record "Proffessional Memberships";

     begin
         NewEmployeeApplication.RESET;
         NewEmployeeApplication.SETRANGE("No.", ApplicationNo);
         if NewEmployeeApplication.FindFirst() then begin
             IF NewEmployeeApplication."Employee Type" = NewEmployeeApplication."Employee Type"::Permanent THEN BEGIN
                 HumanResourceSetup.GET();
                 EmployeeNo := NoseriesManagement.GetNextNo(HumanREsourceSetup."Permanant Employee Nos", 0D, TRUE);
             END ELSE
                 IF NewEmployeeApplication."Employee Type" = NewEmployeeApplication."Employee Type"::Contract THEN BEGIN
                     HumanResourceSetup.GET();
                     EmployeeNo := NoseriesManagement.GetNextNo(HumanREsourceSetup."Contract Employee Nos", 0D, TRUE);
                 END ELSE
                     IF NewEmployeeApplication."Employee Type" = NewEmployeeApplication."Employee Type"::Intern THEN BEGIN
                         HumanResourceSetup.GET();
                         EmployeeNo := NoseriesManagement.GetNextNo(HumanREsourceSetup."Intern Nos.", 0D, TRUE);
                     END else
                         IF NewEmployeeApplication."Employee Type" = NewEmployeeApplication."Employee Type"::"Micro Credit Officers" THEN BEGIN
                             HumanResourceSetup.GET();
                             EmployeeNo := NoseriesManagement.GetNextNo(HumanREsourceSetup."MCO Nos", 0D, TRUE);
                         END;
             if EmployeeNo = '' then
                 error('Employee Number not assigned');
             Employee."No." := EmployeeNo;
             Employee."First Name" := NewEmployeeApplication."First Name";
             Employee."Last Name" := NewEmployeeApplication."Last Name";
             Employee."Middle Name" := NewEmployeeApplication."Middle Name";
             //Employee.FullName() := NewEmployeeApplication.FullName();
             Employee.Gender := NewEmployeeApplication.Gender;
             Employee."Date of Birth" := NewEmployeeApplication."Date of Birth";
             Employee.Age := NewEmployeeApplication.Age;
             Employee."Marital Status" := NewEmployeeApplication."Marital Status";
             Employee.Disability := NewEmployeeApplication.Disability;
             Employee."Blood Type" := NewEmployeeApplication."Blood Type";
             Employee.Religion := NewEmployeeApplication.Religion;
             Employee.Tribe := NewEmployeeApplication.Tribe;
             Employee."Employment Date" := NewEmployeeApplication."Employment Date";
             Employee."Employee Type" := NewEmployeeApplication."Employee Type";
             Employee."Employee Status" := NewEmployeeApplication."Employee Status";
             Employee."Probation Period" := NewEmployeeApplication."Probation Period";
             Employee."Confirmation/Dismissal Date" := NewEmployeeApplication."Confirmation/Dismissal Date";
             Employee."Job Code" := NewEmployeeApplication."Job Code";
             Employee."Employee Job Title" := NewEmployeeApplication."Employee Job Title";
             Employee.Grade := NewEmployeeApplication.Grade;
             Employee."Staff Category" := NewEmployeeApplication."Staff Category";
             Employee."Supervisor ID" := NewEmployeeApplication."Supervisor ID";
             Employee."Supervisor Name" := NewEmployeeApplication."Supervisor Name";
             //Employee."Second Supervisor ID" := NewEmployeeApplication."Second Supervisor ID";
             //Employee."Second Supervisor Name" := NewEmployeeApplication."Second Supervisor Name";
             Employee."Branch Code" := NewEmployeeApplication."Branch Code";
             Employee.Validate("Branch Code");
             Employee."Department Code" := NewEmployeeApplication."Department Code";
             Employee.Validate("Department Code");
             Employee."Phone No." := NewEmployeeApplication."Phone No.";
             Employee."Company E-Mail" := NewEmployeeApplication."Company E-Mail";
             Employee."National ID" := NewEmployeeApplication."National ID";
             Employee."PIN Number" := NewEmployeeApplication."PIN Number";
             Employee.NSSF := NewEmployeeApplication.NSSF;
             Employee.NHIF := NewEmployeeApplication.NHIF;
             Employee."HELB No." := NewEmployeeApplication."HELB No.";
             Employee."Basic Pay" := NewEmployeeApplication."Basic Pay";
             Employee."Employee Level" := NewEmployeeApplication."Employee Level";
             Employee.Address := NewEmployeeApplication.Address;
             Employee."Post Code" := NewEmployeeApplication."Post Code";
             Employee.City := NewEmployeeApplication.City;
             Employee."Mobile Phone No." := NewEmployeeApplication."Mobile Phone No.";
             Employee."E-Mail" := NewEmployeeApplication."E-Mail";
             Employee."Resident(Estate)" := NewEmployeeApplication."Resident(Estate)";
             Employee."Street Address/Court" := NewEmployeeApplication."Street Address/Court";
             Employee."House No." := NewEmployeeApplication."House No.";
             //Employee."Probation Start Date" := NewEmployeeApplication."Employment Date";
             Employee."Probation Period" := NewEmployeeApplication."Probation Period";
             Employee."Probation End Date" := NewEmployeeApplication."Probation End Date";
             Employee."Confirmation Status" := NewEmployeeApplication."Confirmation Status";
             Employee."Confirmation/Dismissal Date" := NewEmployeeApplication."Confirmation/Dismissal Date";
             Employee."Defer Confirmation" := NewEmployeeApplication."Defer Confirmation";
             Employee."Defer Start Date" := NewEmployeeApplication."Defer Start Date";
             Employee."Defer End Date" := NewEmployeeApplication."Defer End Date";
             Employee."Extension Duration" := NewEmployeeApplication."Extension Duration";
             Employee."Created By" := NewEmployeeApplication."Created By";
             Employee."Created Date" := NewEmployeeApplication."Created Date";
             Employee."Created Time" := NewEmployeeApplication."Created Time";
             Employee."Approved By" := NewEmployeeApplication."Approved By";
             Employee."Approved Date" := NewEmployeeApplication."Approved Date";
             Employee."Approved Time" := NewEmployeeApplication."Approved Time";
             Employee.Image := NewEmployeeApplication.Image;
             Employee."Front Side ID" := NewEmployeeApplication."Front Side ID";
             Employee."Back Side ID" := NewEmployeeApplication."Back Side ID";
             Employee.Signature := NewEmployeeApplication.Signature;
             Employee."Member No." := NewEmployeeApplication."Member No.";
             Employee."FOSA Account" := NewEmployeeApplication."FOSA Account";
             Employee.Insert();

             EmployeeRelative.RESET();
             if EmployeeRelative.FindLast() then begin
                 LineNo := EmployeeRelative."Line No." + 10;
             end else
                 LineNo := 1;
             NewEmployeeRelative.Reset();
             NewEmployeeRelative.SETRANGE("Employee No.", ApplicationNo);
             if NewEmployeeRelative.FindSet() then begin
                 repeat
                     EmployeeRelative.Init();
                     EmployeeRelative."Employee No." := EmployeeNo;
                     EmployeeRelative."Line No." := LineNo;
                     EmployeeRelative."Relative Code" := NewEmployeeRelative."Relative Code";
                     EmployeeRelative."Relation Type" := NewEmployeeRelative."Relation Type";
                     EmployeeRelative."First Name" := NewEmployeeRelative."First Name";
                     EmployeeRelative."Middle Name" := NewEmployeeRelative."Middle Name";
                     EmployeeRelative."Last Name" := NewEmployeeRelative."Last Name";
                     EmployeeRelative."Phone No." := NewEmployeeRelative."Phone No.";
                     EmployeeRelative."Allocation(%)" := NewEmployeeRelative."Allocation(%)";
                     EmployeeRelative."Birth Date" := NewEmployeeRelative."Birth Date";
                     EmployeeRelative."Id No" := NewEmployeeRelative."Id No";
                     EmployeeRelative.Age := NewEmployeeRelative.Age;
                     EmployeeRelative.Insert();
                     LineNo += 1;
                 until NewEmployeeRelative.Next() = 0;
             end;
         end;
         ProffessionalMemberships.RESET;
         if ProffessionalMemberships.FindLast() then begin
             LineNo := ProffessionalMemberships."Line No." + 10;
         end else
             LineNo := 1;
         ProffessionalMembership.RESET;
         ProffessionalMembership.SetRange("Employee No.", ApplicationNo);
         if ProffessionalMembership.FindSet() then begin
             repeat
                 ProffessionalMemberships.Init();
                 ProffessionalMemberships."Line No." := LineNo;
                 ProffessionalMemberships."Employee No." := EmployeeNo;
                 ProffessionalMemberships."Professional Body" := ProffessionalMembership."Professional Body";
                 ProffessionalMemberships."Professional Membership No." := ProffessionalMembership."Professional Membership No.";
                 ProffessionalMemberships.Insert();
                 LineNo += 1;
             // ProffessionalMembership.Rename(EmployeeNo, ProffessionalMembership."Line No.");
             until ProffessionalMembership.Next() = 0;
         end;
     end; */

    procedure getLeavePeriod() PeriodCode: Code[20]
    var
        LeavePeriods: Record "Leave Period";

    begin
        LeavePeriods.Reset();
        LeavePeriods.SetRange(Closed, false);
        if LeavePeriods.FindFirst() then begin
            exit(LeavePeriods."Period Code");
        end;

    end;

    procedure getLastLeavePeriod() PeriodCode: Code[20]
    var
        LeavePeriods: Record "Leave Period";

    begin
        LeavePeriods.Reset();
        LeavePeriods.SetRange(Closed, true);
        if LeavePeriods.Findlast() then begin
            exit(LeavePeriods."Period Code");
        end;

    end;


    procedure InsertEarnedDays(var LeaveJournal: Record "Leave Journal")
    var
        Employee: Record Employee;
        LeaveType: Record "Leave Type";
        LeaveDays: Decimal;
        LeaveTypeDesc: Code[30];
        LeavePeriods: Record "Leave Period";
        LeaveJournals: Record "Leave Journal";
        LeavePeriod: code[40];
        Selected: Integer;
        Text000: Label 'Balance Brought Forward,Added back days,Lost Days,Annual Leave';
        Text001: Label 'Please confirm the type of posting';
    begin

        LeaveType.Reset();
        LeaveType.SetRange(Code, LeaveType.Code::Annual);
        if LeaveType.FindFirst() then begin
            LeaveDays := LeaveType.Days;
            LeaveTypeDesc := LeaveType.Description;
        end;

        LeaveJournal.DeleteAll();
        Employee.Reset();
        Employee.SetRange("Employee Type", Employee."Employee Type"::Permanent);
        if Employee.FindFirst() then begin
            repeat

                LeaveJournal.Init();
                LeaveJournal."Entry No" += 1;
                LeaveJournal."Leave Period" := getLeavePeriod();
                LeaveJournal."Employee No." := Employee."No.";
                LeaveJournal."Posting Date" := Today;
                LeaveJournal."Leave Type" := LeaveJournal."Leave Type"::Annual;
                Employee.CalcFields("Leave Days");
                LeaveJournal."Leave Entry Type" := LeaveJournal."Leave Entry Type"::"Earned Days";
                LeaveJournal.Days := LeaveDays;
                LeaveJournal.Select := true;
                LeaveJournal.Description := 'Earned Leave Days';
                LeaveJournal."Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
                LeaveJournal.Insert();
            until Employee.Next() = 0;
        end;

    end;

    procedure InsertBroughtForward(var LeaveJournal: Record "Leave Journal")
    var
        Employee: Record Employee;
        LeaveType: Record "Leave Type";
        LeaveDays: Decimal;
        LeaveTypeDesc: Code[30];
        LeaveLedgers: Record "Leave Ledger Entry";
        Selected: Integer;
        Year: Integer;
        Text000: Label 'Balance Brought Forward,Added back days,Lost Days,Annual Leave';
        Text001: Label 'Please confirm the type of posting';
        Period: Code[10];
    begin

        Period := getLeavePeriod();
        LeaveJournal.DeleteAll();
        Employee.Reset();
        Employee.SetRange("Employee Type", Employee."Employee Type"::Permanent);
        if Employee.FindFirst() then begin
            repeat
                LeaveLedgers.Reset();
                LeaveLedgers.SetRange("Employee No.", Employee."No.");
                LeaveLedgers.SetFilter("Leave Period", '<>%1', Period);
                LeaveLedgers.SetRange("Leave Code", LeaveLedgers."Leave Code"::Annual);
                if LeaveLedgers.FindSet() then begin
                    LeaveLedgers.CalcSums(Days);
                    LeaveDays := LeaveLedgers.Days;
                    LeaveJournal.Init();
                    LeaveJournal."Entry No" += 1;
                    LeaveJournal."Leave Period" := getLastLeavePeriod();
                    LeaveJournal."Employee No." := Employee."No.";
                    LeaveJournal."Posting Date" := Today;
                    LeaveJournal."Leave Type" := LeaveJournal."Leave Type"::Annual;
                    Employee.CalcFields("Leave Days");
                    LeaveJournal."Leave Entry Type" := LeaveJournal."Leave Entry Type"::"Balance Brought Forward";
                    LeaveJournal.Days := LeaveDays * -1;
                    LeaveJournal.Select := true;
                    LeaveJournal.Description := 'Balance Carried Forward ';
                    LeaveJournal."Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
                    LeaveJournal.Insert();
                end;

                LeaveJournal.Init();
                LeaveJournal."Entry No" += 1;
                LeaveJournal."Leave Period" := getLeavePeriod();
                LeaveJournal."Employee No." := Employee."No.";
                LeaveJournal."Posting Date" := Today;
                LeaveJournal."Leave Type" := LeaveJournal."Leave Type"::Annual;
                Employee.CalcFields("Leave Days");
                LeaveJournal."Leave Entry Type" := LeaveJournal."Leave Entry Type"::"Balance Brought Forward";
                LeaveJournal.Days := LeaveDays;
                LeaveJournal.Select := true;
                LeaveJournal.Description := 'Balance Brought Forward ';
                LeaveJournal."Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
                LeaveJournal.Insert();
            until Employee.Next() = 0;
        end;

    end;



}