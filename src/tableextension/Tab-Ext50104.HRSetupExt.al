tableextension 50104 HRSetupExt extends "Human Resources Setup"
{
    fields
    {
        field(32; "Leave Nos."; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(5; "Leave Plan Nos."; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(6; "Disciplinary Cases Nos."; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(7; "Incident Nos"; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; "File Path"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Leave Recall Nos."; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(10; "HR E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Employee Docs File Path"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Permanent Probation"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Intern Probation"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Contract Probation"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Staff Transfer Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(16; "Training Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(17; "Training Request Source"; Option)
        {
            OptionCaption = '" ,Employee,HOD,Both"';
            OptionMembers = " ",Employee,HOD,Both;
            DataClassification = CustomerContent;
        }
        field(18; "Separation No"; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(19; "Recruitment Needs Nos."; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(20; "Department Dimension Code"; Code[10])
        {
            TableRelation = Dimension.Code;
            DataClassification = CustomerContent;
        }
        field(21; "Use Quantitative Goals"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Use Qualitative Goals"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Individual Appraisal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Supervisor Appraisal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Agreed Appraisal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Contract Nos."; Code[30])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(27; "Capture Training Requests"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Evaluation No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(29; "Job Application Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(30; "Review Frequency"; Option)
        {
            OptionCaption = ',Monthly,Quarterly,Bi-Annually,Annually';
            OptionMembers = ,Monthly,Quarterly,"Bi-Annually",Annually;
            DataClassification = CustomerContent;
        }
        field(31; "Performance Review Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(33; "Performance Contract Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(34; "Activate HR Audit Trail"; Boolean)
        {
            DataClassification = CustomerContent;

        }
        field(35; "Job List Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(36; "Permanant Employee Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(37; "Intern Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(38; "Contract Employee Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(39; "Appeal Case Period"; DateFormula)
        {
            DataClassification = CustomerContent;

        }
        field(40; "HR Audit Nos."; Code[40])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(41; "Competency Nos"; Code[40])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(42; "MCO Nos"; Code[40])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(43; "Employee Reinstatement"; Code[40])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(44; "Base Calendar Code"; Code[20])
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
    }

    fieldgroups
    {
    }

    var
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        Text001: Label 'You cannot change %1 because there are %2.';
}

