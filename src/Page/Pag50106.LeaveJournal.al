page 50106 "Leave Journal"
{
    PageType = List;
    SourceTable = "Leave Journal";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {

                }
                field("Entry No"; Rec."Entry No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No"; Rec."Document No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    //  Visible = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {

                    trigger OnValidate();
                    begin

                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Leave Entry Type"; Rec."Leave Entry Type")
                {

                }

                field("Entry Type"; Rec."Entry Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("InsertInLeaveJournal")
            {
                Image = Insert;
                Caption = 'Accrue Annul Leave';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    if Confirm('Do you want to accrue leave days') then begin
                        HRManagement.InsertEarnedDays(Rec);
                        Message('Accrued Succesfully');
                    end;

                end;
            }
            action("InsertBroughtForwardJournal")
            {
                Image = Insert;
                Caption = 'Generate Brought Forward Days';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin

                    HRManagement.InsertBroughtForward(Rec);

                end;
            }
            action("Post Leave Data")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    if Confirm('Do You want to post Leave Days') then begin

                        LeaveJournal.Reset();
                        LeaveJournal.SetCurrentKey("Leave Entry Type");
                        if LeaveJournal.FindSet() then begin
                            repeat
                                checkIfPosted(LeaveJournal."Employee No.", LeaveJournal."Leave Type", LeaveJournal."Leave Period", LeaveJournal."Leave Entry Type");
                                HRManagement.InsertEarnedLedgerEntry(LeaveJournal."Leave Period", LeaveJournal."Leave Period", LeaveJournal."Employee No.", LeaveJournal."Leave Type", LeaveJournal.Description, LeaveJournal.Days, LeaveJournal."Entry Type"::Positive, LeaveJournal."Leave Entry Type");
                            until LeaveJournal.Next() = 0;        // LeaveDays.Run();
                        end;
                    end;
                    Message('Posted Successfully');
                    LeaveJournal.DeleteAll();
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        //  "Leave Type" := "Leave Type"::Annual;
    end;

    var
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        LeaveLedger: Record "Leave Ledger Entry";
        LastNumber: Integer;
        HRJournalLine: Record "Leave Ledger Entry";
        LeaveJournal: Record "Leave Journal";
        Employee: Record Employee;
        LeaveLedgers: Record "Leave Ledger Entry";
        LeaveDays: Codeunit "Leave Days";
        HRSetup: Record "Human Resources Setup";
        maiheader: Text;
        mailbody: Text;
        User: Record "User Setup";
        Selected: Integer;
        HRManagement: Codeunit "HR Management";

    procedure checkIfPosted(Var employeeNo: Code[30]; leaveType: Enum "Leave Type"; leavePeriod: Code[30]; leaveEntryType: Enum "Leave Entry Type")
    begin
        LeaveLedgers.Reset();
        LeaveLedgers.SetRange("Employee No.", employeeNo);
        LeaveLedgers.SetRange("Leave Code", leaveType);
        LeaveLedgers.SetRange("Leave Period", leavePeriod);
        LeaveLedgers.SetRange("Leave Entry Type", leaveEntryType);

        if LeaveLedgers.FindFirst() then begin
            LeaveLedgers.Delete();
        end;
    end;
}

