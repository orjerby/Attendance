<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Lectures.aspx.cs" Inherits="Lectures" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="css/jquery-clockpicker.min.css" rel="stylesheet" />
    <link href="css/bootstrap-clockpicker.min.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap-clockpicker.min.js"></script>
    <script src="js/jquery-clockpicker.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-datepicker.min.js"></script>
    <script src="locales/bootstrap-datepicker.he.min.js"></script>
    <script type="text/javascript">
        function openModal() {
            $('#DeleteConfirm').modal('show');
        }
        function openModal2() {
            $('#DeleteConfirm2').modal('show');
        }
        $(document).ready(function () {
            $('#sandbox-container input').datepicker({
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

        <div style="text-align: center;">
            <asp:Button ID="btnToAddLecturesPage" runat="server" CssClass="btn" Text="הוספת הרצאות" OnClick="btnToAddLecturesPage_Click" />
        </div>

        <br />

        <div style="display: flex; justify-content: center; flex-wrap: wrap-reverse;">
            <div style="padding-right: 10px; padding-top: 12px;">
                <asp:Button ID="btnSearch" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server" Text="חפש" OnClick="btnSearch_Click" />
            </div>
            <div>
                <div style="text-align: center;">
                    <asp:Label ID="Label13" runat="server" Text="מרצה"></asp:Label>
                </div>
                <asp:DropDownList ID="ddlLecturersSearch" Width="178px" dir="rtl" AppendDataBoundItems="true" runat="server" DataSourceID="sdsLecturersSearch" DataTextField="Name" DataValueField="LecturerID">
                    <asp:ListItem Text="כל המרצים" Value="0"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsLecturersSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetLecturers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </div>
            <div>
                <div style="text-align: center;">
                    <asp:Label ID="Label6" runat="server" Text="קורס"></asp:Label>
                </div>
                <asp:DropDownList ID="ddlCoursesSearch" runat="server" dir="rtl" Width="178px" AppendDataBoundItems="true" DataSourceID="sdsCoursesSearch" DataTextField="CourseName" DataValueField="CourseID">
                    <asp:ListItem Text="כל הקורסים" Value="0"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCoursesSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCourses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </div>
            <div>
                <div style="text-align: center;">
                    <asp:Label ID="Label8" runat="server" Text="מחזור"></asp:Label>
                </div>
                <asp:DropDownList ID="ddlCyclesSearch" dir="rtl" Width="178px" AppendDataBoundItems="true" runat="server" DataSourceID="sdsCyclesSearch" DataTextField="Name" DataValueField="CycleID">
                    <asp:ListItem Text="כל המחזורים" Value="0"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCyclesSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetCycles" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </div>
            <div>
                <div style="text-align: center;">
                    <asp:Label ID="Label3" runat="server" Text="מגמה"></asp:Label>
                </div>
                <asp:DropDownList ID="ddlDepartmentsSearch" runat="server" dir="rtl" Width="178px" AppendDataBoundItems="true" DataSourceID="sdsDepartmentsSearch" DataTextField="DepartmentName" DataValueField="DepartmentID">
                    <asp:ListItem Text="כל המגמות" Value="0"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsDepartmentsSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetDepartments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </div>
        </div>

        <br />

        <div style="flex: 1;">
            <asp:GridView ID="gvLectures" runat="server" AllowPaging="True" AutoGenerateColumns="False" ForeColor="#707083" DataKeyNames="LectureID,CourseID" DataSourceID="sdsLectures" OnRowCommand="gvLectures_RowCommand" AllowSorting="True" CssClass="grid" OnPageIndexChanged="gvLectures_PageIndexChanged" OnRowDataBound="gvLectures_RowDataBound">
                <AlternatingRowStyle CssClass="alt" />
                <Columns>
                    <asp:TemplateField HeaderText="LectureID" InsertVisible="False" SortExpression="LectureID" Visible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("LectureID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CycleID" HeaderText="CycleID" InsertVisible="False" SortExpression="CycleID" Visible="False" />
                    <asp:TemplateField HeaderText="מבוטל" SortExpression="Iscanceled">
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkIsCanceled" Width="" runat="server" Checked='<%# Bind("Iscanceled") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Iscanceled") %>' Enabled="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="תאריך" SortExpression="LectureDate">
                        <EditItemTemplate>
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <div id="sandbox-container">
                                    <asp:TextBox ID="tbLectureDateEdit" runat="server" Font-Size="Small" Height="20px" Width="95px" placeholder="בחר תאריך" CssClass="form-control" Text='<%# Bind("LectureDate", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLectureDateEdit" runat="server" Display="None" ErrorMessage="הזן תאריך" ValidationGroup="LectureEdit" ControlToValidate="tbLectureDateEdit"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Font-Size="Small" Text='<%# Bind("LectureDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CourseID" InsertVisible="False" SortExpression="CourseID" Visible="False">
                        <ItemTemplate>
                            <asp:Label ID="lbCourseID" runat="server" Text='<%# Bind("CourseID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ClassID" InsertVisible="False" SortExpression="ClassID" Visible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("ClassID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DepartmentID" InsertVisible="False" SortExpression="DepartmentID" Visible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סיום" SortExpression="EndHour">
                        <EditItemTemplate>
                            <div class="input-group clockpicker">
                                <asp:TextBox ID="tbEndHourEdit" Style="text-align: center" Font-Size="Small" Height="20px" Width="55px" runat="server" CssClass="form-control" placeholder="שעת סיום" Text='<%# Bind("EndHour") %>'></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvEndHourEdit" runat="server" Display="None" ErrorMessage="הזן שעת סיום" ControlToValidate="tbEndHourEdit" ValidationGroup="LectureEdit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblEndHour" runat="server" Font-Size="Small" Text='<%# Bind("EndHour") %>' HtmlEncode="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="התחלה" SortExpression="BeginHour">
                        <EditItemTemplate>
                            <div class="input-group clockpicker">
                                <asp:TextBox ID="tbBeginHourEdit" Style="text-align: center" Font-Size="Small" runat="server" Height="20px" Width="5px" CssClass="form-control" placeholder="שעת פתיחה" Text='<%# Bind("BeginHour") %>'></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvBeginHourEdit" runat="server" Display="None" ErrorMessage="הזן שעת פתיחה" ValidationGroup="LectureEdit" ControlToValidate="tbBeginHourEdit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBeginHour" runat="server" Font-Size="Small" Text='<%# Bind("BeginHour") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="יום" SortExpression="WeekdayName">
                        <ItemTemplate>
                            <asp:Label ID="Label12" runat="server" Font-Size="Small" Text='<%# Bind("WeekdayName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="כיתה" SortExpression="ClassName" ItemStyle-Wrap="false">
                        <EditItemTemplate>
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <asp:DropDownList ID="ddlClassesEdit" runat="server" dir="rtl" Height="20px" Width="80px" Font-Size="Small" DataSourceID="sdsClassesEdit" DataTextField="ClassName" DataValueField="ClassID" SelectedValue='<%# Bind("ClassID") %>'>
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvClassesEdit" runat="server" Display="None" ErrorMessage="בחר כיתה" ControlToValidate="ddlClassesEdit" ValidationGroup="LectureEdit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: right; direction: rtl">
                                <asp:Label ID="Label2" runat="server" Width="30px" Font-Size="Small" Text='<%# Bind("ClassName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="מרצה" SortExpression="Name" ItemStyle-Wrap="false">
                        <EditItemTemplate>
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <asp:DropDownList ID="ddlLecturersEdit" runat="server" dir="rtl" Height="20px" Width="80px" Font-Size="Small" DataSourceID="sdsLecturersEdit" DataTextField="Name" DataValueField="LecturerID" SelectedValue='<%# Bind("LecturerID") %>' AutoPostBack="True">
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvLecturersEdit" runat="server" Display="None" ErrorMessage="בחר מרצה" ControlToValidate="ddlLecturersEdit" ValidationGroup="LectureEdit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: right; direction: rtl">
                                <asp:Label ID="Label1" runat="server" Width="80px" Font-Size="Small" Text='<%# Bind("Name") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="קורס" SortExpression="CourseName" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: right; direction: rtl">
                                <asp:Label ID="Label8" runat="server" Width="80px" Font-Size="Small" Text='<%# Bind("CourseName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="מחזור" SortExpression="CycleName" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: right; direction: rtl">
                                <asp:Label ID="Label9" runat="server" Width="30px" Font-Size="Small" Text='<%# Bind("CycleFullName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="מגמה" SortExpression="DepartmentName" ItemStyle-Wrap="false">
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: right; direction: rtl">
                                <asp:Label ID="Label7" runat="server" Width="80px" Font-Size="Small" Text='<%# Bind("DepartmentName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lbSelect" CommandName="SelectRow" Font-Size="Small" runat="server" ForeColor="#8C4510">בחר</asp:LinkButton>
                            <asp:LinkButton ID="lbEdit" CommandName="EditRow" Font-Size="Small" runat="server" ForeColor="#8C4510">ערוך</asp:LinkButton>
                            <asp:LinkButton ID="lbDelete" CommandName="DeleteRow" Font-Size="Small" runat="server" ForeColor="#8C4510" CommandArgument='<%#Eval("LectureID")%>'>מחק</asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="lbCancel" CommandName="CancelUpdate" Font-Size="Small" ForeColor="#8C4510" runat="server">בטל</asp:LinkButton>
                            <asp:LinkButton ID="lbUpdate" CommandName="UpdateRow" Font-Size="Small" CommandArgument='<%#Eval("LectureID") + ";" +Eval("CourseID") + ";" +Eval("DepartmentID") + ";" +Eval("CycleID") %>' ForeColor="#8C4510" ValidationGroup="LectureEdit" runat="server">עדכן</asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <SelectedRowStyle Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
            </asp:GridView>
        </div>

        <br />

        <div style="text-align: center; font-weight: bold; font-size: large">
            <asp:Label ID="lblEditLectureMessage" runat="server" Text=""></asp:Label>
        </div>
        <div style="text-align: center;">
            <asp:ValidationSummary ID="vsLectureEdit" ForeColor="Red" ValidationGroup="LectureEdit" runat="server" DisplayMode="List" />
        </div>
        <asp:SqlDataSource ID="sdsLectures" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" DeleteCommand="spDeleteLecture" DeleteCommandType="StoredProcedure" SelectCommand="spGetLectures" SelectCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="LectureID" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>

        <br />

        <div class="flex-container">
            <div style="flex: 0.15"></div>
            <div style="flex: 0.70">
                <div style="text-align: center">
                    <asp:Label ID="lblStudentsInLecture" Font-Size="Large" Font-Bold="true" runat="server" Text="סטודנטים בהרצאה"></asp:Label>
                </div>
                <asp:GridView ID="gvStudentsInLectures" runat="server" ForeColor="#707083" AllowPaging="True" AutoGenerateColumns="False" OnRowCommand="gvStudentsInLectures_RowCommand" DataSourceID="sdsStudentsInLectures" AllowSorting="True" CssClass="grid">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="סטטוס" SortExpression="StatusName">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlStatusesEdit" runat="server" DataSourceID="sdsStatuses" DataTextField="StatusName" DataValueField="StatusID" SelectedValue='<%# Bind("StatusID") %>'></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvStatusesEdit" ForeColor="Red" Text="*" runat="server" ErrorMessage="בחר סטטוס" ValidationGroup="StudentsInLecturesEdit" ControlToValidate="ddlStatusesEdit"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("StatusName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם סטודנט" SortExpression="Name">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מספר זהות" SortExpression="StudentID">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("StudentID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbEdit" CommandName="EditRow" runat="server" ForeColor="#8C4510">ערוך</asp:LinkButton>
                                <asp:LinkButton ID="lbDelete" CommandName="DeleteRow" runat="server" ForeColor="#8C4510" CommandArgument='<%#Eval("LectureID") + ";" +Eval("StudentID") %>'>מחק</asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="lbCancel" CommandName="CancelUpdate" ForeColor="#8C4510" runat="server">בטל</asp:LinkButton>
                                <asp:LinkButton ID="lbUpdate" CommandName="UpdateRow" CommandArgument='<%#Eval("LectureID") + ";" +Eval("StudentID") %>' ForeColor="#8C4510" runat="server" ValidationGroup="StudentsInLecturesEdit">עדכן</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>
            <div style="flex: 0.15"></div>
        </div>

        <br />

        <div style="text-align: center; font-weight: bold; font-size: large">
            <asp:Label ID="lblEditStudentLectureMessage" runat="server" Text=""></asp:Label>
        </div>
        <div style="text-align: center;">
            <asp:ValidationSummary ID="vsStudentIsLecturesEdit" ForeColor="Red" ValidationGroup="StudentsInLecturesEdit" runat="server" DisplayMode="List" />
        </div>
        <asp:SqlDataSource ID="sdsStudentsInLectures" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetStudentsByLecture" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="LectureID" Type="Int32" DefaultValue="-1" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetStatuses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsLecturersEdit" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetLecturersByCourse" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="CourseID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsClassesEdit" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetClasses" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

        <br />

        <div class="modal fade" id="DeleteConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" style="float: left;" class="close" data-dismiss="modal" aria-label="Close">
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
                        <button type="button" style="float: left;" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel2">!אזהרה</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        ?האם אתה בטוח
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelDelete2" runat="server" Text="לא" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmDelete2" runat="server" Text="כן" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmDelete2_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
