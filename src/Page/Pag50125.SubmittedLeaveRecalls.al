page 50125 "Submitted Leave Recalls"
{
    CardPageID = "Leave Recall Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Leave Recall";
    SourceTableView = WHERE(Status = FILTER('Released'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Start Date field.';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days Applied field.';
                }
                field("Leave Ending Date"; Rec."Leave Ending Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Ending Date field.';
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recall Date field.';
                }
                field("Recalled By"; Rec."Recalled By")
                {
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recall Department field.';
                }
                field("Recall Branch"; Rec."Recall Branch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recall Branch field.';
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason for Recall field.';
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalled To field.';
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recalled From field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Error(Error000);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Error(Error001);
    end;

    var
        Error000: Label 'You cannot create a new record!';
        Error001: Label 'You cannot modify this record!';
}

