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
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field("Employee No"; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Mobile No"; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No. field.';
                }
                field(Branch; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Title field.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("First Approver"; Rec."First Approver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Approver field.';
                }
                field("Second Approver"; Rec."Second Approver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Second Approver field.';
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
                ToolTip = 'Executes the Change Approver action.';

                trigger OnAction()
                begin
                    IF Confirm(TEXT001) THEN BEGIN
                        Selection := Dialog.StrMenu('First Approver,Second Approver');
                        IF Selection = 1 THEN BEGIN
                            IF PAGE.RUNMODAL(119, UserSetup) = ACTION::LookupOK THEN BEGIN
                                User := UserSetup."User ID";
                                Rec."First Approver" := User;
                                Rec.MODIFY();
                                Message(TEXT002);
                            END;
                        END;
                        IF Selection = 2 THEN BEGIN
                            IF PAGE.RUNMODAL(119, UserSetup) = ACTION::LookupOK THEN BEGIN
                                User := UserSetup."User ID";
                                Rec."Second Approver" := User;
                                Rec.MODIFY();
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