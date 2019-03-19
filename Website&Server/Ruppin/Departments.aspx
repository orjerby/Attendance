<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Departments.aspx.cs" Inherits="Departments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />

    <style>
        .replace-data {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            background-color: gainsboro;
            padding-top: 10px;
        }

            .replace-data input {
                width: 5%;
            }

            .replace-data label {
                text-align: right;
                white-space: nowrap;
                width: 20%;
                margin-top: -5px;
            }
    </style>

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function openModal() {
            $('#DeleteConfirm').modal('show');
        }
        function openModal2() {
            $('#DeleteConfirm2').modal('show');
        }
        function openModal3() {
            $('#ReplaceConfirm').modal('show');
        }
        function openModal4() {
            $('#ReplaceConfirm2').modal('show');
        }
        function DisableButton() {
            document.getElementById("<%=btnAddDepartment.ClientID %>").disabled = true;
            document.getElementById("<%=btnReplaceCoursesOfDepartment.ClientID %>").disabled = true;
            document.getElementById("<%=btnReplaceCyclesOfDepartment.ClientID %>").disabled = true;
        }
        window.onbeforeunload = DisableButton;
        $(document).ready(function () {
            $('.leftmenutrigger').on('click', function (e) {
                $('.side-nav').toggleClass("open");
                e.preventDefault();
            });
        });
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="wrapper" class="animate">
                <nav class="navbar header-top fixed-top navbar-expand-lg  navbar-dark bg-dark">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarText">
                        <ul class="navbar-nav animate side-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="Home.aspx">בית
                                    <span class="sr-only">(current)</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Administrators.aspx">מנהלים</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="LocationManagers.aspx">אחראי מיקום</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Departments.aspx">מגמות</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Cycles.aspx">מחזורים</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Courses.aspx">קורסים</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Classes.aspx">כיתות</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Lecturers.aspx">מרצים</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Students.aspx">סטודנטים</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Lectures.aspx">הרצאות</a>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="lnkbtnForms" class="nav-link" href="Forms.aspx" runat="server">אישורים</asp:LinkButton>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="Settings.aspx">הגדרות</a>
                            </li>
                            <li class="nav-item">
                                <asp:LinkButton ID="lnkbtnLogout" runat="server" CssClass="nav-link" OnClick="lnkbtnLogout_Click">התנתק</asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                    <a class="navbar-brand" href="#">רופין</a>
                    <span class="navbar-toggler-icon leftmenutrigger"></span>
                </nav>
            </div>

            <div class="container">
                <div style="width: 150px; text-align: right; padding-right: 15px; margin-top: -40px;">
                    <asp:ValidationSummary ID="vsDepartmentAdd" ValidationGroup="DepartmentAdd" ForeColor="Red" runat="server" DisplayMode="List" />
                </div>
                <div style="width: 250px;">
                    <div style="text-align: center; font-size: 10px;">
                        <h5>יצירת מגמה</h5>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvDepartmentNameAdd" Display="None" runat="server" ErrorMessage="הזן שם מגמה" ControlToValidate="tbDepartmentNameAdd" ValidationGroup="DepartmentAdd"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbDepartmentNameAdd" dir="rtl" MaxLength="50" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblDepartmentNameAdd" runat="server" Text="שם מגמה"></asp:Label>
                        </div>
                    </div>
                    <div style="text-align: center; padding-top: 5px;">
                        <asp:Button ID="btnAddDepartment" runat="server" Text="הוסף" OnClick="btnAddDepartment_Click" CssClass="btn btn-secondary btn-sm" ValidationGroup="DepartmentAdd" />
                    </div>
                    <div style="text-align: center; font-weight: bold; font-size: large;">
                        <asp:Label ID="lblAddDepartmentMessage" runat="server" Text=""></asp:Label>
                        <br />
                    </div>
                </div>
            </div>

            <hr />

            <div style="display: flex; justify-content: center; flex-wrap: wrap-reverse;">
                <div style="padding-right: 10px; padding-top: 15px;">
                    <asp:Button ID="btnSearchDepartments" runat="server" Text="חפש" CssClass="btn btn-outline-success my-2 my-sm-0" OnClick="btnSearchDepartments_Click" />
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label7" runat="server" MaxLength="50" Text="שם מגמה"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbDepartmentNameSearch" dir="rtl" runat="server"></asp:TextBox>
                </div>
            </div>

            <br />

            <div style="flex: 1;">
                <asp:GridView ID="gvDepartments" runat="server" AutoGenerateColumns="False" ForeColor="#707083" DataKeyNames="DepartmentID" DataSourceID="sdsDepartments" OnSelectedIndexChanged="gvDepartments_SelectedIndexChanged" OnRowDeleted="gvDepartments_RowDeleted" OnRowUpdated="gvDepartments_RowUpdated" AllowSorting="True" CssClass="grid" AllowPaging="True" OnPageIndexChanged="gvDepartments_PageIndexChanged">
                    <AlternatingRowStyle BackColor="White" CssClass="alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="פעיל" SortExpression="IsActive">
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsActiveEdit" runat="server" Checked='<%# Bind("IsActive") %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsActiveItem" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם מגמה" SortExpression="DepartmentName">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbDepartmentEdit" runat="server" dir="rtl" Height="20px" Width="80%" MaxLength="50" Style="text-align: center;" Text='<%# Bind("DepartmentName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDepartmentEdit" runat="server" Display="None" ErrorMessage="הזן שם מגמה" ControlToValidate="tbDepartmentEdit" ValidationGroup="DepartmentEdit"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" dir="rtl" Text='<%# Bind("DepartmentName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Cancel" Text="בטל"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" ForeColor="#8C4510" CommandName="Update" Text="עדכן" ValidationGroup="DepartmentEdit"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Select" Text="בחר"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Edit" Text="ערוך"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Delete" Text="מחק"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>

            <br />
            <div style="text-align: center; font-weight: bold; font-size: large">
                <asp:Label ID="lblEditDepartmentMessage" runat="server" Text=""></asp:Label>
            </div>
            <div style="text-align: center;">
                <asp:ValidationSummary ID="vsDepartmentEdit" ForeColor="Red" ValidationGroup="DepartmentEdit" runat="server" DisplayMode="List" />
            </div>
            <asp:SqlDataSource ID="sdsDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" DeleteCommand="spCheckDeleteDepartment" DeleteCommandType="StoredProcedure" InsertCommand="spAddDepartment" ProviderName="System.Data.SqlClient" UpdateCommand="spUpdateDepartment" UpdateCommandType="StoredProcedure" InsertCommandType="StoredProcedure" OnInserted="sdsDepartments_Inserted" SelectCommand="spGetDepartments" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="DepartmentID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DepartmentName" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DepartmentName" Type="String" />
                    <asp:Parameter Name="DepartmentID" Type="Int32" />
                    <asp:Parameter Name="IsActive" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <br />

            <div style="text-align: center">
                <asp:Label ID="lblCoursesOfDepartment" Font-Size="Large" Font-Bold="true" runat="server" Text="קורסים מקושרים"></asp:Label>
            </div>

            <div class="flex-container">
                <div style="flex: 0.10"></div>
                <div style="flex: 0.80; text-align: center;">
                    <asp:CheckBoxList ID="cblCourses" runat="server" CssClass="replace-data" dir="rtl" DataSourceID="sdsCourses" DataTextField="CourseName" DataValueField="CourseID" RepeatDirection="Horizontal" RepeatLayout="Flow"></asp:CheckBoxList>
                    <br />
                    <asp:Button ID="btnReplaceCoursesOfDepartment" runat="server"  CssClass="btn btn-secondary btn-sm" Text="עדכן" OnClick="btnReplaceCoursesOfDepartment_Click" />
                </div>
                <div style="flex: 0.10"></div>
            </div>
            <asp:SqlDataSource ID="sdsCourses" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCourses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            <div hidden="hidden">
                <asp:GridView ID="gvCoursesOfDepartment" runat="server" AutoGenerateColumns="False" DataKeyNames="CourseID" ForeColor="#707083" DataSourceID="sdsCoursesOfDepartment" OnRowDataBound="gvCoursesOfDepartment_RowDataBound" CssClass="grid" AllowPaging="True" AllowSorting="True">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:BoundField DataField="CourseID" HeaderText="CourseID" InsertVisible="False" ReadOnly="True" SortExpression="CourseID" Visible="False" />
                        <asp:TemplateField HeaderText="שם קורס" SortExpression="CourseName">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" dir="rtl" Text='<%# Bind("CourseName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>

            <div style="text-align: center; font-weight: bold; font-size: large">
                <asp:Label ID="lblReplaceCoursesOfDepartmentMessage" runat="server" Text=""></asp:Label>
            </div>

            <br />

            <asp:SqlDataSource ID="sdsCoursesOfDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" InsertCommand="spReplaceCoursesOfDepartmentTry" InsertCommandType="StoredProcedure" SelectCommand="spGetCoursesByDepartment" SelectCommandType="StoredProcedure" OnInserted="sdsCoursesOfDepartment_Inserted">
                <InsertParameters>
                    <asp:Parameter Name="ListOfCourses" Type="String" />
                    <asp:Parameter Name="DepartmentID" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="-1" Name="DepartmentID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <div style="text-align: center">
                <asp:Label ID="lblCyclesOfDepartment" Font-Size="Large" Font-Bold="true" runat="server" Text="מחזורים מקושרים"></asp:Label>
            </div>

            <div class="flex-container">
                <div style="flex: 0.10"></div>
                <div style="flex: 0.80; text-align: center;">
                    <asp:CheckBoxList ID="cblCycles" runat="server" CssClass="replace-data" dir="rtl" DataSourceID="sdsCycles" DataTextField="Name" DataValueField="CycleID" RepeatLayout="Flow" RepeatDirection="Horizontal"></asp:CheckBoxList>
                    <br />
                    <asp:Button ID="btnReplaceCyclesOfDepartment" runat="server"  CssClass="btn btn-secondary btn-sm" Text="עדכן" OnClick="btnReplaceCyclesOfDepartment_Click" />
                </div>
                <div style="flex: 0.10"></div>
            </div>
            <asp:SqlDataSource ID="sdsCycles" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCycles" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            <div hidden="hidden">
                <asp:GridView ID="gvCyclesOfDepartment" runat="server" AutoGenerateColumns="False" ForeColor="#707083" DataSourceID="sdsCyclesOfDepartment" OnRowDataBound="gvCyclesOfDepartment_RowDataBound" CssClass="grid" AllowPaging="True" AllowSorting="True">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="מחזור" SortExpression="Name">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" dir="rtl" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>

            <div style="text-align: center; font-weight: bold; font-size: large">
                <asp:Label ID="lblReplaceCyclesOfDepartmentMessage" runat="server" Text=""></asp:Label>
            </div>

            <br />

            <asp:SqlDataSource ID="sdsCyclesOfDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" InsertCommand="spReplaceCyclesOfDepartmentTry" InsertCommandType="StoredProcedure" SelectCommand="spGetCyclesByDepartment" SelectCommandType="StoredProcedure" OnInserted="sdsCyclesOfDepartment_Inserted">
                <InsertParameters>
                    <asp:Parameter Name="DepartmentID" Type="Int32" />
                    <asp:Parameter Name="ListOfCycles" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="DepartmentID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </div>

        <div class="modal fade" id="DeleteConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" style="float: left;" data-dismiss="!אזהרה" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel">!אזהרה</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        ?האם אתה בטוח
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelDelete" runat="server" Text="לא" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmDelete" runat="server" Text="כן" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmDelete_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="DeleteConfirm2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" style="float: left;" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel2">!שים לב</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        <asp:Label ID="lblConfirmMessage2" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelDelete2" runat="server" Text="אני מסרב" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmDelete2" runat="server" Text="אני מסכים" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmDelete2_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="ReplaceConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel3">!שים לב</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        <asp:Label ID="lblConfirmMessage3" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelReplace" runat="server" Text="אני מסרב" CssClass="btn btn-secondary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnCancelReplace_Click" />
                        <asp:Button ID="btnConfirmReplace" runat="server" Text="אני מסכים" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmReplace_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="ReplaceConfirm2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel4">!שים לב</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        <asp:Label ID="lblConfirmMessage4" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelReplace2" runat="server" Text="אני מסרב" CssClass="btn btn-secondary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnCancelReplace2_Click" />
                        <asp:Button ID="btnConfirmReplace2" runat="server" Text="אני מסכים" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmReplace2_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
