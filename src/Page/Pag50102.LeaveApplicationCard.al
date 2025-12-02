page 50102 "Leave Application Card"
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
                }
                field("Employee No"; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
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
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
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
                field("Reason for Leave"; Rec."Reason for Leave")
                {

                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Current Application")
            {
                Editable = EditDetails;
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    ApplicationArea = All;
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
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    ApplicationArea = All;
                }
            }
            group("First Approval")
            {
                Editable = Approver1LeaveDays;
                Visible = ShowApprovalComment;

                field("Approved Start Date"; Rec."Approved Start Date")
                {
                    ApplicationArea = All;
                }

                field("Approved End Date"; Rec."Approved End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Approver"; Rec."First Approver")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("1st Approval Comment"; Rec."1st Approval Comment")
                {
                    ApplicationArea = All;
                }
                field("Date First Approved"; Rec."Date First Approved")
                {
                    Visible = false;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Visible = false;
                }
                field("Approver 1 Days"; Rec."Approver 1 Days")
                {
                    ApplicationArea = All;
                }
            }
            group("Second Approval")
            {
                //Editable = EditApprovalComments;

                Visible = ShowApprovalComments;
                field("Second Approver"; Rec."Second Approver")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("2nd Approval Comment"; Rec."2nd Approval Comment")
                {
                    ApplicationArea = All;
                }
                field("Date Second Approved"; Rec."Date Second Approved")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approver 2 Days"; Rec."Approver 2 Days")
                {
                    ApplicationArea = All;
                }
            }
            group(Balances)
            {
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    ApplicationArea = All;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    ApplicationArea = All;
                }
                /* field("Lost Days"; "Lost Days")
                 {
                     ApplicationArea = All;
                 }*/
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    ApplicationArea = All;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(LeaveAttachment; "Document Attachment Factbox")

            {
                Caption = 'Leave Attachment';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::"Leave Application"), "No." = field("No.");
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
                    if Rec."Days Applied" <> 0 then begin
                        IF CONFIRM('Are you sure you want to send this leave application for approval?') THEN BEGIN
                            CheckAttachment();
                            //TestField("Reason for Leave");
                            Rec."First Stage approval" := true;
                            Rec.Modify();
                            if ApprovalsMgmt.CheckLeaveApplicationApprovalPossible(Rec) then 
                                ApprovalsMgmt.OnSendLeaveApplicationForApproval(Rec);

                        END;
                    end else begin
                        Error('Days Applied Cannot  be Zero');
                    end;
                    CurrPage.CLOSE();
                END;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Cancel the approval request.';
                Visible = ShowCancelApprovalRequest;
                trigger OnAction()
                var
                ApprovalsMgmt: Codeunit "Approvals Mgmt Ext HR";
                begin
                    ApprovalsMgmt.OnCancelLeaveApplicationApprovalRequest(Rec); 
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: enum "Approval Document Type";

                begin
                    ApprovalEntries.SetRecordFilters(Database::"Leave Application", DocumentType::" ", Rec."No.");
                    ApprovalEntries.Run();
                    Rec."Second Stage approval" := true;
                    Rec.Modify();
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

                trigger OnAction();
                BEGIN
                    Rec.TestField("Approved Days");
                    Rec.TestField("Approved Start Date");
                    Rec.TestField("Approved End Date");

                    if Confirm('Do you want to approve this request?') then begin
                        IF (Rec.Status = Rec.Status::"Pending Approval") and Rec."First Stage approval" = true THEN BEGIN
                            Rec.TestField("Approver 1 Days");
                        end;
                        IF (Rec.Status = Rec.Status::"Pending Approval") and Rec."Second Stage approval" = true THEN BEGIN
                            Rec.TestField("Approver 2 Days");
                        end;
                        Rec."Second Stage approval" := true;
                        Rec.Modify();
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        /* LeaveWorkflowSetup.RESET;
                        LeaveWorkflowSetup.SETRANGE("User ID", "User ID");
                        IF LeaveWorkflowSetup.FINDFIRST THEN BEGIN
                            IF NOT "First Stage approval" THEN BEGIN
                                IF LeaveWorkflowSetup."Second Approver" <> '' THEN begIN
                                    "First Stage approval" := true;
                                    Modify;
                                    HRManagement.NotifyMemberOnSecondApprover(Rec);
                                    HRManagement.NotifySecondApprover(Rec);
                                    MESSAGE('Leave application has been forwarded to the second approver.');
                                END;
                            END ELSE BEGIN 
                                Status := Status::Released;
                                "Second Stage approval" := true;
                                MODIFY;
                                HRManagement.NotifyMemberApproval(Rec);
                                HRManagement.NotifyHR(Rec);
                                MESSAGE('Leave application has been approved successfully!');
                                LeaveLedgerEntry.Reset();
                                HRManagement.InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), "No.", "Employee No.", "Leave Code", "Reason for Leave", "Approved Days", LeaveLedgerEntry."Entry Type"::Negative, FALSE, FALSE, FALSE, FALSE, FALSE, false); */
                        //END;
                        //END;
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
                        // IF Status = Status::Released THEN
                        //     EXIT;
                        // IF Status = Status::"Pending Approval" THEN BEGIN
                        //     Status := Status::Released;
                        //     IF MODIFY(TRUE) THEN BEGIN
                        //         // MESSAGE(Text000, Text006, "Employee No.");
                        //         if "Approver 2 Days" <> 0 then begin
                        //             ApprovedDays := "Approver 2 Days";
                        //         end else begin
                        //             ApprovedDays := "Approved Days";
                        //         end;
                        //         LeaveLedgerEntry.Reset();
                        //         HRManagement.InsertLeaveLedgerEntry(FORMAT(DATE2DMY(TODAY, 3)), "No.", "Employee No.", "Leave Code", Format("Leave Code"), ApprovedDays, LeaveLedgerEntry."Entry Type"::Negative, FALSE, FALSE, FALSE, FALSE, FALSE, false);
                        //     END;
                        // END;

                    end;
                    CurrPage.CLOSE();
                END;
            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';
                Visible = OpenApprovalEntriesExistForCurrUser;
                trigger OnAction()
                var
                    ConfirmRejectMsg: Label 'Are you sure you want to reject this approval request?';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    RejectSuccessMsg: Label 'Rejected successfully';
                begin
                    if Confirm(ConfirmRejectMsg) then begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close();
                    end;
                end;
            }
            action(Delegate)
            {
                ApplicationArea = All;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
                end;
            }
            action(Comment)
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'View or add comments for the record.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.GetApprovalComment(Rec);
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
        /* LeaveWorkflowSetup.RESET;
        LeaveWorkflowSetup.SetRange("USER ID", UserId);
        IF LeaveWorkflowSetup.FindFirst() then begin
            if LeaveWorkflowSetup."First Approver" = '' then
                ERROR('Kindly ensure your first approver has been setup');
            //  IF LeaveWorkflowSetup."Second Approver" = '' then
            // ERROR('Kindly ensure your first approver has been setup');
        end else begin
            error('Kindly ensure that your approvers have been setup');
        end; */
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
        SetApprovalVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        SetApprovalVisibility();
    end;
    // trigger OnAfterGetCurrRecord()
    // begin
    //     CurrPage.LeaveAttachment.PAGE.SetParameter(Rec.RECORDID, Rec."No.");

    // end;

    var
        //ApprovalsMgmtExt: Codeunit "Approvals Mgmt Ext HR";
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
        ApprovedDays: Decimal;
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
        Approver1LeaveDays: Boolean;
        Approver2LeaveDays: Boolean;
        Approver2GroupEditability: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

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
        IF (Rec.Status = Rec.Status::"Pending Approval") and Rec."First Stage approval" = true THEN BEGIN
            // CurrPage.EDITABLE(FALSE);

            ShowSendForApproval := FALSE;
            ShowCancelApprovalRequest := true;
            EditApprovalComment := true;
            EditDetails := false;
            ShowReject := true;
            ShowApprove := true;
            ShowApprovalComments := false;
            ShowApprovalComment := true;
            Approver1LeaveDays := true;
            EditApprovalComments := false;
        END;
        IF (Rec.Status = Rec.Status::"Pending Approval") and Rec."Second Stage approval" = true THEN BEGIN
            ShowSendForApproval := FALSE;
            ShowCancelApprovalRequest := true;
            EditApprovalComment := true;
            EditDetails := false;
            ShowReject := true;
            ShowApprove := true;
            Rec."Second Approver" := Rec."User ID";
            ShowApprovalComments := true;
            ShowApprovalComment := TRUE;
            Approver1LeaveDays := false;
            EditApprovalComments := false;
        end;

        //    IF (Status = Status::"Pending Approval") AND ("First Stage approval" = true) THEN BEGIN
        //         IF UserId = "Second Approver" THEN BEGIN
        //             ShowSendForApproval := FALSE;
        //             ShowCancelApprovalRequest := FALSE;
        //             ShowApprovalComment := true;
        //             EditApprovalComment := false;
        //             EditDetails := false;
        //             ShowReject := true;
        //             ShowApprove := true;
        //             ShowApprovalComments := true;
        //             EditApprovalComments := true;
        //         END ELSE BEGIN
        //             ShowSendForApproval := FALSE;
        //             ShowCancelApprovalRequest := FALSE;
        //             ShowApprovalComment := true;
        //             EditApprovalComment := false;
        //             EditDetails := false;
        //             ShowReject := false;
        //             ShowApprove := false;
        //             ShowApprovalComments := false;
        //             EditApprovalComments := false;
        //         END;
        //     END;
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

    local procedure SetApprovalVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        //OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
    end;

}

