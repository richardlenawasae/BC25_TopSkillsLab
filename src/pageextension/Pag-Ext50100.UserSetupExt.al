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
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Branch';
            }
            field("Allow viewing all orders"; Rec."Allow Open My Settings")
            {
                ApplicationArea = All;
            }
            field("Allow Change Role"; Rec."Allow Change Role")
            {
                ApplicationArea = All;
            }
            field("Allow Change Company"; Rec."Allow Change Company")
            {
                ApplicationArea = All;
            }
            field("Allow Change Work Day"; Rec."Allow Change Work Day")
            {
                ApplicationArea = All;
            }
        }
    }
}