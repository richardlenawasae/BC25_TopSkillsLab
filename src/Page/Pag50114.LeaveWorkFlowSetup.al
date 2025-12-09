page 50114 "Leave WorkFlow Setup"
{
    Editable = true;
    PageType = List;
    SourceTable = "Leave WorkFlow Setup";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the USER ID field.';
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

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

