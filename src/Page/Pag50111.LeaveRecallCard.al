page 50111 "Leave Recall Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Leave Recall";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recall Date field.';
                }
                field("Leave Application"; Rec."Leave Application")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Application field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Employee Department"; Rec."Employee Department")
                {
                    Caption = 'Department';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Employee Branch"; Rec."Employee Branch")
                {
                    Caption = 'Branch';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Employee Job Title"; Rec."Employee Job Title")
                {
                    Caption = 'Job Title';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Start Date field.';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days Applied field.';
                }
                field("Leave Ending Date"; Rec."Leave Ending Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Ending Date field.';
                }
                field("Remaining Days"; Rec."Remaining Days")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Days field.';
                }
            }
            group("Recall Details")
            {
                Caption = 'Recall Details';
                field("Recalled Days"; Rec."Recalled Days")
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalled Days field.';
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalled From field.';
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalled To field.';
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalled By field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Recall Department"; Rec."Recall Department")
                {
                    Caption = 'Department.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department. field.';
                }
                field("Recall Branch"; Rec."Recall Branch")
                {
                    Caption = 'Branch.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch. field.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Caption = 'Job Title.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Title. field.';
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason for Recall field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Recall & Notify Employee")
            {
                Caption = 'Recall Employee';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Recall Employee action.';

                trigger OnAction();
                begin
                    IF CONFIRM(TEXT001) THEN BEGIN
                        Rec.TESTFIELD("Leave Application");
                        Rec.TESTFIELD("Employee No");
                        Rec.TESTFIELD("Leave Ending Date");
                        Rec.TESTFIELD("Recalled From");
                        Rec.TESTFIELD("Recalled To");
                        Rec.TESTFIELD("Recalled By");
                        Rec.TESTFIELD("Reason for Recall");
                        Rec.TESTFIELD("Recall Date");

                        HRJournalLine.INIT();
                        HRJournalLine."Document No" := Rec."No.";
                        HRJournalLine."Leave Period" := FORMAT(DATE2DMY(TODAY, 3));
                        HRJournalLine."Employee No." := Rec."Employee No";
                        HRJournalLine."Employee Name" := Rec."Employee Name";
                        HRJournalLine."Posting Date" := TODAY;
                        HRJournalLine."Entry Type" := HRJournalLine."Entry Type"::Positive;
                        HRJournalLine.Description := Rec."Reason for Recall";
                        HRJournalLine."Leave Code" := Rec."Leave Code";
                        HRJournalLine.Days := Rec."Recalled Days";
                        HRJournalLine."User ID" := USERID;
                        HRJournalLine.Recall := TRUE;
                        HRJournalLine.INSERT(TRUE);

                        Rec.Status := Rec.Status::Released;
                        HRManagement.NotifyEmployeeRecall(Rec);
                        Rec.MODIFY();

                        IF Employee.GET(Rec."Employee No") THEN BEGIN
                            IF UserSetup.GET(USERID) THEN BEGIN
                                HRSetup.GET();
                                CompanyInformation.GET();

                                //RecipientMail := Employee."E-Mail" + ';' + UserSetup."E-Mail" + ';' + HRSetup."HR E-Mail";
                                /* HRManagement.SendMail(RecipientMail,TEXT002,TEXT003+"Employee Name"+TEXT004+"Leave Code"+TEXT005+Name+TEXT006+
                                                       FORMAT("Recalled Days")+TEXT007+FORMAT("Recalled From")+TEXT008+FORMAT("Recalled To")+TEXT009+CompanyInformation.Name);*/
                                MESSAGE(TEXT010);
                            END;
                        END;
                    END;

                end;
            }
        }
    }

    var
        HRJournalLine: Record "Leave Ledger Entry";
        TEXT001: Label 'Recall Employee from Leave?';
        HRManagement: Codeunit "HR Management";
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        RecipientMail: Text;
        HRSetup: Record "Human Resources Setup";
        TEXT002: Label 'LEAVE RECALL NOTICE';
        TEXT003: Label '"Dear  "';
        TEXT004: Label '",<br><br> Please note that your "';
        TEXT005: Label '" leave has been recalled by "';
        TEXT006: Label '" for "';
        TEXT007: Label '" days from "';
        TEXT008: Label '" to "';
        TEXT009: Label '. <br><br>Kind Regards,<br>';
        CompanyInformation: Record "Company Information";
        TEXT010: Label 'Employee has been successfully recalled!';
}

