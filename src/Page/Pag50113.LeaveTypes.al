page 50113 "Leave Types"
{
    Editable = true;
    PageType = List;
    SourceTable = "Leave Type";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                }
                field("Acrue Days"; Rec."Acrue Days")
                {
                    ApplicationArea = All;
                }
                field("Days Earned Per Month"; Rec."Days Earned Per Month")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                    ApplicationArea = All;
                }
                field("Calendar Days"; Rec."Calendar Days")
                {
                    ApplicationArea = All;
                }
                field(Weekdays; Rec.Weekdays)
                {
                    ApplicationArea = All;
                }
                field("Employment Status"; Rec."Employment Status")
                {
                    ApplicationArea = All;
                }
                field("Eligible Staff"; Rec."Eligible Staff")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Attachment required"; Rec."Attachment required")
                {
                    ApplicationArea = All;
                }
                field("Earn Basis"; Rec."Earn Basis")
                {
                    ApplicationArea = All;
                }
                field("Annual Leave"; Rec."Annual Leave")
                {
                    ApplicationArea = All;
                }
                field("Calc Leave Days"; Rec."Calc Leave Days")
                {
                    ApplicationArea = all;
                }
                field("Max days Allowed"; Rec."Max days Allowed")
                {
                    ApplicationArea = all;
                }


            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

