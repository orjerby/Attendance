<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="AddLectures.aspx.cs" Inherits="AddLectures" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="css/bootstrap-formhelpers.min.css" rel="stylesheet" />
    <link href="css/jquery-clockpicker.min.css" rel="stylesheet" />
    <link href="css/bootstrap-clockpicker.min.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/jquery-clockpicker.min.js"></script>
    <script src="js/bootstrap-clockpicker.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-datepicker.min.js"></script>
    <script src="js/bootstrap-formhelpers.js"></script>
    <script src="locales/bootstrap-datepicker.he.min.js"></script>
    <script type="text/javascript">
        function openModal() {
            $('#DeleteConfirm').modal('show');
        }
        function openModal2() {
            $('#AddConfirm').modal('show');
        }
        function DisableButton() {
            document.getElementById("<%=btnAddLecturesInSemester.ClientID %>").disabled = true;
            document.getElementById("<%=btnAddLecture.ClientID %>").disabled = true;
        }
        window.onbeforeunload = DisableButton;
        $(document).ready(function () {
            $('#sandbox-container .input-daterange').datepicker({
                format: "dd/mm/yyyy",
                clearBtn: true,
                language: "he",
                daysOfWeekDisabled: "6",
                autoclose: true,
                todayHighlight: true,
                rtl: false
            });
            $('#sandbox-container2 input').datepicker({
                format: "dd/mm/yyyy",
                clearBtn: true,
                language: "he",
                daysOfWeekDisabled: "6",
                autoclose: true,
                todayHighlight: true,
                rtl: false
            });
            $('.clockpicker').clockpicker({
                donetext: 'אשר'
            });
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

            <div style="display: flex;">
                <div style="flex: 0.16"></div>
                <div style="flex: 0.24;">
                    <div style="text-align: center; font-size: 10px;">
                        <h5>יצירת הרצאות לסמסטר</h5>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvDepartmentsAdd" runat="server" ErrorMessage="בחר מגמה" Display="None" ValidationGroup="LecturesInSemesterAdd" ControlToValidate="ddlDepartmentsAdd" InitialValue="-1"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlDepartmentsAdd" runat="server" dir="rtl" Width="178px" AppendDataBoundItems="true" DataSourceID="sdsDepartmentsAdd" DataTextField="DepartmentName" DataValueField="DepartmentID" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartmentsAdd_SelectedIndexChanged">
                            <asp:ListItem Text="בחר מגמה" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsDepartmentsAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetDepartments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblDepartmentsAdd" runat="server" Text="מגמה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvCyclesAdd" runat="server" ErrorMessage="בחר מחזור" Display="None" ControlToValidate="ddlCyclesAdd" ValidationGroup="LecturesInSemesterAdd" InitialValue="-1"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlCyclesAdd" runat="server" dir="rtl" Width="178px" DataSourceID="sdsCyclesAdd" DataTextField="Name" DataValueField="CycleID" AutoPostBack="True" OnDataBound="ddlCyclesAdd_DataBound"></asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCyclesAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetCyclesByDepartment" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="DepartmentID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblCyclesAdd" runat="server" Text="מחזור"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvCoursesAdd" Display="None" ValidationGroup="LecturesInSemesterAdd" ControlToValidate="ddlCoursesAdd" runat="server" ErrorMessage="בחר קורס" InitialValue="-1"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlCoursesAdd" runat="server" dir="rtl" Width="178px" DataSourceID="sdsCoursesAdd" DataTextField="CourseName" DataValueField="CourseID" AutoPostBack="True" OnDataBound="ddlCoursesAdd_DataBound" OnSelectedIndexChanged="ddlCoursesAdd_SelectedIndexChanged"></asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCoursesAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCoursesByDepartment" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="DepartmentID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblStudentEmailAdd" runat="server" Text="קורס"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvLecturersAdd" Display="None" ValidationGroup="LecturesInSemesterAdd" ControlToValidate="ddlLecturersAdd" runat="server" ErrorMessage="בחר מרצה" InitialValue="-1"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlLecturersAdd" runat="server" dir="rtl" Width="178px" DataSourceID="sdsLecturersAdd" DataTextField="Name" DataValueField="LecturerID" AutoPostBack="True" OnDataBound="ddlLecturersAdd_DataBound"></asp:DropDownList>
                        <asp:SqlDataSource ID="sdsLecturersAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetLecturersByCourse" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="CourseID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblStudentLastNameAdd" runat="server" Text="מרצה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvClassesAdd" Display="None" runat="server" ValidationGroup="LecturesInSemesterAdd" ControlToValidate="ddlClassesAdd" ErrorMessage="בחר כיתה" InitialValue="-1"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlClassesAdd" runat="server" dir="rtl" Width="178px" AppendDataBoundItems="true" DataSourceID="sdsClassesAdd" DataTextField="ClassName" DataValueField="ClassID" AutoPostBack="True">
                            <asp:ListItem Text="בחר כיתה" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsClassesAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetClasses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblStudentIDAdd" runat="server" Text="כיתה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvWeekdaysAdd" runat="server" ErrorMessage="בחר יום" Display="None" ValidationGroup="LecturesInSemesterAdd" ControlToValidate="ddlWeekdaysAdd" InitialValue="-1"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlWeekdaysAdd" runat="server" dir="rtl" Width="178px" AppendDataBoundItems="true" DataSourceID="ssdWeekdaysAdd" DataTextField="WeekdayName" DataValueField="WeekdayID" AutoPostBack="True">
                            <asp:ListItem Text="בחר יום" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="ssdWeekdaysAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetWeekdays" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblStudentFirstNameAdd" runat="server" Text="יום"></asp:Label>
                        </div>
                    </div>
                    <div style="display: flex;">
                        <asp:RequiredFieldValidator ID="rfvBeginHourAdd" runat="server" ErrorMessage="הזן שעת התחלה" Display="None" ValidationGroup="LecturesInSemesterAdd" ControlToValidate="tbBeginHourAdd"></asp:RequiredFieldValidator>
                        <div class="input-group clockpicker" style="flex: 1; order: 2;">
                            <asp:TextBox ID="tbBeginHourAdd" Style="text-align: center" runat="server" CssClass="form-control" placeholder="שעת התחלה"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEndHourAdd" Display="None" ControlToValidate="tbEndHourAdd" ValidationGroup="LecturesInSemesterAdd" runat="server" ErrorMessage="הזן שעת סיום"></asp:RequiredFieldValidator>
                        <div class="input-group clockpicker" style="flex: 1; order: 1;">
                            <asp:TextBox ID="tbEndHourAdd" runat="server" Style="text-align: center" CssClass="form-control" placeholder="שעת סיום"></asp:TextBox>
                        </div>
                    </div>
                    <div id="sandbox-container">
                        <div class="input-daterange input-group" id="datepicker">
                            <div style="order: 2; flex: 1;">
                                <asp:RequiredFieldValidator ID="rfvOpenDateAdd" runat="server" ErrorMessage="בחר תאריך פתיחה" Display="None" ControlToValidate="tbOpenDateAdd" ValidationGroup="LecturesInSemesterAdd"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="tbOpenDateAdd" runat="server" placeholder="תאריך פתיחה" dir="rtl" CssClass="input-sm form-control" name="start"></asp:TextBox>
                            </div>
                            <div style="order: 1; flex: 1;">
                                <asp:RequiredFieldValidator ID="rfvEndDateAdd" Display="None" runat="server" ErrorMessage="בחר תאריך סגירה" ControlToValidate="tbEndDateAdd" ValidationGroup="LecturesInSemesterAdd"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="tbEndDateAdd" runat="server" placeholder="תאריך סגירה" dir="rtl" CssClass="input-sm form-control" name="end"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center; padding-top: 5px;">
                        <asp:Button ID="btnAddLecturesInSemester" runat="server" Text="הוסף" CssClass="btn btn-secondary btn-sm" OnClick="btnAddLecturesInSemester_Click" ValidationGroup="LecturesInSemesterAdd" />
                    </div>
                    <div style="text-align: center; font-weight: bold; font-size: medium;">
                        <asp:Label ID="lblAddLecturesInSemesterMessage" runat="server" Text=""></asp:Label>

                        <br />
                    </div>
                </div>

                <div style="flex: 0.2; text-align: center; padding-top: 20px;">

                    <asp:ValidationSummary ID="vsLecturesInSemesterAdd" ForeColor="Red" ValidationGroup="LecturesInSemesterAdd" runat="server" DisplayMode="List" />
                    <asp:ValidationSummary ID="vsLectureAdd" ForeColor="Red" ValidationGroup="LectureAdd" runat="server" DisplayMode="List" />

                </div>

                <div style="flex: 0.24;">
                    <div style="text-align: center; font-size: 10px;">
                        <h5>יצירת הרצאה</h5>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvDepartmentsAdd2" runat="server" InitialValue="-1" ErrorMessage="בחר מגמה" ValidationGroup="LectureAdd" ControlToValidate="ddlDepartmentsAdd2" Display="None"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlDepartmentsAdd2" runat="server" dir="rtl" Width="178px" AppendDataBoundItems="true" DataSourceID="sdsDepartmentsAdd2" DataTextField="DepartmentName" DataValueField="DepartmentID" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartmentsAdd2_SelectedIndexChanged">
                            <asp:ListItem Text="בחר מגמה" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsDepartmentsAdd2" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetDepartments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="Label3" runat="server" Text="מגמה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvCyclesAdd2" runat="server" InitialValue="-1" ErrorMessage="בחר מחזור" Display="None" ValidationGroup="LectureAdd" ControlToValidate="ddlCyclesAdd2"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlCyclesAdd2" runat="server" dir="rtl" Width="178px" DataSourceID="sdsCyclesAdd2" DataTextField="Name" DataValueField="CycleID" AutoPostBack="True" OnDataBound="ddlCyclesAdd2_DataBound"></asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCyclesAdd2" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetCyclesByDepartment" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="DepartmentID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="Label4" runat="server" Text="מחזור"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvCoursesAdd2" runat="server" InitialValue="-1" ErrorMessage="בחר קורס" Display="None" ValidationGroup="LectureAdd" ControlToValidate="ddlCoursesAdd2"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlCoursesAdd2" runat="server" dir="rtl" Width="178px" DataSourceID="sdsCoursesAdd2" DataTextField="CourseName" DataValueField="CourseID" AutoPostBack="True" OnSelectedIndexChanged="ddlCoursesAdd2_SelectedIndexChanged" OnDataBound="ddlCoursesAdd2_DataBound"></asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCoursesAdd2" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCoursesByDepartment" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="DepartmentID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="Label5" runat="server" Text="קורס"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvLecturersAdd2" runat="server" InitialValue="-1" ErrorMessage="בחר מרצה" Display="None" ValidationGroup="LectureAdd" ControlToValidate="ddlLecturersAdd2"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlLecturersAdd2" runat="server" dir="rtl" Width="178px" DataSourceID="sdsLecturersAdd2" DataTextField="Name" DataValueField="LecturerID" AutoPostBack="True" OnDataBound="ddlLecturersAdd2_DataBound"></asp:DropDownList>
                        <asp:SqlDataSource ID="sdsLecturersAdd2" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetLecturersByCourse" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="CourseID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="Label6" runat="server" Text="מרצה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvClassesAdd2" runat="server" InitialValue="-1" ErrorMessage="בחר כיתה" Display="None" ValidationGroup="LectureAdd" ControlToValidate="ddlClassesAdd2"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlClassesAdd2" runat="server" dir="rtl" Width="178px" AppendDataBoundItems="true" DataSourceID="sdsClassesAdd2" DataTextField="ClassName" DataValueField="ClassID" AutoPostBack="True">
                            <asp:ListItem Text="בחר כיתה" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsClassesAdd2" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetClasses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="Label7" runat="server" Text="כיתה"></asp:Label>
                        </div>
                    </div>

                    <div style="display: flex;">
                        <asp:RequiredFieldValidator ID="rfvBeginHourAdd2" runat="server" ErrorMessage="הזן שעת התחלה" Display="None" ValidationGroup="LectureAdd" ControlToValidate="tbBeginHourAdd2"></asp:RequiredFieldValidator>
                        <div class="input-group clockpicker" style="flex: 1; order: 2;">
                            <asp:TextBox ID="tbBeginHourAdd2" runat="server" Style="text-align: center" CssClass="form-control" placeholder="שעת פתיחה"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEndHourAdd2" runat="server" ErrorMessage="הזן שעת סיום" Display="None" ValidationGroup="LectureAdd" ControlToValidate="tbEndHourAdd2"></asp:RequiredFieldValidator>
                        <div class="input-group clockpicker" style="flex: 1; order: 1;">
                            <asp:TextBox ID="tbEndHourAdd2" runat="server" Style="text-align: center" CssClass="form-control" placeholder="שעת סיום"></asp:TextBox>
                        </div>
                    </div>
                    <div id="sandbox-container2">
                        <asp:RequiredFieldValidator ID="rfvLectureDateAdd" runat="server" ErrorMessage="בחר תאריך" Display="None" ValidationGroup="LectureAdd" ControlToValidate="tbLectureDateAdd"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbLectureDateAdd" runat="server" Style="text-align: center" placeholder="תאריך" dir="rtl" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div style="text-align: center; padding-top: 5px;">

                        <asp:Button ID="btnAddLecture" runat="server" Text="הוסף" CssClass="btn btn-secondary btn-sm" OnClick="btnAddLecture_Click" ValidationGroup="LectureAdd" />
                    </div>
                    <div style="text-align: center; font-weight: bold; font-size: medium;">
                        <asp:Label ID="lblAddLectureMessage" runat="server" Text=""></asp:Label>

                        <br />
                    </div>
                </div>
                <div style="flex: 0.16"></div>
            </div>

            <div style="flex: 1;">
                <asp:GridView ID="gvLecturesInSemesters" runat="server" ForeColor="#707083" AutoGenerateColumns="False" DataKeyNames="DepartmentID,CourseID,LecturerID,WeekdayID,ClassID" OnRowCommand="gvLecturesInSemesters_RowCommand" DataSourceID="sdsLecturesInSemesters" AllowSorting="True" CssClass="grid" AllowPaging="True" OnRowDataBound="gvLecturesInSemesters_RowDataBound">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:BoundField DataField="DepartmentID" HeaderText="DepartmentID" InsertVisible="False" ReadOnly="True" SortExpression="DepartmentID" Visible="False" />
                        <asp:BoundField DataField="CourseID" HeaderText="CourseID" InsertVisible="False" ReadOnly="True" SortExpression="CourseID" Visible="False" />
                        <asp:BoundField DataField="LecturerID" HeaderText="LecturerID" ReadOnly="True" SortExpression="LecturerID" Visible="False" />
                        <asp:BoundField DataField="WeekdayID" HeaderText="WeekdayID" ReadOnly="True" SortExpression="WeekdayID" Visible="False" />
                        <asp:BoundField DataField="ClassID" HeaderText="ClassID" InsertVisible="False" ReadOnly="True" SortExpression="ClassID" Visible="False" />
                        <asp:BoundField DataField="CycleID" HeaderText="CycleID" Visible="False" />
                        <asp:TemplateField HeaderText="תאריך סגירה" SortExpression="EndDate">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("EndDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Font-Size="Small" Text='<%# Bind("EndDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="תאריך פתיחה" SortExpression="OpenDate">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("OpenDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label8" runat="server" Font-Size="Small" Text='<%# Bind("OpenDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="סיום" SortExpression="EndHour">
                            <ItemTemplate>
                                <asp:Label ID="lblEndHour" runat="server" Font-Size="Small" Text='<%# Bind("EndHour") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="התחלה" SortExpression="BeginHour">
                            <ItemTemplate>
                                <asp:Label ID="lblBeginHour" runat="server" Font-Size="Small" Text='<%# Bind("BeginHour") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="יום" SortExpression="WeekdayName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("WeekdayName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Font-Size="Small" Text='<%# Bind("WeekdayName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="כיתה" SortExpression="ClassName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ClassName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label2" runat="server" Width="30px" Font-Size="Small" Text='<%# Bind("ClassName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מרצה" SortExpression="Name" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label3" runat="server" Width="80px" Font-Size="Small" Text='<%# Bind("Name") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="קורס" SortExpression="CourseName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("CourseName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label4" runat="server" Width="80px" Font-Size="Small" Text='<%# Bind("CourseName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מחזור" SortExpression="CycleName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("CycleFullName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label5" runat="server" Width="30px" Font-Size="Small" Text='<%# Bind("CycleFullName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מגמה" SortExpression="DepartmentName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label6" runat="server" Width="80px" Font-Size="Small" Text='<%# Bind("DepartmentName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbDelete" CommandName="DeleteRow" Font-Size="Small" runat="server" ForeColor="#8C4510" CommandArgument='<%#Eval("DepartmentID") + ";" + Eval("CycleID") + ";" + Eval("WeekdayID") + ";" + Eval("BeginHour") + ";" + Eval("EndHour") + ";" +Eval("OpenDate") + ";" + Eval("EndDate") %>'>מחק</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>
        </div>
        <br />
        <div style="text-align: center; font-weight: bold; font-size: large">
            <asp:Label ID="lblEditLecturesInSemesterMessage" runat="server" Text=""></asp:Label>
        </div>
        <asp:SqlDataSource ID="sdsLecturesInSemesters" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetLecturesInSemesters" SelectCommandType="StoredProcedure" InsertCommand="spCheckAddLecture" InsertCommandType="StoredProcedure" OnInserted="sdsLecturesInSemesters_Inserted">
            <InsertParameters>
                <asp:Parameter Name="CourseID" Type="Int32" />
                <asp:Parameter Name="DepartmentID" Type="Int32" />
                <asp:Parameter Name="LecturerID" Type="Int32" />
                <asp:Parameter Name="BeginHour" DbType="Time" />
                <asp:Parameter Name="EndHour" DbType="Time" />
                <asp:Parameter Name="CycleID" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>

        <div class="modal fade" id="DeleteConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" style="float: left;" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel2">!אזהרה</h5>
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

        <div class="modal fade" id="AddConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" style="float: left;" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel">!שים לב</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        <asp:Label ID="lblConfirmMessage2" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelAdd" runat="server" Text="אני מסרב" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmAdd" runat="server" Text="אני מסכים" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmAdd_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
