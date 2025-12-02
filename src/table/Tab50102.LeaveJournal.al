table 50102 "Leave Journal"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Leave Period"; Code[10])
        {
            TableRelation = "Leave Period"."Period Code";
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee No.");
                IF Employee.FINDFIRST() THEN BEGIN
                    "Employee Name" := Employee.FullName();
                END;
            end;
        }
        field(5; Description; Text[60])
        {
        }
        field(6; "Leave Type"; enum "Leave Type")
        {
            // TableRelation = "Leave Type".Description;
        }
        field(7; "Entry Type"; Option)
        {
            OptionCaption = '" ,Positive,Negative"';
            OptionMembers = " ",Positive,Negative;
        }
        field(8; Days; Decimal)
        {
        }
        field(9; "Document No"; Code[20])
        {
        }
        field(10; "Employee Name"; Text[100])
        {
        }
        field(11; "Leave Description"; Code[39])
        {

        }
        field(12; Select; Boolean)
        {

        }
        field(13; "Leave Entry Type"; Enum "Leave Entry Type")
        {

        }
    }

    keys
    {
        key(Key1; "Entry No", "Leave Period", "Employee No.", "Posting Date", Description, "Leave Type", "Entry Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}

