page 50118 "Leave App. Pending Approval"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageID = "Leave Application Card";
    Editable = false;
    PageType = List;
    SourceTable = "Leave Application";
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
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employment Date field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
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
    }
    trigger OnOpenPage()
    begin
        if Rec."First Stage approval" = false THEN BEGIN
            Rec.FilterGroup(2);
            Rec.SetRange("First Approver", UserId);
            Rec.SetRange("First Stage approval", false);
            Rec.FilterGroup(0);
        end;
    END;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Error('You cannot create a new record at this level!');
    end;
}

