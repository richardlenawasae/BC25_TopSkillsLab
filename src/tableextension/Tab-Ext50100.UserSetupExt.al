tableextension 50100 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50100; "Allow Open My Settings"; Boolean)
        {
            Caption = 'Allow Open My Settings';
            DataClassification = CustomerContent;
        }
        field(50101; "Allow Change Role"; Boolean)
        {
            Caption = 'Allow Change Role';
            DataClassification = CustomerContent;
        }
        field(50102; "Allow Change Company"; Boolean)
        {
            Caption = 'Allow Change Company';
            DataClassification = CustomerContent;
        }
        field(50103; "Allow Change Work Day"; Boolean)
        {
            Caption = 'Allow Change Work Day';
            DataClassification = CustomerContent;
        }
        field(50104; "Employee No."; Code[30])
        {
            TableRelation = Employee."No.";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Employee: Record Employee;
                UserSetup: Record "User Setup";
            begin
                if "Employee No." <> '' then begin
                    UserSetup.Reset();
                    UserSetup.SetRange("Employee No.", "Employee No.");
                    if UserSetup.FindFirst() then begin
                        Error('The employee no selected has already been attached to another employee');
                    end;
                end;
            end;
        }
        field(50105; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50106; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
    }

}