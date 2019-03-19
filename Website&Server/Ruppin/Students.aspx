<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Students.aspx.cs" Inherits="Students" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function openModal() {
            $('#DeleteConfirm').modal('show');
        }
        function openModal2() {
            $('#UpdateConfirm').modal('show');
        }
        function openModal3() {
            $('#UpdateConfirm2').modal('show');
        }
        function openModal4() {
            $('#ResetConfirm').modal('show');
        }
        function DisableButton() {
            document.getElementById("<%=btnAddStudent.ClientID %>").disabled = true;
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
                <div style="width: 300px; text-align: right; padding-right: 15px; margin-top: -40px;">
                    <asp:ValidationSummary ID="vsStudentAdd" ForeColor="Red" ValidationGroup="StudentAdd" runat="server" DisplayMode="List" />
                </div>
                <div style="width: 270px;">
                    <div style="text-align: center; font-size: 10px;">
                        <h5>יצירת סטודנט</h5>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvStudentIDAdd" runat="server" ErrorMessage="הזן מספר זהות" ControlToValidate="tbStudentIDAdd" Display="None" ValidationGroup="StudentAdd"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revStudentIDAdd" runat="server" ErrorMessage="שדה מספר זהות צריך להכיל 9 ספרות" ControlToValidate="tbStudentIDAdd" ValidationExpression="[0-9]{9}" Display="None" ValidationGroup="StudentAdd"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="tbStudentIDAdd" dir="rtl" TextMode="Number" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblStudentIDAdd" runat="server" Text="מספר זהות"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvStudentFirstNameAdd" runat="server" ErrorMessage="הזן שם פרטי" Display="None" ControlToValidate="tbStudentFirstNameAdd" ValidationGroup="StudentAdd"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbStudentFirstNameAdd" dir="rtl" MaxLength="35" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblStudentFirstNameAdd" runat="server" Text="שם פרטי"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvStudentLastNameAdd" runat="server" ErrorMessage="הזן שם משפחה" Display="None" ControlToValidate="tbStudentLastNameAdd" ValidationGroup="StudentAdd"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbStudentLastNameAdd" dir="rtl" MaxLength="35" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblStudentLastNameAdd" runat="server" Text="שם משפחה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvStudentEmailAdd" runat="server" ErrorMessage="הזן אימייל" Display="None" ControlToValidate="tbStudentEmailAdd" ValidationGroup="StudentAdd"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revStudentEmailAdd" runat="server" ErrorMessage="אימייל שגוי" Display="None" ControlToValidate="tbStudentEmailAdd" ValidationGroup="StudentAdd" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="tbStudentEmailAdd" runat="server" MaxLength="100"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblStudentEmailAdd" runat="server" Text="אימייל"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvDepartmentsAdd" runat="server" ErrorMessage="בחר מגמה" Display="None" ControlToValidate="ddlDepartmentsAdd" InitialValue="-1" ValidationGroup="StudentAdd"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlDepartmentsAdd" Width="178px" dir="rtl" runat="server" AutoPostBack="true" DataSourceID="sdsDepartmentsAdd" DataTextField="DepartmentName" DataValueField="DepartmentID" OnDataBound="ddlDepartmentsAdd_DataBound" OnSelectedIndexChanged="ddlDepartmentsAdd_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsDepartmentsAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetDepartments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblDepartmentsAdd" runat="server" Text="מגמה"></asp:Label>
                        </div>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvCycles" runat="server" ErrorMessage="בחר מחזור" Display="None" ControlToValidate="ddlCyclesAdd" InitialValue="-1" ValidationGroup="StudentAdd"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlCyclesAdd" runat="server" Width="178px" dir="rtl" DataSourceID="sdsCyclesAdd" DataTextField="Name" DataValueField="CycleID" OnDataBound="ddlCyclesAdd_DataBound" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCyclesAdd" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetCyclesByDepartment" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="" Name="DepartmentID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <div style="float: right">
                            <asp:Label ID="lblCyclesAdd" runat="server" Text="מחזור"></asp:Label>
                        </div>
                    </div>

                    <div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="בחר תמונה" Display="None" ControlToValidate="fulPictureAdd" ValidationGroup="StudentAdd"></asp:RequiredFieldValidator>
                        <asp:FileUpload ID="fulPictureAdd" runat="server" accept=".png,.jpg,.jpeg,.gif" />
                        <div style="float: right">
                            <asp:Label ID="Label9" runat="server" Text="תמונה"></asp:Label>
                        </div>
                    </div>

                    <div style="text-align: center; padding-top: 5px;">
                        <asp:Button ID="btnAddStudent" runat="server" Text="הוסף" CssClass="btn btn-secondary btn-sm" OnClick="btnAddStudent_Click" ValidationGroup="StudentAdd" />
                    </div>
                    <div style="text-align: center; font-weight: bold; font-size: large;">
                        <asp:Label ID="lblAddStudentMessage" runat="server" Text=""></asp:Label>
                        <br />
                    </div>
                </div>
            </div>

            <hr />

            <div style="display: flex; justify-content: center; flex-wrap: wrap-reverse;">
                <div style="padding-right: 10px; padding-top: 15px;">
                    <asp:Button ID="btnSearchStudents" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server" Text="חפש" OnClick="btnSearchStudents_Click" />
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label8" runat="server" Text="מחזור"></asp:Label>
                    </div>
                    <asp:DropDownList ID="ddlCyclesSearch" runat="server" Width="178px" dir="rtl" Height="28px" DataSourceID="sdsCyclesSearch" DataTextField="CycleName" DataValueField="CycleID" OnDataBound="ddlCyclesSearch_DataBound"></asp:DropDownList>
                    <asp:SqlDataSource ID="sdsCyclesSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetCycles" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label3" runat="server" Text="מגמה"></asp:Label>
                    </div>
                    <asp:DropDownList ID="ddlDepartmentsSearch" runat="server" Width="178px" dir="rtl" Height="28px" DataSourceID="sdsDepartmentsSearch" DataTextField="DepartmentName" DataValueField="DepartmentID" OnDataBound="ddlDepartmentsSearch_DataBound"></asp:DropDownList>
                    <asp:SqlDataSource ID="sdsDepartmentsSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetDepartments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label7" runat="server" Text="שם משפחה"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbStudentLastNameSearch" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label6" runat="server" Text="שם פרטי"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbStudentFirstNameSearch" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label5" runat="server" Text="מספר זהות"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbStudentIDSearch" dir="rtl" TextMode="Number" runat="server"></asp:TextBox>
                </div>
            </div>

            <br />

            <div style="flex: 1;">
                <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" ForeColor="#707083" DataKeyNames="StudentID,DepartmentID" DataSourceID="sdsStudents" OnRowDeleting="gvStudents_RowDeleting" OnRowCommand="gvStudents_RowCommand" OnRowDataBound="gvStudents_RowDataBound" OnSelectedIndexChanged="gvStudents_SelectedIndexChanged" AllowSorting="True" CssClass="grid" AllowPaging="True" OnPageIndexChanged="gvStudents_PageIndexChanged">
                    <AlternatingRowStyle BackColor="Gainsboro" CssClass="alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="פעיל" SortExpression="IsActive">
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsActive" runat="server" Checked='<%# Bind("IsActive") %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="תמונה" SortExpression="Picture">
                            <ItemTemplate>
                                <asp:Image ID="imgPicture" runat="server" ImageUrl='<%# ConfigurationManager.AppSettings["StudentsImagesPath"] + Eval("Picture") %>' Width="40px" Height="40px" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="מחזור" SortExpression="CycleName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <div style="display: flex; justify-content: center; align-items: center;">
                                    <asp:DropDownList ID="ddlCyclesEdit2" runat="server" Height="20px" dir="rtl" Width="120px" AppendDataBoundItems="True" DataTextField="Name" DataSourceID="sdsCyclesEdit2" DataValueField="CycleID" OnDataBinding="ddlCyclesEdit2_DataBinding">
                                    </asp:DropDownList>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvCycles2" runat="server" Display="None" ErrorMessage="בחר מחזור" ControlToValidate="ddlCyclesEdit2" InitialValue="-1" ValidationGroup="StudentEdit"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="sdsCyclesEdit2" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCyclesByDepartment" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlDepartmentsEdit" Name="DepartmentID" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="lbCycleName2" runat="server" Width="80px" Text='<%# Bind("Name") %>'></asp:Label>
                                </div>
                            </ItemTemplate>

                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מגמה" SortExpression="DepartmentName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <div style="display: flex; justify-content: center; align-items: center;">
                                    <asp:DropDownList ID="ddlDepartmentsEdit" runat="server" dir="rtl" Height="20px" Width="120px" AppendDataBoundItems="true" DataSourceID="sdsDepartmentsEdit" DataTextField="DepartmentName" DataValueField="DepartmentID" SelectedValue='<%# Bind("DepartmentID") %>' AutoPostBack="true">
                                        <asp:ListItem Text="בחר מגמה" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:SqlDataSource ID="sdsDepartmentsEdit" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" SelectCommand="spGetDepartments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvDepartmentsEdit" runat="server" Display="None" ErrorMessage="בחר מגמה" ControlToValidate="ddlDepartmentsEdit" InitialValue="" ValidationGroup="StudentEdit"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label1" runat="server" Width="150px" Text='<%# Bind("DepartmentName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>

                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מחזור" SortExpression="CycleName" Visible="false">
                            <EditItemTemplate>
                                <asp:Label runat="server" Text='<%# Bind("CycleID") %>' ID="lblCycleID" Visible="false" />
                                <asp:DropDownList ID="ddlCyclesEdit" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCyclesEdit" DataTextField="Name" DataValueField="CycleID" OnDataBinding="ddlCyclesEdit_DataBinding">
                                    <asp:ListItem Text="בחר מחזור" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsCyclesEdit" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCyclesByDepartment" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlDepartmentsEdit" Name="DepartmentID" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCycleName2" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="אימייל" SortExpression="Email" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbStudentEmailEdit" MaxLength="100" Style="text-align: center" Width="120px" Height="20px" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvStudentEmailEdit" Display="None" ValidationGroup="StudentEdit" ControlToValidate="tbStudentEmailEdit" runat="server" ErrorMessage="הזן אימייל"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revStudentEmailEdit" Display="None" ValidationGroup="StudentEdit" ControlToValidate="tbStudentEmailEdit" runat="server" ErrorMessage="אימייל שגוי" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: left;">
                                    <asp:Label ID="Label6" runat="server" Width="150px" Text='<%# Bind("Email") %>'></asp:Label>
                                </div>
                            </ItemTemplate>

                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם משפחה" SortExpression="LastName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbStudentLastNameEdit" Style="text-align: center" Height="20px" Width="120px" MaxLength="35" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvStudentLastNameEdit" Display="None" ValidationGroup="StudentEdit" ControlToValidate="tbStudentLastNameEdit" runat="server" ErrorMessage="הזן שם משפחה"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label5" runat="server" Width="150px" Text='<%# Bind("LastName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>

                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם פרטי" SortExpression="FirstName" ItemStyle-Wrap="false">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbStudentFirstNameEdit" Style="text-align: center" Height="20px" Width="120px" MaxLength="35" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvStudentFirstNameEdit" Display="None" ValidationGroup="StudentEdit" ControlToValidate="tbStudentFirstNameEdit" runat="server" ErrorMessage="הזן שם פרטי"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div style="overflow: auto; text-align: right; direction: rtl">
                                    <asp:Label ID="Label4" runat="server" Width="150px" Text='<%# Bind("FirstName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>

                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מספר זהות" SortExpression="StudentID">
                            <ItemTemplate>
                                <asp:Label ID="lbStudentID" runat="server" Text='<%# Bind("StudentID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbSelect" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Select" Text="בחר"></asp:LinkButton>
                                <asp:LinkButton ID="lbEdit" CommandName="EditRow" runat="server" ForeColor="#8C4510">ערוך</asp:LinkButton>
                                <asp:LinkButton ID="lbDelete" CommandName="Delete" runat="server" ForeColor="#8C4510" CommandArgument='<%#Eval("Picture") %>'>מחק</asp:LinkButton>
                                <asp:LinkButton ID="lbReset" CommandName="Reset" ForeColor="#8C4510" runat="server" CausesValidation="False" CommandArgument='<%#Eval("StudentID") + ";" + Eval("Email") %>'>אפס</asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="lbCancel" CommandName="CancelUpdate" ForeColor="#8C4510" runat="server" CausesValidation="False">בטל</asp:LinkButton>
                                <asp:LinkButton ID="lbUpdate" CommandName="UpdateRow" ForeColor="#8C4510" runat="server" ValidationGroup="StudentEdit">עדכן</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>

            <br />

            <div style="text-align: center; font-weight: bold; font-size: large">
                <asp:Label ID="lblEditStudentMessage" runat="server" Text=""></asp:Label>
            </div>
            <div style="text-align: center;">
                <asp:ValidationSummary ID="vsStudentEdit" ForeColor="Red" ValidationGroup="StudentEdit" runat="server" DisplayMode="List" />
            </div>
            <asp:SqlDataSource ID="sdsStudents" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" DeleteCommand="spDeleteStudent" DeleteCommandType="StoredProcedure" InsertCommand="spAddStudent" InsertCommandType="StoredProcedure" ProviderName="System.Data.SqlClient" UpdateCommand="spCheckUpdateStudent" UpdateCommandType="StoredProcedure" OnUpdated="sdsStudents_Updated" OnInserted="sdsStudents_Inserted" OnDeleted="sdsStudents_Deleted" SelectCommand="spGetStudents" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="StudentID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="StudentID" Type="Int32" />
                    <asp:Parameter Name="Password" Type="String" />
                    <asp:Parameter Name="DepartmentID" Type="Int32" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="CycleID" Type="Int32" />
                    <asp:Parameter Name="Picture" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="StudentID" Type="Int32" />
                    <asp:Parameter Name="Email" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <br />

            <div class="flex-container">
                <div style="flex: 0.25"></div>
                <div style="flex: 0.50">
                    <asp:GridView ID="gvCoursesOfStudent" runat="server" AutoGenerateColumns="False" ForeColor="#707083" DataSourceID="sdsCoursesOfStudent" OnRowUpdating="gvCoursesOfStudent_RowUpdating" DataKeyNames="CourseID,CycleID" AllowSorting="True" CssClass="grid" AllowPaging="True">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:BoundField DataField="CourseID" HeaderText="CourseID" InsertVisible="False" ReadOnly="True" SortExpression="CourseID" Visible="False" />
                            <asp:TemplateField HeaderText="פעיל" SortExpression="IsActive">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkIsActive" runat="server" Checked='<%# Bind("IsActive") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="מחזור" SortExpression="CycleName">
                                <EditItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("CycleID") %>' ID="lbCycleID" Visible="false" />
                                    <asp:DropDownList ID="ddlCyclesEdit" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCyclesEdit" DataTextField="Name" DataValueField="CycleID" SelectedValue='<%# Bind("CycleID") %>'>
                                        <asp:ListItem Text="בחר מחזור" Value="-1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCyclesEdit" runat="server" ErrorMessage="בחר מחזור" Text="*" ValidationGroup="CoursesOfStudentEdit" ControlToValidate="ddlCyclesEdit" InitialValue="-1" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="sdsCyclesEdit" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCyclesByDepartment" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hfDepartmentID" DefaultValue="-1" Name="DepartmentID" PropertyName="Value" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="קורס" SortExpression="CourseName">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CourseName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="בטל"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="עדכן" ValidationGroup="CoursesOfStudentEdit"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="ערוך"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <SelectedRowStyle Font-Bold="True" />
                        <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                    </asp:GridView>
                </div>
                <div style="flex: 0.25"></div>
            </div>

            <br />

            <div style="text-align: center; font-weight: bold; font-size: large">
                <asp:Label ID="lblEditCourseOfStudentMessage" runat="server" Text=""></asp:Label>
            </div>
            <div style="text-align: center;">
                <asp:ValidationSummary ID="vsCoursesOfStudentEdit" ForeColor="Red" ValidationGroup="CoursesOfStudentEdit" runat="server" DisplayMode="List" />
            </div>
            <asp:SqlDataSource ID="sdsCoursesOfStudent" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" SelectCommand="spGetCoursesByStudent" SelectCommandType="StoredProcedure" UpdateCommand="spUpdateCourseOfStudentTry" UpdateCommandType="StoredProcedure" OnUpdated="sdsCoursesOfStudent_Updated">
                <SelectParameters>
                    <asp:Parameter DefaultValue="-1" Name="StudentID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="StudentID" Type="Int32" />
                    <asp:Parameter Name="IsActive" Type="Boolean" />
                    <asp:Parameter Name="CourseID" Type="Int32" />
                    <asp:Parameter Name="CycleID" Type="Int32" />
                    <asp:Parameter Name="OldCycleID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:HiddenField ID="hfDepartmentID" runat="server" />
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

        <div class="modal fade" id="UpdateConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                        <asp:Button ID="btnCancelUpdate" runat="server" Text="אני מסרב" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmUpdate" runat="server" Text="אני מסכים" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmUpdate_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="UpdateConfirm2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" style="float: left;" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel3">!שים לב</h5>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        <asp:Label ID="lblConfirmMessage3" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer justify-content-lg-start">
                        <asp:Button ID="btnCancelReplace" runat="server" Text="אני מסרב" CssClass="btn btn-secondary" data-dismiss="modal" />
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
