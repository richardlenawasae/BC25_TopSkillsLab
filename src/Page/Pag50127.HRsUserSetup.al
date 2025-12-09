page 50127 "HRs User Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HR Users Setup";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Username; Rec.Username)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Username field.';

                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';

                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(HOD; Rec.HOD)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD field.';

                }
                field(HR; Rec.HR)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HR field.';

                }
                field("C.E.O"; Rec."C.E.O")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the C.E.O field.';

                }
                field(BOARD; Rec.BOARD)
                {
                    ToolTip = 'Specifies the value of the BOARD field.';

                }
                field(Treasurer; Rec.Treasurer)
                {
                    ToolTip = 'Specifies the value of the Treasurer field.';

                }


            }
        }
    }

    var
        myInt: Integer;
}