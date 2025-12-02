// page 50120 "Approved Lieu List"
// {
//     Caption = 'Approved Lieu List';
//     PageType = List;
//     CardPageId = "Lieu Card";
//     UsageCategory = Lists;
//     ApplicationArea = All;
//     SourceTable = "LIEU Table";
//     Editable = false;
//     DeleteAllowed = false;
//     SourceTableView = where("Lieu Status" = filter(Approved));

//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 field("Employee No"; "Employee No")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Employee Name"; "Employee Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Leave Balances"; "Leave Balances")
//                 {

//                 }
//                 field("Leave Code"; "Leave Code")
//                 {

//                 }

//             }
//         }
//         area(Factboxes)
//         {

//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction();
//                 begin

//                 end;
//             }
//         }
//     }
// }