page 50132 "Staff Leave Application Card"
{
    PageType = Card;
    SourceTable = "Leave Application";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Application)
            {
                Editable = EditDetails;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Employee No"; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application Date field.';
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
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employment Date field.';
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Code field.';
                    trigger OnValidate()
                    begin
                        LeaveTypes.reset();
                        LeaveTypes.SETRANGE(code, Rec."Leave Code");
                        LeaveTypes.SETRANGE("Attachment required", TRUE);
                        IF LeaveTypes.FindFirst() THEN begin
                            SickLeaveOnly := TRUE;
                        END ELSE BEGIN
                            SickLeaveOnly := FALSE;
                        END;
                        CurrPage.Update();
                    END;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
            }
            group("Current Application")
            {
                Editable = EditDetails;
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days Applied field.';
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                /*  field("Resumption Date"; "Resumption Date")
                  {
                      Editable = false;
                      ApplicationArea = All;
                  }*/
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duties Taken Over By field.';
                }
                /* field("Duties Taken Over By (2)"; "Duties Taken Over By (2)")
                 {
                     ApplicationArea = All;
                 }

                 field("Reason for Leave"; "Reason for Leave")
                 {
                     ApplicationArea = All;
                 }*/
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Allowance Payable field.';
                }
            }
            group("First Approval")
            {
                Editable = EditApprovalComment;
                Visible = ShowApprovalComment;

                field("Approved Start Date"; Rec."Approved Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Start Date field.';
                }
                field("Approved Days"; Rec."Approved Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Days field.';
                }
                field("Approved End Date"; Rec."Approved End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved End Date field.';
                }
                field("First Approver"; Rec."First Approver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Approver field.';
                }
                field("1st Approval Comment"; Rec."1st Approval Comment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 1st Approval Comment field.';
                }
                field("Date First Approved"; Rec."Date First Approved")
                {
                    ToolTip = 'Specifies the value of the Date First Approved field.';
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    ApplicationArea = All;
                    Editable = False;
                    ToolTip = 'Specifies the value of the No of Approvals field.';
                }
            }
            group("Second Approval")
            {
                Editable = EditApprovalComments;
                Visible = ShowApprovalComments;
                field("Second Approver"; Rec."Second Approver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Second Approver field.';
                }
                field("2nd Approval Comment"; Rec."2nd Approval Comment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 2nd Approval Comment field.';
                }
                field("Date Second Approved"; Rec."Date Second Approved")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Second Approved field.';
                }
            }
            group(Balances)
            {
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Earned to Date field.';
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Brought Forward field.';
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalled Days field.';
                }
                /* field("Lost Days"; "Lost Days")
                 {
                     ApplicationArea = All;
                 }*/
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Leave Days Taken field.';
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave balance field.';
                }
            }
        }
        area(factboxes)
        {
            part(LeaveAttachment; "Leave Attachment")

            {
                Caption = 'Leave Attachment';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendLeaveApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';
                Visible = ShowSendForApproval;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext HR";
                begin
                    IF CONFIRM('Are you sure you want to send this leave application for approval?') THEN BEGIN
                        CheckAttachment();
                        Rec.Status := Rec.Status::"Pending Approval";
                        Rec.MODIFY;
                        HRManagement.NotifyMember(Rec);
                        HRManagement.NotifyFirstApprover(Rec);
                        MESSAGE('Leave application has been submitted for approval');
                    END;
                    CurrPage.CLOSE();
                END;
            }
            action(CancelLeaveApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Cancel the approval request.';
                visible = ShowCancelApprovalRequest;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt Ext HR";
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin

                    Rec.Status := Rec.Status::Rejected;
                    Message('Leave Cancelled Successfully');
                    CurrPage.CLOSE();
                end;
            }
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = ShowApprove;
                ApplicationArea = All;
                ToolTip = 'Executes the Approve action.';

                trigger OnAction();
                BEGIN
                    Rec.TestField("Approved Days");
                    Rec.TestField("Approved Start Date");
                    Rec.TestField("Approved End Date");
                    if Confirm('Do you want to approve this request?') then begin
                        LeaveWorkflowSetup.RESET();
                        LeaveWorkflowSetup.SETRANGE("User ID", Rec."User ID");
                        IF LeaveWorkflowSetup.FINDFIRST() THEN BEGIN
                            IF NOT Rec."First Stage approval" THEN BEGIN
                                IF LeaveWorkflowSetup."Second Approver" <> '' THEN begIN
                                    Rec."First Stage approval" := true;
                                    Rec.Modify;
                                    HRManagement.NotifyMemberOnSecondApprover(Rec);
                                    HRManagement.NotifySecondApprover(Rec);
                                    MESSAGE('Leave application has been forwarded to the second approver.');
                                END else begin
                                    Rec.Status := Rec.Status::Released;
                                    Rec."Second Stage approval" := true;
                                    Rec."First Stage approval" := true;
                                    Rec.MODIFY;
                                    HRManagement.NotifyMemberApproval(Rec);
                                    HRManagement.NotifyHR(Rec);
                                    MESSAGE('Leave application has been approved successfully!');
                                    LeaveLedgerEntry.Reset();
                                    HRManagement.InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), Rec."No.", Rec."Employee No.", Rec."Leave Code", Format(Rec."Leave Code"), Rec."Approved Days", LeaveLedgerEntry."Entry Type"::Negative, FALSE, FALSE, FALSE, FALSE, FALSE, false);
                                END;
                            END ELSE BEGIN
                                Rec.Status := Rec.Status::Released;
                                Rec."Second Stage approval" := true;
                                Rec.MODIFY;
                                HRManagement.NotifyMemberApproval(Rec);
                                HRManagement.NotifyHR(Rec);
                                MESSAGE('Leave application has been approved successfully!');
                                LeaveLedgerEntry.Reset();
                                HRManagement.InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), Rec."No.", Rec."Employee No.", Rec."Leave Code", Format(Rec."Leave Code"), Rec."Approved Days", LeaveLedgerEntry."Entry Type"::Negative, FALSE, FALSE, FALSE, FALSE, FALSE, false);
                            END;
                        END;
                        /*  IF LeaveWorkflowSetup."First Approver" = "First Approver" THEN BEGIN
                              IF LeaveWorkflowSetup."Second Approver" <> '' THEN BEGIN
                                  "Second Approver" := LeaveWorkflowSetup."Second Approver";
                                  MODIFY;
                                  MESSAGE('Leave application has been forwarded to the second approver.');
                              END ELSE BEGIN
                                  Status := Status::Released;
                                  MESSAGE('Leave application has been approved successfully!23');
                              END;
                          END ELSE BEGIN
                              IF LeaveWorkflowSetup."Second Approver" = "Second Approver" THEN BEGIN
                                  Status := Status::Released;
                                  MODIFY;
                                  MESSAGE('Leave application has been approved successfully!24');
                              END
                          END;
                      END;
                      /* LeaveWorkflowSetup.RESET;
                       LeaveWorkflowSetup.SETRANGE("User ID", "User ID");
                       IF LeaveWorkflowSetup.FINDFIRST THEN BEGIN
                           IF LeaveWorkflowSetup."First Approver" = "First Approver" THEN BEGIN
                               IF LeaveWorkflowSetup."Second Approver" <> '' THEN BEGIN
                                   IF NOT "First Stage approval" THEN BEGIN
                                       "First Stage approval" := TRUE;
                                       MODIFY;
                                       MESSAGE('Leave application has been forwarded to the second approver.');
                                   END;
                               END;
                           END ELSE
                               IF LeaveWorkflowSetup."Second Approver" = "Second Approver" THEN BEGIN
                                   Message('Noted');
                                   IF NOT "First Stage approval" THEN BEGIN
                                       "Second Stage approval" := TRUE;
                                       Status := Status::Released;
                                       MODIFY;
                                       LeaveLedgerEntry.Reset();
                                       HRManagement.InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), "No.", "Employee No.", "Leave Code", "Leave Code", "Approved Days", LeaveLedgerEntry."Entry Type"::Negative, FALSE, FALSE, FALSE, FALSE, FALSE);
                                       MESSAGE('Leave application approved successfully');
                                   END;
                               END ELSE
                                   IF LeaveWorkflowSetup.Substitute = "User ID" THEN BEGIN
                                       Message('Noted');
                                       Status := Status::Released;
                                       MODIFY;
                                       LeaveLedgerEntry.Reset();
                                       HRManagement.InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), "No.", "Employee No.", "Leave Code", "Leave Code", "Approved Days", LeaveLedgerEntry."Entry Type"::Negative, FALSE, FALSE, FALSE, FALSE, FALSE);
                                       MESSAGE('Leave application approved successfully Substitute');
                                   END;
                       END;*/
                    end;
                    CurrPage.CLOSE();
                END;
            }
            action(Reject)
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = ShowReject;
                ApplicationArea = All;
                ToolTip = 'Executes the Reject action.';

                trigger OnAction();
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Message('Leave rejected Successfully');
                    CurrPage.CLOSE();

                end;
            }
            action("Print Leave Form")
            {
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ToolTip = 'Executes the Print Leave Form action.';

                trigger OnAction();
                begin
                    LeaveApplication.RESET();
                    LeaveApplication.SETFILTER("No.", Rec."No.");
                    IF LeaveApplication.FINDSET() THEN BEGIN
                        //REPORT.RUN(Report::"Loan Repament Schedule", TRUE, FALSE, LeaveApplication);
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        if UserSetup.GET(Rec."User ID") THEN begin
            IF UserSetup."Employee No." = '' then
                ERROR('Kindly ensure your employee ID hads been setup on the user setup');
        end;
        // LeaveWorkflowSetup.RESET;
        // LeaveWorkflowSetup.SetRange("USER ID", UserId);
        // IF LeaveWorkflowSetup.FindFirst() then begin
        //     if LeaveWorkflowSetup."First Approver" = '' then
        //         ERROR('Kindly ensure your first approver has been setup');
        //     IF LeaveWorkflowSetup."Second Approver" = '' then
        //         ERROR('Kindly ensure your first approver has been setup');
        // end else begin
        //     error('Kindly ensure that your approvers have been setup');
        // end;
        Visibility();
        GetMemberDetails();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Status <> Rec.Status::Open then begin
            Error('You cannot delete this record!');
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.LeaveAttachment.PAGE.SetParameter(Rec.RECORDID, Rec."No.");

    end;

    var
        ApprovalsMgmtExt: Codeunit "Approvals Mgmt Ext HR";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalEntry: Record "Approval Entry";
        LeaveApplication: Record "Leave Application";
        LeaveWorkflowSetup: Record "Leave WorkFlow Setup";
        Employee: Record Employee;
        LeaveLedgerEntry: Record "Leave Ledger Entry";
        UserSetup: Record "User Setup";
        Error000: Label 'There is no record to approve!';
        Error001: Label 'There is no record to reject!';
        ShowSendForApproval: Boolean;
        ShowCancelApprovalRequest: Boolean;
        ShowApprove: Boolean;
        ShowReject: Boolean;
        ShowApprovalComment: Boolean;
        EditDetails: Boolean;
        noofapprovals: Decimal;
        HRManagement: Codeunit "HR Management";
        Email: Codeunit 8901;
        EmailMessage: Codeunit 8904;
        ShowApprovalComments: Boolean;
        EditApprovalComment: Boolean;
        EditApprovalComments: Boolean;
        SickLeaveOnly: Boolean;
        LeaveTypes: Record "Leave Type";
        DocAttachment: Record "Document Attachment";
        LeaveApp: Record "Leave Application";
        CBSAttachment: Record "HR Attachment";

    local procedure Visibility();
    begin
        IF Rec.Status = Rec.Status::Open THEN BEGIN
            CurrPage.EDITABLE(TRUE);
            ShowSendForApproval := true;
            ShowCancelApprovalRequest := FALSE;
            ShowReject := FALSE;
            ShowApprove := FALSE;
            ShowApprovalComment := false;
            EditDetails := true;
            ShowApprovalComments := false;
            EditApprovalComments := false;
            ShowApprovalComment := false;
            EditApprovalComment := false;
        END;
        IF (Rec.Status = Rec.Status::"Pending Approval") AND (Rec."First Stage approval" = false) THEN BEGIN
            // CurrPage.EDITABLE(FALSE);
            ShowSendForApproval := FALSE;
            ShowCancelApprovalRequest := FALSE;
            ShowApprovalComment := true;
            EditApprovalComment := true;
            EditDetails := false;
            ShowReject := true;
            ShowApprove := true;
            ShowApprovalComments := false;
            EditApprovalComments := false;
        END;
        IF (Rec.Status = Rec.Status::"Pending Approval") AND (Rec."First Stage approval" = true) THEN BEGIN
            IF UserId = Rec."Second Approver" THEN BEGIN
                ShowSendForApproval := FALSE;
                ShowCancelApprovalRequest := FALSE;
                ShowApprovalComment := true;
                EditApprovalComment := false;
                EditDetails := false;
                ShowReject := true;
                ShowApprove := true;
                ShowApprovalComments := true;
                EditApprovalComments := true;
            END ELSE BEGIN
                ShowSendForApproval := FALSE;
                ShowCancelApprovalRequest := FALSE;
                ShowApprovalComment := true;
                EditApprovalComment := false;
                EditDetails := false;
                ShowReject := false;
                ShowApprove := false;
                ShowApprovalComments := false;
                EditApprovalComments := false;
            END;
        END;
        IF (Rec.Status = Rec.Status::Rejected) OR (Rec.Status = Rec.Status::Released) THEN BEGIN
            CurrPage.Editable(false);
            ShowSendForApproval := FALSE;
            ShowCancelApprovalRequest := FALSE;
            ShowReject := FALSE;
            ShowApprove := FALSE;
        END;
        if Rec.Status = Rec.Status::Released THEN BEGIN
            ShowApprovalComment := true;
            EditApprovalComment := false;
            EditDetails := false;
            ShowApprovalComments := true;
            EditApprovalComments := false;
        END;


        /*   IF Status = Status::"Pending Approval" THEN BEGIN
               IF USERID = "First Approver" THEN BEGIN
                   IF "First Stage approval" THEN BEGIN
                       ShowReject := FALSE;
                       ShowApprove := FALSE;
                   END ELSE BEGIN
                       ShowReject := TRUE;
                       ShowApprove := TRUE;
                   END;
               END ELSE
                   IF USERID = "Second Approver" THEN BEGIN
                       ShowReject := TRUE;
                       ShowApprove := TRUE;
                   END;
           END; */

    END;

    Local procedure CheckAttachment();
    begin
        LeaveTypes.RESET();
        LeaveTypes.SETRANGE(code, Rec."Leave Code");
        LeaveTypes.SetRange("Attachment required", TRUE);
        if LeaveTypes.FindFirst() then begin
            CBSAttachment.RESET;
            CBSAttachment.SETRANGE("Document No.", Rec."No.");
            IF NOT CBSAttachment.FINDFIRST THEN BEGIN
                ERROR('Kindly attach supporting documents');
            end;
        end;
    end;

    procedure emailsending();
    begin

    end;

    procedure GetMemberDetails();
    BEGIN
        //Get member Details
        /* If UserSetup.GET("User ID") THEN BEGIN
             IF Employee.GET(UserSetup."Employee No.") THEN BEGIN
                 "Employee No." := Employee."No.";
                 "Employee Name" := Employee.FullName();
                 "Branch Code" := Employee."Global Dimension 1 Code";
                 "Job Title" := Employee."Job Title";
                 Department := Employee.Department;
                 "Employment Date" := Employee."Employment Date";
                 "Mobile No." := Employee."Mobile Phone No.";

                 noofapprovals := 0;
                 LeaveWorkflowSetup.RESET;
                 LeaveWorkflowSetup.SETRANGE("User ID", "User ID");
                 IF LeaveWorkflowSetup.FindFirst THEN BEGIN
                     IF LeaveWorkflowSetup."First Approver" <> '' THEN BEGIN
                         noofapprovals += 1;
                         "Pending Approver" := LeaveWorkflowSetup."First Approver";
                     END;
                     IF LeaveWorkflowSetup."Second Approver" <> '' THEN BEGIN
                         noofapprovals += 1;
                         "Pending Approver1" := LeaveWorkflowSetup."Second Approver";
                     END;
                     IF LeaveWorkflowSetup."Third Approver" <> '' THEN BEGIN
                         noofapprovals += 1;
                         "Pending Approver2" := LeaveWorkflowSetup."Third Approver";
                     END;
                 END;
                 "No of Approvals" := noofapprovals;
             END;
         END;
         //get total number of approvers for leave
 */
    END;
}

