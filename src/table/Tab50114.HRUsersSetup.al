table 50114 "HR Users Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Username; Code[100])
        {
            TableRelation = "User Setup";

            trigger OnValidate();
            begin
                //Email := u
            end;
        }
        field(2; Email; Code[100])
        {

        }
        field(50010; HOD; Boolean)
        {
            trigger OnValidate()
            begin
                if HOD = true then begin
                    if Department = '' then
                        Error('Department must have a value');
                    /*HRUsersSetup.RESET;
                    HRUsersSetup.SetRange(HOD, true);
                    HRUsersSetup.SetRange(Department, rec.Department);
                    if HRUsersSetup.FindFirst() then
                        error('HOD has already been setup');*/
                end;
            end;
        }
        field(50012; "C.E.O"; Boolean)
        {
            trigger OnValidate()
            begin
                if "C.E.O" = true then begin
                    HRUsersSetup.RESET;
                    HRUsersSetup.SetRange("C.E.O", true);
                    if HRUsersSetup.FindFirst() then
                        error('This permission can only be assgined to one user');

                end;
            end;
        }
        field(50014; Treasurer; Boolean)
        {
            trigger OnValidate()
            begin
                if Treasurer = true then begin
                    HRUsersSetup.RESET;
                    HRUsersSetup.SetRange(Treasurer, true);
                    if HRUsersSetup.FindFirst() then
                        error('This permission can only be assgined to one user');

                end;
            end;
        }
        field(50015; BOARD; Boolean)
        {
            trigger OnValidate()
            begin
                if BOARD = true then begin
                    HRUsersSetup.RESET;
                    HRUsersSetup.SetRange(BOARD, true);
                    if HRUsersSetup.FindFirst() then
                        error('This permission can only be assgined to one user');

                end;
            end;
        }
        field(50016; HR; Boolean)
        {
            trigger OnValidate()
            begin
                if HR = true then begin
                    HRUsersSetup.RESET;
                    HRUsersSetup.SetRange(HR, true);
                    if HRUsersSetup.FindFirst() then
                        error('This permission can only be assgined to one user');
                end;
            end;
        }
        field(50017; "Department"; Code[90])
        {
            TableRelation = "Dimension Value".code where("Dimension Code" = filter('DEPARTMENT'));
        }

    }

    keys
    {
        key(Key1; Username)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

        HRUsersSetup: record "HR Users Setup";

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