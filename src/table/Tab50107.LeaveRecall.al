table 50107 "Leave Recall"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;
        }
        field(3; Date; Date)
        {

        }
        field(4; Approved; Boolean)
        {
        }
        field(5; "Leave Application"; Code[20])
        {
            TableRelation = "Leave Application" WHERE(Status = filter('Released'), "Approved Start Date" = FILTER('<=TODAY'), "Approved End Date" = FILTER('>=TODAY'),
                                                       "Leave Code" = FILTER('<>MATERNITY'));

            trigger OnValidate();
            begin
                LeaveApplication.SetFilter("Leave Code", '<>%1|%2', "Leave Code"::"Sick Leave-Full Pay", "Leave Code"::"Sick Leave-Half Pay");
                IF LeaveApplication.GET("Leave Application") THEN BEGIN
                    if checkSupervisorId(LeaveApplication."Employee No.") = UserId then begin
                        "Employee No" := LeaveApplication."Employee No.";
                        "Employee Name" := LeaveApplication."Employee Name";
                        "Employee Job Title" := LeaveApplication."Job Title";
                        "Employee Branch" := LeaveApplication."Branch Code";
                        "Employee Department" := LeaveApplication.Department;
                        "Leave Start Date" := LeaveApplication."Start Date";
                        "Leave Ending Date" := LeaveApplication."End Date";
                        "Days Applied" := LeaveApplication."Days Applied";
                        "Leave Code" := LeaveApplication."Leave Code";
                        //  IF LeaveType.Weekdays THEN BEGIN
                        //     "End Date" := 
                        // END;
                        if (LeaveApplication."End Date" - "Recall Date") > "Days Applied" then begin
                            "Remaining Days" := "Days Applied"
                        end else begin
                            "Remaining Days" := LeaveApplication."End Date" - "Recall Date";
                        end;
                    end else begin
                        Error('You are not the supervisor');
                    end;
                END;
            end;
        }
        field(6; "Recall Date"; Date)
        {
        }
        field(7; "Recalled Days"; Decimal)
        {
            Editable = true;

            trigger OnValidate();
            begin
                IF "Recalled Days" > "Remaining Days" THEN
                    ERROR(Error003);

                IF "Recalled From" <> 0D THEN
                    "Recalled To" := HRManagement.CalculateLeaveEndDate("Recalled Days", "Recalled From");
            end;
        }
        field(8; "Leave Ending Date"; Date)
        {
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; "Employee Name"; Text[50])
        {
        }
        field(12; "No."; Code[20])
        {
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(15; "Recalled By"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                IF Employee.GET("Recalled By") THEN BEGIN
                    Name := Employee.FullName();
                    "Recall Branch" := Employee."Global Dimension 1 Code";
                    "Recall Department" := Employee.Department;
                    "Job Title" := Employee."Job Title";
                END;
            end;
        }
        field(16; Name; Text[50])
        {
            Editable = false;
        }
        field(17; "Reason for Recall"; Text[130])
        {
        }
        field(20; "Recalled From"; Date)
        {
            NotBlank = false;

            trigger OnValidate();
            begin
                "Recalled To" := HRManagement.CalculateLeaveEndDate("Recalled Days", "Recalled From");
            end;
        }
        field(21; "Recalled To"; Date)
        {
            NotBlank = false;
        }
        field(22; "Department Name"; Text[80])
        {
        }
        field(26; "Employee Department"; Text[50])
        {
        }
        field(27; "Employee Branch"; Text[50])
        {
        }
        field(28; "Leave Start Date"; Date)
        {
        }
        field(29; "Days Applied"; Decimal)
        {
        }
        field(30; "Recall Department"; Text[50])
        {
        }
        field(31; "Recall Branch"; Text[50])
        {
        }
        field(32; "Employee Job Title"; Text[70])
        {
        }
        field(33; "Job Title"; Text[70])
        {
        }
        field(34; "Leave Code"; enum "Leave Type")
        {
        }
        field(35; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(36; "Remaining Days"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No")
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        IF "No." = '' THEN BEGIN
            HumanResSetup.GET();
            HumanResSetup.TESTFIELD(HumanResSetup."Leave Recall Nos.");
            "No." := NoSeries.GetNextNo(HumanResSetup."Leave Recall Nos.", Today, true);
        END;

        Date := TODAY;
        "Recall Date" := TODAY;
    end;

    trigger OnModify();
    begin
        if Status = Status::Released then
            Error(Error001);
    end;

    trigger OnDelete();
    begin
        if Status = Status::Released then
            Error(Error000);
    end;

    var
        Error000: Label 'You cannot delete this record!';
        Error001: Label 'You cannot modify this record!';
        Error003: Label 'No. of days recalled cannot be greater than the remaining leave days!';

        HumanResSetup: Record "Human Resources Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        LeaveApplication: Record "Leave Application";
        TEXT001: Label 'You are modifying leave recall data for %1 are you sure you want to do this.';
        TEXT002: Label 'The days you are trying to recall for %1 are more than the leave days applied they for.';
        HRManagement: Codeunit "HR Management";


    procedure FindMaturityDate();
    var
        AccPeriod: Record 50;
    begin
    end;

    local procedure checkSupervisorId(var EmployeeNo: Code[20]): Code[20]
    var
        Supervisor: Code[30];
    begin
        Employee.Reset();
        Employee.SetRange("No.", EmployeeNo);
        if Employee.FindFirst() then begin
            Supervisor := Employee."Supervisor ID";

            UserSetup.Reset();
            UserSetup.SetRange("Employee No.", Supervisor);
            if UserSetup.FindFirst() then
                //  Error('%1...%2', Supervisor, UserSetup."User ID");
                exit(UserSetup."User ID");
        end;


    end;

    procedure ValidateFields();
    begin
        TESTFIELD("Leave Application");
        TESTFIELD("Employee No");
        TESTFIELD(Name);
        TESTFIELD("Leave Ending Date");
        TESTFIELD("Recalled From");
        TESTFIELD("Recalled To");
        TESTFIELD("Recalled By");
        TESTFIELD("Reason for Recall");
        TESTFIELD("Recall Date");

    end;
}

