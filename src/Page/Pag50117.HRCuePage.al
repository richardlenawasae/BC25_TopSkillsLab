page 50117 HRCuePage
{
    PageType = CardPart;
    SourceTable = "HR Cue";

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
                }
                field("Employees on Probation"; Rec."Employees on Probation")
                {
                    ApplicationArea = All;
                    Caption = 'Employees on Probation';
                    //DrillDownPageId = "Employees On Probation";
                }
                field("Total Employees"; Rec."Total Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Total Employees';
                    DrillDownPageId = "Employee List";
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
                }
                field("Leave Appl. Pending Approval"; Rec."Leave Appl. Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications Pending Approval';
                    DrillDownPageId = "Leave App. Pending Approval";
                }
                field("Approved Leave Applications"; Rec."Approved Leave Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Applications';
                    DrillDownPageId = "Approved Leave Application";
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
        Rec.RESET;
        if not Rec.Get() then begin
            Rec.INIT;
            Rec.INSERT;
        end;
    end;
}