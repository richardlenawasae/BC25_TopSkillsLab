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
                    ToolTip = 'Specifies the value of the Select field.';

                }
                field("Entry No"; Rec."Entry No")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document No"; Rec."Document No")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    //  Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Period field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';

                    trigger OnValidate();
                    begin

                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field("Leave Entry Type"; Rec."Leave Entry Type")
                {
                    ToolTip = 'Specifies the value of the Leave Entry Type field.';

                }

                field("Entry Type"; Rec."Entry Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry Type field.';
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days field.';
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
                ToolTip = 'Executes the Accrue Annul Leave action.';

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
                ToolTip = 'Executes the Generate Brought Forward Days action.';

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
                ToolTip = 'Executes the Post Leave Data action.';

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

