table 50112 "HR Summary"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Branch; Code[10])
        {

        }

        field(2; "Active Employees"; Integer)
        {

        }
        field(3; "Employees on Probation"; Integer)
        {

        }
        field(4; "Total Employees"; Integer)
        {

        }
    }

    keys
    {
        key(PK; Branch)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}