page 50117 HRCuePage
{
    PageType = CardPart;
    SourceTable = "HR Cue";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Employees)
            {
                //  CuegroupLayout = Wide;

                field("Active Employees"; Rec."Active Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Active Employees';
                    DrillDownPageId = "Employee List";
                    ToolTip = 'Specifies the value of the Active Employees field.';
                }
                field("Employees on Probation"; Rec."Employees on Probation")
                {
                    ApplicationArea = All;
                    Caption = 'Employees on Probation';
                    ToolTip = 'Specifies the value of the Employees on Probation field.';
                    //DrillDownPageId = "Employees On Probation";
                }
                field("Total Employees"; Rec."Total Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Total Employees';
                    DrillDownPageId = "Employee List";
                    ToolTip = 'Specifies the value of the Total Employees field.';
                }
            }
            cuegroup("Leave Applications")
            {
                // CuegroupLayout = Wide;
                field("New Leave Applications"; Rec."New Leave Applications")
                {
                    ApplicationArea = All;
                    Caption = 'New Leave Applications';
                    DrillDownPageId = "Leave Application List";
                    ToolTip = 'Specifies the value of the New Leave Applications field.';
                }
                field("Leave Appl. Pending Approval"; Rec."Leave Appl. Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications Pending Approval';
                    DrillDownPageId = "Leave App. Pending Approval";
                    ToolTip = 'Specifies the value of the Leave Applications Pending Approval field.';
                }
                field("Approved Leave Applications"; Rec."Approved Leave Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Applications';
                    DrillDownPageId = "Approved Leave Application";
                    ToolTip = 'Specifies the value of the Approved Leave Applications field.';
                }
            }

            // cuegroup("Training Requests")
            // {
            //     field("New Training Request"; "New Training Request")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'New Training Request';
            //         DrillDownPageId = "Training Request List";
            //     }
            //     field("Training Req. Pending Approval"; "Training Req. Pending Approval")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Training Request Pending Approval';
            //         DrillDownPageId = "Req. Pending CEO Approval";
            //     }

            //     field("Approved Training Request"; "Approved Training Request")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Approved Training Request';
            //         DrillDownPageId = "Approved Training Requests";
            //     }
        }
    }
    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.Get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
    end;
}