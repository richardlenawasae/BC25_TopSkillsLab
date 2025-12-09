pageextension 50100 UserSetupExt extends "User Setup"
{
    layout
    {
        moveafter("User ID"; Email)

        addafter("Allow Posting To")
        {
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Employee No. field.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Branch';
                ToolTip = 'Specifies the value of the Branch field.';
            }
            field("Allow viewing all orders"; Rec."Allow Open My Settings")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Open My Settings field.';
            }
            field("Allow Change Role"; Rec."Allow Change Role")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Change Role field.';
            }
            field("Allow Change Company"; Rec."Allow Change Company")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Change Company field.';
            }
            field("Allow Change Work Day"; Rec."Allow Change Work Day")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Change Work Day field.';
            }
        }
    }
}