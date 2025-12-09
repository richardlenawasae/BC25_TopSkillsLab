page 50133 "Staff List"
{
    PageType = List;
    Caption = 'My Staff Profile';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Staff Card";
    SourceTable = Employee;
    SourceTableView = where("Employee Status" = filter('Active|Probation|Confirmed|Suspended'));
    InsertAllowed = FALSE;
    ModifyAllowed = FALSE;
    DeleteAllowed = FALSE;
    Editable = FALSE;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FullName field.';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Employee Status"; Rec."Employee Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Status field.';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Prompt Password Change")
            {
                ApplicationArea = All;
                Image = UserSetup;
                Caption = 'Prompt Password Change';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Prompt Password Change';
                trigger OnAction();
                begin
                    GetUser.PromptPasswordChange();
                end;
            }
        }
    }
    trigger OnOpenPage();
    begin

        UserSetup.GET(UserID);

        Rec.Filtergroup(2);
        Rec.Setrange("No.", UserSetup."Employee No.");
        Rec.Filtergroup(0);
    end;

    var

        UserSetup: Record "User Setup";
        GetUser: Codeunit "Get User";
}