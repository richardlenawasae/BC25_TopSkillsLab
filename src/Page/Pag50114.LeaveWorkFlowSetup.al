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
                }
                field("First Approver"; Rec."First Approver")
                {
                    ApplicationArea = All;
                }
                field("Second Approver"; Rec."Second Approver")
                {
                    ApplicationArea = All;
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

