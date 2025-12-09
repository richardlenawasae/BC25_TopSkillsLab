page 50105 "Leave Attachment"
{
    Caption = 'Leave Attachment';
    PageType = ListPart;
    SourceTable = "HR Attachment";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(R1)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Name field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AttachFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attach File';
                Image = Attach;
                ToolTip = 'Attach a file to the Leave Application';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    FileName := FileManagement.GetFileName(FileName);
                    IF FileName = '' THEN
                        EXIT;
                    HRManagement.AddAttachment(FORMAT(RecID), DocNo, FileName);
                end;
            }
            action(ViewFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View File';
                Image = ViewOrder;
                Scope = Repeater;
                ToolTip = 'View the file that is attached to the incoming document record.';

                trigger OnAction()
                begin
                    CBSAttachment.RESET();
                    CBSAttachment.SETRANGE("Entry No.", Rec."Entry No.");
                    IF CBSAttachment.FINDFIRST() THEN BEGIN
                        CBSAttachment.CALCFIELDS(Attachment);
                        FileManagement.BLOBExport(TempBlob, Rec."File Name", TRUE);
                    END;
                end;
            }
        }
    }

    var
        CBSAttachment: Record "HR Attachment";
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        RecID: RecordID;
        DocNo: Code[20];
        SelectPictureTxt: Label 'Select a file to upload';
        HRManagement: Codeunit "HR Management";

    procedure SetParameter(RecordID: RecordID; DocumentNo: Code[20])
    begin
        RecID := RecordID;
        DocNo := DocumentNo;
    end;
}

