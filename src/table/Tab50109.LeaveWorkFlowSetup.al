table 50109 "Leave WorkFlow Setup"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                Employee.ValidateShortcutDimCode(2, Employee."Global Dimension 2 Code");

                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", "Department Code");
                if DimensionValue.FindFirst() THEN begin
                    "Department Name" := DimensionValue.Name;
                end;
            end;
        }

        field(2; "Department Name"; text[200])
        {
            Editable = False;
        }
        field(3; "First Approver"; Text[100])
        {
            TableRelation = "User Setup";
        }

        field(4; "Second Approver"; Text[100])
        {
            TableRelation = "User Setup";
        }
        field(5; "Substitute"; Text[100])
        {
            TableRelation = "User Setup";
        }
        field(6; "USER ID"; Text[100])
        {
            TableRelation = "User Setup";
        }
    }

    keys
    {
        key(Key1; "USER ID")
        {
        }
    }


    var

        Employee: Record Employee;

        UserSetup: Record "User Setup";

        DimensionValue: Record "Dimension Value";
}

