table 50103 "Leave Ledger Entry"
{
    DrillDownPageId = "Leave Ledger Entry";
    LookupPageId = "Leave Ledger Entry";
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Leave Period"; Code[10])
        {
        }
        field(3; Closed; Boolean)
        {
        }
        field(4; "Employee No."; Code[10])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                IF Employee.GET("Employee No.") THEN;
                //   "Employee Name" := Employee.FullName;
            end;
        }
        field(5; "Posting Date"; Date)
        {
        }
        field(7; "User ID"; Code[50])
        {
        }
        field(8; "Leave Code"; enum "Leave Type")
        {
            //TableRelation = "Leave Type";
        }
        field(9; Days; Decimal)
        {
        }
        field(10; "Document No"; Code[20])
        {
        }
        field(11; Description; Text[100])
        {
        }
        field(12; "Entry Type"; Option)
        {
            OptionCaption = ',Positive,Negative';
            OptionMembers = ,Positive,Negative;
        }
        field(13; "Lost Days"; Boolean)
        {
        }
        field(14; "Earned Leave Days"; Boolean)
        {
        }
        field(15; "Balance Brought Forward"; Boolean)
        {
        }
        field(16; Recall; Boolean)
        {
        }
        field(17; "Added Back Days"; Boolean)
        {
        }
        field(18; Modified; Boolean)
        {
        }
        field(19; "Employee Name"; Text[100])
        {
        }
        field(20; lieu; boolean)
        {

        }
        field(21; "Leave Entry Type"; Enum "Leave Entry Type")
        {

        }
    }

    keys
    {
        key(Key1; "Entry No.", "Employee No.", "Leave Period")
        {
        }
        key(key2; lieu)
        {
            Enabled = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        LeaveLedgerEntry.RESET();
        IF LeaveLedgerEntry.FINDLAST() THEN
            "Entry No." := LeaveLedgerEntry."Entry No." + 1;
    end;

    var
        Employee: Record Employee;
        LeaveLedgerEntry: Record "Leave Ledger Entry";
}

