<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Lecturers.aspx.cs" Inherits="Lecturers" %>

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
            $('#ResetConfirm').modal('show');
        }
        function DisableButton() {
            document.getElementById("<%=btnAddLecturer.ClientID %>").disabled = true;
            document.getElementById("<%=btnReplaceCoursesOfLecturer.ClientID %>").disabled = true;
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
        <div>

            <div class="container">
                <div style="width: 300px; text-align: right; padding-right: 15px; margin-top: -40px;">
                    <asp:ValidationSummary ID="vsLecturerAdd" ForeColor="Red" ValidationGroup="LecturerAdd" runat="server" DisplayMode="List" />
                </div>
                <div style="width: 270px;">
                    <div style="text-align: center; font-size: 10px;">
                        <h5>יצירת מרצה</h5>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvLecturerIDAdd" runat="server" Display="None" ErrorMessage="הזן מספר זהות" ControlToValidate="tbLecturerIDAdd" ValidationGroup="LecturerAdd"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revLecturerIDAdd" runat="server" Display="None" ErrorMessage="שדה מספר זהות צריך להכיל 9 ספרות" ControlToValidate="tbLecturerIDAdd" Text="*" ValidationExpression="[0-9]{9}" ForeColor="Red" ValidationGroup="LecturerAdd"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="tbLecturerIDAdd" dir="rtl" TextMode="Number" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblLecturerIDAdd" runat="server" Text="מספר זהות"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvFirstNameAdd" runat="server" ErrorMessage="הזן שם פרטי" ControlToValidate="tbLecturerFirstNameAdd" Display="None" ValidationGroup="LecturerAdd"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbLecturerFirstNameAdd" dir="rtl" MaxLength="35" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblLecturerFirstNameAdd" runat="server" Text="שם פרטי"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvLastNameAdd" runat="server" ErrorMessage="הזן שם משפחה" ControlToValidate="tbLecturerLastNameAdd" Display="None" ValidationGroup="LecturerAdd"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbLecturerLastNameAdd" dir="rtl" MaxLength="35" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblLecturerLastNameAdd" runat="server" Text="שם משפחה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvLecturerEmailAdd" runat="server" ErrorMessage="הזן אימייל" ControlToValidate="tbLecturerEmailAdd" Display="None" ValidationGroup="LecturerAdd"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revLecturerAdd" runat="server" ErrorMessage="אימייל שגוי" ControlToValidate="tbLecturerEmailAdd" Display="None" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ValidationGroup="LecturerAdd"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="tbLecturerEmailAdd" runat="server" MaxLength="100"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblLecturerEmailAdd" runat="server" Text="אימייל"></asp:Label>
                        </div>
                    </div>

                    <div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="בחר תמונה" Display="None" ControlToValidate="fulPictureAdd" ValidationGroup="LecturerAdd"></asp:RequiredFieldValidator>
                        <asp:FileUpload ID="fulPictureAdd" runat="server" accept=".png,.jpg,.jpeg,.gif" />
                        <div style="float: right">
                            <asp:Label ID="Label9" runat="server" Text="תמונה"></asp:Label>
                        </div>
                    </div>

                    <div style="text-align: center; padding-top: 5px;">
                        <asp:Button ID="btnAddLecturer" runat="server" Text="הוסף" CssClass="btn btn-secondary btn-sm" OnClick="btnAddLecturer_Click" ValidationGroup="LecturerAdd" />
                    </div>
                    <div style="text-align: center; font-weight: bold; font-size: large;">
                        <asp:Label ID="lblAddLecturerMessage" runat="server" Text=""></asp:Label>
                        <br />
                    </div>
                </div>
            </div>

            <hr />

            <div style="display: flex; justify-content: center; flex-wrap: wrap-reverse;">
                <div style="padding-right: 10px; padding-top: 15px;">
                    <asp:Button ID="btnSearchLecturers" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server" Text="חפש" OnClick="btnSearchLecturers_Click" />
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label7" runat="server" Text="שם משפחה"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbLecturerLastNameSearch" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label6" runat="server" Text="שם פרטי"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbLecturerFirstNameSearch" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label5" runat="server" Text="מספר זהות"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbLecturerIDSearch" dir="rtl" TextMode="Number" runat="server"></asp:TextBox>
                </div>
            </div>

            <br />

            <div style="flex: 1;">
                <asp:GridView ID="gvLecturers" runat="server" AutoGenerateColumns="False" ForeColor="#707083" DataKeyNames="LecturerID" DataSourceID="sdsLecturers" OnSelectedIndexChanged="gvLecturers_SelectedIndexChanged" OnRowDeleted="gvLecturers_RowDeleted" OnRowUpdated="gvLecturers_RowUpdated" AllowSorting="True" CssClass="grid" AllowPaging="True" OnRowCommand="gvLecturers_RowCommand" OnPageIndexChanged="gvLecturers_PageIndexChanged">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="פעיל" SortExpression="IsActive">
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsActiveEdit" runat="server" Checked='<%# Bind("IsActive") %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkIsActiveItem" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="תמונה" SortExpression="Picture">
                            <ItemTemplate>
                                <asp:Image ID="imgPicture" runat="server" ImageUrl='<%# ConfigurationManager.AppSettings["LecturersImagesPath"] + Eval("Picture") %>' Width="40px" Height="40px" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="אימייל" SortExpression="Email" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbLecturerEmail" runat="server" Height="20px" Width="80%" MaxLength="100" Style="text-align: center" Text='<%# Bind("Email") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLecturerEmailEdit" Display="none" ValidationGroup="LecturerEdit" ControlToValidate="tbLecturerEmail" runat="server" ErrorMessage="הזן אימייל"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revLecturerEdit" runat="server" Display="none" ErrorMessage="אימייל שגוי" ControlToValidate="tbLecturerEmail" ValidationGroup="LecturerEdit" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: left;">
                                    <asp:Label ID="Label4" runat="server" Width="130px" Text='<%# Bind("Email") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם משפחה" SortExpression="LastName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbLecturerLastNameEdit" runat="server" dir="rtl" Height="20px" Width="80%" MaxLength="35" Style="text-align: center" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLecturerLastNameEdit" Display="None" ValidationGroup="LecturerEdit" ControlToValidate="tbLecturerLastNameEdit" runat="server" ErrorMessage="הזן שם משפחה"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label3" runat="server" Width="160px" Text='<%# Bind("LastName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם פרטי" SortExpression="FirstName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbLecturerFirstNameEdit" runat="server" dir="rtl" Height="20px" Width="80%" MaxLength="35" Style="text-align: center" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLecturerFirstNameEdit" Display="none" runat="server" ErrorMessage="הזן שם פרטי" ControlToValidate="tbLecturerFirstNameEdit" ValidationGroup="LecturerEdit"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label2" runat="server" Width="160px" Text='<%# Bind("FirstName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="LecturerID" HeaderText="מספר זהות" ReadOnly="True" SortExpression="LecturerID" />
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Cancel" Text="בטל"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" ForeColor="#8C4510" CommandName="Update" Text="עדכן" ValidationGroup="LecturerEdit"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Select" Text="בחר"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Edit" Text="ערוך"></asp:LinkButton>
                                <asp:LinkButton ID="lbDelete" CommandName="Delete" runat="server" ForeColor="#8C4510" CommandArgument='<%#Eval("Picture") %>'>מחק</asp:LinkButton>
                                <asp:LinkButton ID="lbReset" CommandName="Reset" ForeColor="#8C4510" runat="server" CausesValidation="False" CommandArgument='<%#Eval("LecturerID") + ";" + Eval("Email") %>'>אפס</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>

            <br />

            <div style="text-align: center; font-weight: bold; font-size: large">
                <asp:Label ID="lblEditLecturerMessage" runat="server" Text=""></asp:Label>
            </div>
            <div style="text-align: center;">
                <asp:ValidationSummary ID="vsLecturerEdit" ForeColor="Red" ValidationGroup="LecturerEdit" runat="server" DisplayMode="List" />
            </div>
            <asp:SqlDataSource ID="sdsLecturers" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" DeleteCommand="spCheckDeleteLecturer" DeleteCommandType="StoredProcedure" InsertCommand="spAddLecturer" ProviderName="System.Data.SqlClient" UpdateCommand="spUpdateLecturer" UpdateCommandType="StoredProcedure" InsertCommandType="StoredProcedure" OnInserted="sdsLecturers_Inserted" OnUpdated="sdsLecturers_Updated" SelectCommand="spGetLecturers" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="LecturerID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="LecturerID" Type="Int32" />
                    <asp:Parameter Name="Password" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Picture" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="LecturerID" Type="Int32" />
                    <asp:Parameter Name="IsActive" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <div style="text-align: center">
                <asp:Label ID="lblCoursesOfLecturer" Font-Size="Large" Font-Bold="true" runat="server" Text="קורסים מקושרים"></asp:Label>
            </div>

            <div class="flex-container">
                <div style="flex: 0.10"></div>
                <div style="flex: 0.80; text-align: center;">
                    <asp:CheckBoxList ID="cblCourses" runat="server" CssClass="replace-data" dir="rtl" DataSourceID="sdsCourses" DataTextField="CourseName" DataValueField="CourseID" RepeatDirection="Horizontal" RepeatLayout="Flow"></asp:CheckBoxList>
                    <br />
                    <asp:Button ID="btnReplaceCoursesOfLecturer" runat="server"  CssClass="btn btn-secondary btn-sm" Text="עדכן" OnClick="btnReplaceCoursesOfLecturer_Click" />
                </div>
                <div style="flex: 0.10"></div>
            </div>
            <asp:SqlDataSource ID="sdsCourses" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetCourses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            <div hidden="hidden">
                    <asp:GridView ID="gvCoursesOfLecturer" runat="server" AutoGenerateColumns="False" ForeColor="#707083" DataSourceID="sdsCoursesOfLecturer" OnRowDataBound="gvCoursesOfLecturer_RowDataBound" CssClass="grid" AllowPaging="True" AllowSorting="True">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:BoundField DataField="LecturerID" HeaderText="LecturerID" SortExpression="LecturerID" Visible="False" />
                            <asp:BoundField DataField="CourseID" HeaderText="CourseID" InsertVisible="False" ReadOnly="True" SortExpression="CourseID" Visible="False" />
                            <asp:TemplateField HeaderText="CourseName" SortExpression="CourseName">
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
                <asp:Label ID="lblReplaceCoursesOfLecturerMessage" runat="server" Text=""></asp:Label>
            </div>

            <br />

            <asp:SqlDataSource ID="sdsCoursesOfLecturer" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetCoursesByLecturer" SelectCommandType="StoredProcedure" InsertCommand="spReplaceCoursesOfLecturerTry" InsertCommandType="StoredProcedure" OnInserted="sdsCoursesOfLecturer_Inserted">
                <InsertParameters>
                    <asp:Parameter Name="ListOfCourses" Type="String" />
                    <asp:Parameter Name="LecturerID" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="LecturerID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </div>

        <div class="modal fade" id="DeleteConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" style="float: left;" data-dismiss="modal" aria-label="Close">
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

        <div class="modal fade" id="ResetConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" style="float: left;" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel4">!אזהרה</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        ?האם אתה בטוח
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelReset" runat="server" Text="לא" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmReset" runat="server" Text="כן" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmReset_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
