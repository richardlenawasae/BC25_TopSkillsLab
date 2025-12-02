tableextension 50102 EmployeeExt extends Employee
{
    fields
    {
        field(50100; "Employee Job Title"; Code[100])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50101; "PIN Number"; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ;
            end;
        }
        field(50102; "Taxable Income"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50103; "National ID"; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
            end;
        }
        field(50104; NSSF; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
            end;
        }
        field(50105; NHIF; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
            end;
        }
        field(50106; Department; Code[50])
        {
            TableRelation = "Dimension Value".code where("Dimension Code" = filter('DEPARTMENT'));
            DataClassification = CustomerContent;
        }
        field(50107; "Department Name"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50108; "Marital Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;

            trigger OnValidate();
            begin

            end;
        }
        field(50109; Age; Text[40])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50110; Citizenship; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50111; "Passport Number"; Text[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

            end;
        }
        field(50112; "Leave Days"; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = sum("Leave Ledger Entry".Days where("Employee No." = field("No."), "Leave Code" = filter("Leave Type"::Annual)));

        }
        field(50113; "Leave Allowance sent"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50114; "Supervisor ID"; Code[20])
        {
            TableRelation = Employee;
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                Employee.Reset();
                Employee.SetRange("No.", "Supervisor ID");
                if Employee.FindFirst() then begin
                    "Supervisor Name" := Employee.FullName();
                end;
            end;
        }
        field(50115; "Supervisor Name"; Text[100])
        {
            Editable = False;
            DataClassification = CustomerContent;
        }
        field(50116; "Employee Type"; Enum "Employee Type")
        {
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(50117; "Employee Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Active,Inactive,Terminated,Probation,Confirmed,Suspended,Dismissed;
        }
        field(50118; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                Age := FORMAT(DATE2DMY(TODAY, 3) - DATE2DMY("Date of Birth", 3)) + ' Years';

            end;
        }

        field(50119; "Basic Pay"; Decimal)
        {
        }
        // field(50120; "Member No."; Code[20])
        // {
        //     TableRelation = Member;
        // }
        field(50121; "Pay Tax"; Boolean)
        {
        }
        field(50122; Pensonable; Boolean)
        {
        }
        field(50123; "Department Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                DimensionValue.Reset;
                DimensionValue.SetRange("Dimension Code", "Department Code");
                if DimensionValue.FindFirst THEN begin
                    "Department Name" := DimensionValue.Name;
                end;
            end;
        }
        field(50124; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                //  ValidateShortcutDimCode(1, "Global Dimension 1 Code");

                DimensionValue.Reset;
                DimensionValue.SetRange("Dimension Code", "Branch Code");
                if DimensionValue.FindFirst THEN begin
                    //"Branch Name" := DimensionValue.Name;
                end;
            end;
        }
    }
    var
        Employee: Record Employee;
        DimensionValue: Record "Dimension Value";
}