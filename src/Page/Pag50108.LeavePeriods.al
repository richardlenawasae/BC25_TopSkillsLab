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
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Period Description"; Rec."Period Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the New Fiscal Year field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Locked field.';
                }
                field("Reimbursement Closing Date"; Rec."Reimbursement Closing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reimbursement Closing Date field.';
                }
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Code field.';
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
                ToolTip = 'Executes the Create Year action.';

            }
            action("HR Leave Year - Close")
            {
                Caption = 'Close Year';
                //  Image = "<Undefined>";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Close Year action.';

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
                ToolTip = 'Executes the View Leave Days action.';
            }
        }
    }

    var
        HRManagement: Codeunit "HR Management";
        Text000: Label 'Are you sure you want to close this leave period?';
}

