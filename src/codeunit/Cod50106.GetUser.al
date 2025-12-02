codeunit 50106 "Get User"
{
    trigger OnRun()
    begin

    end;

    var
        PasswordMismatchErr: Label 'The passwords that you entered do not match.';
        PasswordTooSimpleErr: Label 'The password that you entered does not meet the minimum requirements. It must be at least %1 characters long and contain at least one uppercase letter, one lowercase letter, one number and one special character. It must not have a sequence of 3 or more ascending, descending or repeating characters.', Comment = '%1: The minimum number of characters required in the password';
        ConfirmBlankPasswordQst: Label 'Do you want to exit without entering a password?';

    procedure ValidatePasswordStrength_Temp(Password: Text)
    var
        PasswordHandler: Codeunit "Password Handler";
    begin
        //if not PasswordHandler.IsPasswordStrong(Password) then
        // Error(PasswordTooSimpleErr, PasswordHandler.GetPasswordMinLength());
    end;

    procedure OpenPasswordDialog_temp(DisablePasswordValidation: Boolean; DisablePasswordConfirmation: Boolean): Text
    var
        PasswordDialog: Page "Password Dialog";
    begin
        if DisablePasswordValidation then
            PasswordDialog.DisablePasswordValidation();
        if DisablePasswordConfirmation then
            PasswordDialog.DisablePasswordConfirmation();
        if PasswordDialog.RunModal() = ACTION::OK then
            // exit(PasswordDialog.GetPasswordValue());
            exit('');
    end;

    procedure OpenChangePasswordDialog_(var OldPassword: Text; var Password: Text)
    var
        PasswordDialog: Page "Password Dialog";
        SecretText: SecretText;
    begin

        PasswordDialog.EnableChangePassword();
        if PasswordDialog.RunModal() = ACTION::OK then begin
            // Password := PasswordDialog.GetPasswordValue();
            SecretText := PasswordDialog.GetPasswordSecretValue();
            SecretText := OldPassword;
            //OldPassword := PasswordDialog.GetOldPasswordValue();
            SecretText := PasswordDialog.GetOldPasswordSecretValue();
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure SetPassword(Username: Text[120]; OldPasswordValue: Text[80]; PasswordValue: Text[80]; ChangePssword: Boolean)
    var
    begin

    end;


    procedure ValidatePassword(RequiresPasswordConfirmation: Boolean; ValidatePassword: Boolean; Password: Text; ConfirmPassword: Text): Boolean
    begin
        if RequiresPasswordConfirmation and (Password <> ConfirmPassword) then
            Error(PasswordMismatchErr);

        if ValidatePassword then
            ValidatePasswordStrength(Password);
        if Password = '' then
            if not Confirm(ConfirmBlankPasswordQst) then
                exit(false);
        exit(true);
    end;

    procedure ValidatePasswordStrength(PasswordValue: Text[250]): Boolean
    var
        //PasswordDialogImpl: Codeunit "Password Dialog Impl.";
        PasswordHandler: Codeunit "Password Handler";
    begin
        //PasswordDialogImpl.ValidatePasswordStrength(PasswordValue);

    end;

    procedure PromptPasswordChange()
    var
        User: Record User;
    begin
        User.Reset();
        User.SetRange("User Name", GetUser());
        if User.FindFirst() then begin
            if Confirm('Are you sure you want to prompt the system for Password Change', false) then begin
                User."Change Password" := true;
                User.Modify();
                Message('Password Change Prompt Change Successfully activated\Log out of the system for you to change passowrd upon login using the current Password!');
            end;
        end;
    end;

    procedure GetUser(): Code[100]
    begin
        ActiveSession.Reset();
        ActiveSession.SetRange("Session ID", SessionId());
        if ActiveSession.FindFirst() then begin
            if StrLen(ActiveSession."User ID") > 0 then exit(ActiveSession."User ID");
        end;
        exit(UserId);
    end;

    procedure GetBranchCode(UserID: Code[100]): Code[100]
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserID);
        if UserSetup.FindFirst() then begin
            exit(UserSetup."Global Dimension 1 Code");
        end;
        exit(UserSetup."Global Dimension 1 Code");
    end;

    var
        ActiveSession: Record "Active Session";
}