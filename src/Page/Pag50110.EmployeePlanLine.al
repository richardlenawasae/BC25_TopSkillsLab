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
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
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
            action("Reset Plan")
            {
                Image = ResetStatus;
                ApplicationArea = All;

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

