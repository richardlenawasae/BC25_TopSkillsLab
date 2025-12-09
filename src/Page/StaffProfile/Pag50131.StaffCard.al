page 50131 "Staff Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Employee;
    Caption = 'My Staff Card';
    InsertAllowed = FALSE;
    ModifyAllowed = FALSE;
    DeleteAllowed = FALSE;
    Editable = FALSE;

    layout
    {
        area(Content)
        {

            group("Personal Information")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s first name.';
                    trigger OnValidate()
                    begin
                        Rec."First Name" := UpperCase(Rec."First Name");
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s middle name.';
                    trigger OnValidate()
                    begin
                        Rec."Middle Name" := UpperCase(Rec."Middle Name");
                    end;

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s last name.';
                    trigger OnValidate()
                    begin
                        Rec."Last Name" := UpperCase(Rec."Last Name");
                    end;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the gender with which the employee identifies.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                    trigger OnValidate()
                    begin
                        if (Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3)) < 18 then
                            Error('Employee should be above 18 years');
                    end;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                // field(Disability; Rec.Disability)
                // {
                //     ApplicationArea = All;
                // }
                // field("Blood Type"; "Rec.Blood Type")
                // {
                //     ApplicationArea = All;
                // }
                // field(Religion;Rec. Religion)
                // {
                //     ApplicationArea = All;
                // }
                // field(Tribe; Rec.Tribe)
                // {
                //     ApplicationArea = All;
                // }
            }
            group("Job Information")
            {
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }

                field("Employee Status"; Rec."Employee Status")
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation Period field.';
                }

                field("Confirmation/Dismissal Date"; Rec."Confirmation/Dismissal Date")
                {
                    Caption = 'Confirmation Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Confirmation Date field.';
                }
                field("Job Code"; Rec."Job Code")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Code field.';
                }
                field("Employee Job Title"; Rec."Employee Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Job Title field.';
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Staff Category"; Rec."Staff Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Category field.';
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Name field.';

                }
                field("Second Supervisor ID"; Rec."Second Supervisor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Second Supervisor ID field.';
                }
                field("Second Supervisor Name"; Rec."Second Supervisor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Second Supervisor Name field.';

                }
                field("Leave Days"; Rec."Leave Days")
                {
                    Caption = 'Leave Balance';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Leave Balance field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }

                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Work Phone';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
            }
            group("Statutory Information")
            {
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the National ID field.';
                }
                field("KRA PIN"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PIN Number field.';
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NSSF field.';
                }
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                // field("HELB No."; Rec."HELB No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                // field("Employee Level"; Rec."Employee Level")
                // {
                //     ApplicationArea = All;
                // }
            }
            group("Contact Information")
            {
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s address.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code.';
                }
                field(City; Rec.City)
                {
                    Caption = 'Town';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city of the address.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s private telephone number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s private email address.';
                }
                // field("Resident(Estate)";Rec. "Resident(Estate)")
                // {
                //     ApplicationArea = All;
                // }
                // field("Street Address/Court";Rec. "Street Address/Court")
                // {
                //     ApplicationArea = All;
                // }
                // field("House No."; Rec."House No.")
                // {
                //     ApplicationArea = All;
                // }
            }
            group("Probation Information")
            {
                Visible = SeeProbation;

                field("Probation Start Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field("Probation Duration"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation Period field.';
                }
                field("Probation End Date"; Rec."Probation End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation End Date field.';
                }
            }
            // group("Clearance Details")
            // {
            //     Visible = SeeProbation;

            //     field("Certificate No."; Rec."Certificate No.")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Date of Certificate";Rec. "Date of Certificate")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Reference No.";Rec. "Reference No.")
            //     {
            //         ApplicationArea = All;
            //     }
            // }
            // group(Confirmation)
            // {
            //     Visible = SeeProbation;
            //     field("Confirmation Status";Rec."Confirmation Status")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Confirmation_Dismissal Date";Rec."Confirmation/Dismissal Date")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Defer Confirmation";Rec."Defer Confirmation")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Extension Duration"; Rec."Extension Duration")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Defer Start Date"; Rec."Defer Start Date")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Defer End Date";Rec. "Defer End Date")
            //     {
            //         ApplicationArea = All;
            //     }
            //}
            //     group(Audit)
            //     {
            //         Editable = false;
            //         field("Created By"; Rec."Created By")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Created Date"; Rec."Created Date")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Created Time"; Rec."Created Time")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Approved By"; Rec."Approved By")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Approved Date"; Rec."Approved Date")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Approved Time"; Rec."Approved Time")
            //         {
            //             ApplicationArea = All;
            //         }

            //         field("Last Modified By"; Rec."Last Modified By")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Last Modified Date"; Rec."Last Modified Date")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Last Modified time"; Rec."Last Modified time")
            //         {
            //             ApplicationArea = All;
            //         }

            //     }
        }

        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
                Editable = EditPic;
            }
            // part(Control4; "Employee Front ID")
            // {
            //     ApplicationArea = BasicHR;
            //     SubPageLink = "No." = field("No.");
            //     Editable = EditPic1;
            // }
            // part(Control5; "Employee Back ID")
            // {
            //     ApplicationArea = BasicHR;
            //     SubPageLink = "No." = FIELD("No.");
            //     Editable = EditPic2;
            // }
            // part(Control6; "Employee Signature")
            // {
            //     ApplicationArea = BasicHR;
            //     SubPageLink = "No." = FIELD("No.");
            //     Editable = EditPic3;
            // }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
                Editable = EditPic4;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
                //  Editable = EditPic5; marcked for removal
            }
        }
    }



    actions
    {
        area(Processing)
        {


            action("&Relatives")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Relatives';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Employee Relatives";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Open the list of relatives that are registered for the employee.';
            }
            action("Mi&sc. Article Information")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mi&sc. Article Information';
                Image = Filed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Misc. Article Information";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
            }
            action("&Confidential Information")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Confidential Information';
                Image = Lock;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Confidential Information";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Open the list of any confidential information that is registered for the employee.';
            }
            action("Q&ualifications")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Q&ualifications';
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Employee Qualifications";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'Open the list of qualifications that are registered for the employee.';
            }
            /* action("Assign Employee Number")
             {
                 Image = ChangeTo;
                 Promoted = true;
                 PromotedCategory = Process;
                 PromotedIsBig = true;
                 PromotedOnly = true;
                 ApplicationArea = All;

                 trigger OnAction();
                 begin
                     HRManagement."Assign Employee Number"("No.");
                     CurrPage.Close();
                 end;
             }*/
            action("Professional Membership")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Professional Membership';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the &Professional Membership action.';
                // RunObject = Page "Proffessional Bodies";
                // RunPageLink = "Employee No." = FIELD("No.");


            }
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';


                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }


        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        Rec."Last Modified Date Time" := CURRENTDATETIME;
        Rec."Last Date Modified" := TODAY;

        IF FORMAT(xRec) = FORMAT(Rec) THEN BEGIN
            HRManagement.CreateAuditTrail(xRec);
        END;
    end;

    trigger OnOpenPage();
    begin
        SeeProbation := False;
        if UserSetup.GET(UserId) then begin
            if UserSetup.HR then begin
                CurrPage.Editable := true;
            end else begin
                CurrPage.Editable := false;
                EditPic1 := False;
                EditPic2 := False;
                EditPic3 := False;
                EditPic4 := False;
                EditPic5 := False;
                EditPic := False;
            end;
        end;
        EmployeeDataView.RESET;
        IF EmployeeDataView.FINDLAST THEN BEGIN
            lastno := EmployeeDataView.No + 1;
        END;
        EmployeeDataView.INIT;
        EmployeeDataView.No := lastno;
        EmployeeDataView.User := USERID;
        EmployeeDataView."Employee No" := Rec."No.";
        EmployeeDataView."Employee Name" := Rec.FullName();
        EmployeeDataView.Date := TODAY;
        EmployeeDataView.Time := TIME;
        EmployeeDataView.INSERT;

    end;

    /* trigger OnQueryClosePage(CloseAction: Action): Boolean
     begin
         Employee.RESET;
         Employee.SetRange("No.", Rec."No.");
         IF Employee.FindFirst() THEN BEGIN
             IF (COPYSTR(Employee."No.", 1, 4) = 'APPL') THEN BEGIN
                 IF CONFIRM(TEXT001) THEN BEGIN
                     HRManagement."Assign Employee Number"(Rec."No.");
                 END;
             END;
         END;
     END;*/

    var
        UserSetup: Record "HR Users Setup";
        SeeProbation: Boolean;
        HRManagement: Codeunit "HR Management";
        EmployeeDataView: Record "Employee Data View";
        LastNo: Integer;
        Employee: Record Employee;
        TEXT001: Label 'You haven''t assigned the correct Employee No. Do you wish to proceed to Assign the Employee Number';
        EditPic1: Boolean;
        EditPic2: Boolean;
        EditPic3: Boolean;
        EditPic4: Boolean;
        EditPic5: Boolean;
        EditPic: Boolean;

}