table 50115 "Employee Data View"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; User; Code[100])
        {
        }
        field(3; "Employee No"; Code[20])
        {
        }
        field(4; "Employee Name"; Text[100])
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; Time; Time)
        {
        }
        field(7; "Onboard"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        IF EmployeeDataView.FINDLAST THEN BEGIN
            lastno := EmployeeDataView.No + 1;
        END;
    end;

    var
        lastno: Integer;
        EmployeeDataView: Record "Employee Data View";
}

