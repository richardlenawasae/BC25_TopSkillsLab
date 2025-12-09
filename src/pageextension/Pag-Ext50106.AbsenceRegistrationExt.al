pageextension 50106 AbsenceRegistrationExt extends "Absence Registration"
{
    layout
    {
    }
    trigger OnOpenPage();
    begin
        HRUserSetup.Get(UserId);
        if (HRUserSetup.HOD) or (HRUserSetup."C.E.O") then
            exit;
        UserSetup.GET(UserID);
        Rec.Filtergroup(2);
        Rec.Setrange("Employee No.", UserSetup."Employee No.");
        Rec.Filtergroup(0);
    end;

    var

        UserSetup: Record "User Setup";
        HRUserSetup: Record "HR Users Setup";
}