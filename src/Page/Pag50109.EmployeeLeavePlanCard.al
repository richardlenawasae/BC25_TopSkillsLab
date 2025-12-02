page 50109 "Employee Leave Plan Card"
{
    Caption = 'Employee Leave Plan';
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "Leave Plan Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
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
                }
                field("Leave Entitlement"; Rec."Leave Entitlement")
                {
                    ApplicationArea = All;
                }
                field("Balance Brought Forward"; Rec."Balance Brought Forward")
                {
                    ApplicationArea = All;
                }
                field("Added Back Days"; Rec."Added Back Days")
                {
                    ApplicationArea = All;
                }
                field("Total Leave Days"; Rec."Total Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Days in Plan"; Rec."Days in Plan")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part("Leave Plan Lines"; "Employee Plan Line")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
            group("Audit Trail")
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Submit Leave Plan")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SendLeavePlan;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text000) THEN BEGIN
                        Rec.Status := Rec.Status::Released;
                        Rec.MODIFY;
                        MESSAGE(Text001);
                    END;
                    CurrPage.CLOSE();
                end;
            }
            action("Re-Open Leave Plan")
            {
                Image = Recalculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = ReOpenPlan;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text002) THEN BEGIN
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                        MESSAGE(Text003);
                    END;
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        IF Rec.Status = Rec.Status::Open THEN BEGIN
            CurrPage.EDITABLE(TRUE);
            SendLeavePlan := TRUE;
            ReOpenPlan := FALSE;
        END ELSE BEGIN
            CurrPage.EDITABLE(FALSE);
            SendLeavePlan := FALSE;
            ReOpenPlan := TRUE;
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Status = Rec.Status::Released then
            Error('This record cannot be deleted!');
    end;

    var
        ApprovalMgt: Codeunit 1535;
        Mail: Codeunit 397;
        Employee: Record Employee;
        LeavePlanLines: Record "Leave Plan Line";
        LeavePlanRec: Record "Leave Plan Header";
        LeaveTypes: Record "Leave Type";
        SendLeavePlan: Boolean;
        ReOpenPlan: Boolean;
        Text000: Label 'Are you sure you want to submit your leave plan?';
        Text001: Label 'Leave Plan submitted successfully!';
        Text002: Label 'Are you sure you want to re-open your leave plan?';
        Text003: Label 'Leave Plan re-opened successfully!';
}

