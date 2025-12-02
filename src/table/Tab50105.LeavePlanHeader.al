table 50105 "Leave Plan Header"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;
        }
        field(2; "Employee No"; Code[30])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                IF Employee.GET("Employee No") THEN BEGIN
                    LeavePlanHeader.reset();
                    LeavePlanHeader.SetRange("Employee No", rec."Employee No");
                    if LeavePlanHeader.FindFirst() then begin
                        error('You have already submitted a leave plan for this leave period');
                    end;
                    "Employee Name" := Employee.FullName();
                    "Branch Code" := Employee."Global Dimension 1 Code";
                    Validate("Branch Code");
                    "Job Title" := Employee."Job Title";
                    "Employment Date" := Employee."Employment Date";
                    "Department Code" := Employee.Department;
                    Validate("Department Code");
                    "Leave Code" := "Leave Code"::Annual;
                    "Application Date" := TODAY;
                    CALCFIELDS("Leave Entitlement", "Balance Brought Forward", "Added Back Days");
                    "Total Leave Days" := "Leave Entitlement" + "Balance Brought Forward" + "Added Back Days";
                    LeavePlanLines.INIT();
                    LeavePlanLines."No." := "No.";
                    LeavePlanLines.Balance := "Total Leave Days";
                    LeavePlanLines.INSERT();
                END;
            end;
        }
        field(3; "Employee Name"; Text[40])
        {
            Editable = false;
        }
        field(4; "Leave Code"; Enum "Leave Type")
        {
            //TableRelation = "Leave Type";
            trigger OnValidate();
            begin
                if "Leave Code" <> "Leave Code"::Annual THEN
                    ERROR('You cannnot plan for any other leave code')
            end;
        }
        field(5; "Leave Balance"; Decimal)
        {
            Editable = false;
        }
        field(6; "User ID"; Code[80])
        {
            Editable = false;
        }
        field(7; "Department Code"; Code[30])
        {
            Editable = false;
            trigger OnValidate()
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", 'DEPARTMENT');
                DimensionValue.SetRange(Code, "Department Code");
                if DimensionValue.FindFirst() then
                    "Department Name" := DimensionValue.Name;
            end;
        }
        field(8; "Leave Entitlement"; Decimal)
        {
            CalcFormula = Lookup("Leave Type".Days WHERE(Code = FIELD("Leave Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Employment Date"; Date)
        {
            Editable = false;
        }
        field(10; "Application Date"; Date)
        {
            Editable = false;
        }
        field(12; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(13; "Days in Plan"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Plan Line".Days WHERE("No." = FIELD("No.")));
            Editable = false;

        }
        field(14; "Leave Earned to Date"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Ledger Entry".Days WHERE(Closed = FILTER('No'),
                                                               "Leave Code" = FIELD("Leave Code"),
                                                               "Employee No." = FIELD("Employee No"),
                                                               "Earned Leave Days" = FILTER('Yes')));
            Editable = false;

        }
        field(16; "Recalled Days"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Ledger Entry".Days WHERE(Closed = FILTER('No'),
                                                               "Leave Code" = FIELD("Leave Code"),
                                                               "Employee No." = FIELD("Employee No"),
                                                               Recall = FILTER('Yes')));
            Editable = false;

        }
        field(17; "Off Days"; Decimal)
        {
            Editable = false;
        }
        field(18; "Total Leave Days"; Decimal)
        {
            Editable = false;
        }
        field(19; "Department Name"; Text[70])
        {
            Editable = false;
        }
        field(20; "Branch Name"; Text[70])
        {
            Editable = false;
        }
        field(21; "Job Title"; Text[70])
        {
            Editable = false;
        }
        field(22; "Balance Brought Forward"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Ledger Entry".Days WHERE("Employee No." = FIELD("Employee No"),
                                                               "Leave Code" = FILTER('ANNUAL'),
                                                               Days = FILTER(> 0),
                                                               Closed = filter('No'),
                                                               "Balance Brought Forward" = FILTER('Yes')));
            Editable = false;

        }
        field(24; "Total Leave Days Taken"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Ledger Entry".Days WHERE(Closed = FILTER('No'),
                                                               "Leave Code" = FIELD("Leave Code"),
                                                               "Employee No." = FIELD("Employee No")));
            Editable = false;

        }
        field(25; "Branch Code"; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange("Dimension Code", 'BRANCH');
                DimensionValue.SetRange(Code, "Department Code");
                if DimensionValue.FindFirst() then
                    "Branch Name" := DimensionValue.Name;
            end;
        }
        field(26; "Added Back Days"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Ledger Entry".Days WHERE(Closed = filter('No'),
                                                               "Added Back Days" = filter('Yes'),
                                                               "Employee No." = FIELD("Employee No")));
            Editable = false;

        }
        field(27; Year; Integer)
        {
            Editable = false;
        }
        field(28; "Created By"; code[80])
        {
            Editable = false;
        }
        field(29; "Created Date"; Date)
        {
            Editable = false;
        }
        field(30; "Created Time"; Time)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        HumanResSetup.GET();
        "No." := NoSeries.GetNextNo(HumanResSetup."Leave Plan Nos.", TODAY, TRUE);
        IF UserSetup.GET(USERID) THEN BEGIN
            //   "Employee No" := UserSetup."Employee No.";
            VALIDATE("Employee No");
            "User ID" := USERID;
            "Created By" := "User ID";
            "Created Date" := today;
            "Created Time" := time;
        END;
        Year := DATE2DMY(TODAY, 3)
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
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        HumanResSetup: Record "Human Resources Setup";
        NoSeries: Codeunit "No. Series";
        LeaveTypes: Record "Leave Type";
        LeavePlanLines: Record "Leave Plan Line";
        DimensionValue: Record "Dimension Value";
        LeavePlanHeader: record "Leave Plan Header";
}

