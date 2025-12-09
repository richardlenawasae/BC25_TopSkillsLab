page 50110 "Employee Plan Line"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Leave Plan Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reset Plan")
            {
                Image = ResetStatus;
                ApplicationArea = All;
                ToolTip = 'Executes the Reset Plan action.';

                trigger OnAction();
                begin
                    Rec.ResetLines(Rec."No.");
                end;
            }
        }
    }

    var
        LeavePlanLines: Record "Leave Plan Line";
}

