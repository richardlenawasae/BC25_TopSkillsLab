page 50104 "Leave Approvals"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    SourceTable = "Leave Application";
    InsertAllowed = FALSE;
    ModifyAllowed = FALSE;
    DeleteAllowed = FALSE;
    SourceTableView = WHERE(Status = FILTER("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("First Approver"; Rec."First Approver")
                {
                    ApplicationArea = All;
                }
                field("Second Approver"; Rec."Second Approver")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Change Approver")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Confirm(TEXT001) THEN BEGIN
                        Selection := Dialog.StrMenu('First Approver,Second Approver');
                        IF Selection = 1 THEN BEGIN
                            IF PAGE.RUNMODAL(119, UserSetup) = ACTION::LookupOK THEN BEGIN
                                User := UserSetup."User ID";
                                Rec."First Approver" := User;
                                Rec.MODIFY;
                                Message(TEXT002);
                            END;
                        END;
                        IF Selection = 2 THEN BEGIN
                            IF PAGE.RUNMODAL(119, UserSetup) = ACTION::LookupOK THEN BEGIN
                                User := UserSetup."User ID";
                                Rec."Second Approver" := User;
                                Rec.MODIFY;
                                Message(TEXT002);
                            END;
                        END;
                    END;
                END;
            }
        }
    }

    var
        Selection: Integer;
        UserSetup: Record "User Setup";
        User: Code[100];
        TEXT001: Label 'Do you want to change the approver?';
        TEXT002: Label 'The approver has been changed successfully!';
}