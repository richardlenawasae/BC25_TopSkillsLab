page 50108 "Leave Periods"
{
    PageType = List;
    SourceTable = "Leave Period";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Period Description"; Rec."Period Description")
                {
                    ApplicationArea = All;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = All;
                }
                field("Reimbursement Closing Date"; Rec."Reimbursement Closing Date")
                {
                    ApplicationArea = All;
                }
                field("Period Code"; Rec."Period Code")
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
            action("Create Leave Year")
            {
                Caption = 'Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Create Leave Year";
                ApplicationArea = All;

            }
            action("HR Leave Year - Close")
            {
                Caption = 'Close Year';
                //  Image = "<Undefined>";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(Text000) THEN BEGIN
                        HRManagement.CloseLeaveYear();
                    END;
                end;
            }
            action("View Leave Days")
            {
                Image = Balance;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
        }
    }

    var
        HRManagement: Codeunit "HR Management";
        Text000: Label 'Are you sure you want to close this leave period?';
}

