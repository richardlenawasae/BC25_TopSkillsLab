table 50111 "HR Audit Trail"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; code[50])
        {
            Editable = false;
        }
        field(2; "Table ID"; Integer)
        {
            Editable = false;
        }
        field(3; "Table Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Type of Change"; Option)
        {
            OptionMembers = Insert,Modify,Delete;
            Editable = false;
        }
        field(5; "Primary Key Value"; Code[50])
        {
            Editable = false;
        }
        field(6; "Field Caption"; Text[100])
        {
            Editable = false;
        }
        field(7; "Old Value"; Code[100])
        {
            Editable = false;
        }
        field(8; "New Value"; Code[100])
        {
            Editable = false;
        }
        field(9; Status; Option)
        {
            OptionMembers = "Pending Approval",Approved,Rejected;
            Editable = false;
        }
        field(10; UserId; Code[100])
        {
            Editable = false;

        }
        field(11; "Change Date"; Date)
        {
            Editable = false;

        }
        field(12; "Change Time"; Time)
        {
            Editable = false;

        }
        field(13; "Change IP Address"; Text[50])
        {
            Editable = false;

        }
        field(14; "Change MAC Address"; Text[50])
        {
            Editable = false;

        }
        field(15; "Approved By"; Code[100])
        {
            Editable = false;

        }
        field(16; "Approved Date"; Date)
        {
            Editable = false;

        }
        field(17; "Approved Time"; Time)
        {
            Editable = false;

        }
        field(18; "Approved IP Address"; Text[50])
        {
            Editable = false;

        }
        field(19; "Approved MAC Address"; Text[50])
        {
            Editable = false;

        }
        field(20; "Approval Comment"; Text[100])
        {

        }
        field(21; "Field No."; Integer)
        {

        }
        field(22; "Old Image"; Media)
        {

        }
        field(23; "New Image"; Media)
        {

        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        HRSetup: Record "Human Resources Setup";
        NoSeries: Codeunit "No. Series";

    trigger OnInsert()
    begin
        HRSetup.GET();
        HRSetup.TestField("HR Audit Nos.");
        "Entry No." := NoSeries.GetNextNo(HRSetup."HR Audit Nos.", Today, true);

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