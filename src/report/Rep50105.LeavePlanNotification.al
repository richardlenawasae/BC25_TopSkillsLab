report 50105 "Leave Plan Notification"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; "Leave Plan Header")
        {
            trigger OnAfterGetRecord();
            begin
                IF Status = Status::Released THEN BEGIN
                    LeavePlan.RESET;
                    LeavePlan.SETRANGE("No.", "No.");
                    IF LeavePlan.FindSET THEN begin
                        REPEAT
                            IF LeavePlan."Start Date" = CalcDate('<+1D>', TODAY) then
                                HRManagement.NotifyLeavePlanEmployee(LeavePlan."No.", "Leave Code", LeavePlan.Days, LeavePlan."Start Date", LeavePlan."End Date", "Employee No");
                        UNTIL LeavePlan.Next = 0;
                    end;
                END ELSE
                    CurrReport.skip;


            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    var
        myInt: Integer;

        LeavePlan: Record "Leave Plan Line";
        HRManagement: Codeunit "HR Management";
        LeavePlanHeader: Record "Leave Plan Header";
}