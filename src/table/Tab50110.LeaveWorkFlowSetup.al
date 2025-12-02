table 50110 "HR Attachment"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; RecordID; Text[50])
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "File Name"; Text[200])
        {
        }
        field(5; Attachment; BLOB)
        {
        }
        field(6; "File Path"; Text[250])
        {
        }
        field(7; "File Extension"; Text[90])
        {
            Editable = false;
        }
        field(8; "Attached Date"; DateTime)
        {
            Editable = false;
        }

        field(9; Content; Blob)
        {

        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

