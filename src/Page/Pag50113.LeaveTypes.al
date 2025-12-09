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
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days field.';
                }
                field("Acrue Days"; Rec."Acrue Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acrue Days field.';
                }
                field("Days Earned Per Month"; Rec."Days Earned Per Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days Earned Per Month field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Carry Forward Days field.';
                }
                field("Calendar Days"; Rec."Calendar Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Calendar Days field.';
                }
                field(Weekdays; Rec.Weekdays)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weekdays field.';
                }
                field("Employment Status"; Rec."Employment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employment Status field.';
                }
                field("Eligible Staff"; Rec."Eligible Staff")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Eligible Staff field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Attachment required"; Rec."Attachment required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attachment required field.';
                }
                field("Earn Basis"; Rec."Earn Basis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Earn Basis field.';
                }
                field("Annual Leave"; Rec."Annual Leave")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Annual Leave field.';
                }
                field("Calc Leave Days"; Rec."Calc Leave Days")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Calc Leave Days field.';
                }
                field("Max days Allowed"; Rec."Max days Allowed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Max days Allowed field.';
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

