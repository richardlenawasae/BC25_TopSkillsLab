table 50101 "Leave Balances Management"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Integer)
        {
            Editable = false;
        }
        field(2; "Leave Code"; Code[20])
        {
            Editable = false;
            //  TableRelation = "Leave Type";
        }
        field(3; "Employee No."; Code[20])
        {
            Editable = false;
            TableRelation = Employee;
        }
        field(4; "Leave Name"; Code[50])
        {
            Editable = false;
        }
        field(5; "Employee Name"; Code[50])
        {
            Editable = false;
        }
        field(6; "Total Balance"; Decimal)
        {
            Editable = false;
        }
        field(7; "Balance as at Date"; Date)
        {
            Editable = false;
        }
        field(8; BranchCode; Code[50])
        {
            Editable = false;
        }
        field(9; DeptCode; Code[50])
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Leave Code", "Employee No.")
        {
        }
    }
}