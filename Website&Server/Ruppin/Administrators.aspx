<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Administrators.aspx.cs" Inherits="Administrators" %>

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
            $('#ResetConfirm').modal('show');
        }
        function DisableButton() {
            document.getElementById("<%=btnAddAdministrator.ClientID %>").disabled = true;
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

        <div class="container">
            <div style="width: 300px; text-align: right; padding-right: 15px; margin-top: -40px;">
                <asp:ValidationSummary ID="vsAdministratorAdd" ValidationGroup="AdministratorAdd" ForeColor="Red" runat="server" DisplayMode="List" />
            </div>
            <div style="width: 270px;">
                <div style="text-align: center; font-size: 10px;">
                    <h5>יצירת מנהל</h5>
                </div>
                <div>
                    <asp:RequiredFieldValidator ID="rfvAdministratorIDAdd" runat="server" Display="none" ErrorMessage="הזן מספר זהות" ControlToValidate="tbAdministratorIDAdd" ValidationGroup="AdministratorAdd"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revAdministratorIDAdd" runat="server" Display="None" ErrorMessage="שדה מספר זהות צריך להכיל 9 ספרות" ControlToValidate="tbAdministratorIDAdd" ValidationExpression="[0-9]{9}" ValidationGroup="AdministratorAdd"></asp:RegularExpressionValidator>
                    <asp:TextBox ID="tbAdministratorIDAdd" dir="rtl" TextMode="Number" runat="server"></asp:TextBox>
                    <div style="float: right">
                        <asp:Label ID="lblAdministratorIDAdd" runat="server" Text="מספר זהות"></asp:Label>
                    </div>
                </div>
                <div>
                    <asp:RequiredFieldValidator ID="rfvAdministratorFirstNameAdd" runat="server" Display="None" ErrorMessage="הזן שם פרטי" ControlToValidate="tbAdministratorFirstNameAdd" ValidationGroup="AdministratorAdd"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="tbAdministratorFirstNameAdd" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
                    <div style="float: right">
                        <asp:Label ID="lblAdministratorFirstNameAdd" runat="server" Text="שם פרטי"></asp:Label>
                    </div>
                </div>
                <div>
                    <asp:RequiredFieldValidator ID="rfvdministratorLastNameAdd" runat="server" Display="None" ErrorMessage="הזן שם משפחה" ControlToValidate="tbAdministratorLastNameAdd" ValidationGroup="AdministratorAdd"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="tbAdministratorLastNameAdd" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
                    <div style="float: right">
                        <asp:Label ID="lblAdministratorLastNameAdd" runat="server" Text="שם משפחה"></asp:Label>
                    </div>
                </div>
                <div>
                    <asp:RequiredFieldValidator ID="rfvAdministratorEmailAdd" runat="server" Display="None" ErrorMessage="הזן אימייל" ControlToValidate="tbAdministratorEmailAdd" ValidationGroup="AdministratorAdd"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revAdministratorEmailAdd" runat="server" Display="None" ErrorMessage="אימייל שגוי" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ControlToValidate="tbAdministratorEmailAdd" ValidationGroup="AdministratorAdd"></asp:RegularExpressionValidator>
                    <asp:TextBox ID="tbAdministratorEmailAdd" runat="server" MaxLength="100"></asp:TextBox>
                    <div style="float: right">
                        <asp:Label ID="lblAdministratorEmailAdd" runat="server" Text="אימייל"></asp:Label>
                    </div>
                </div>
                <div style="text-align: center; padding-top: 5px;">
                    <asp:Button ID="btnAddAdministrator" CssClass="btn btn-secondary btn-sm" runat="server" Text="הוסף" OnClick="btnAddAdministrator_Click" ValidationGroup="AdministratorAdd" />
                </div>
                <div style="text-align: center; font-weight: bold; font-size: large;">
                    <asp:Label ID="lblAddAdministratorMessage" runat="server" Text=""></asp:Label>
                    <br />
                </div>
            </div>
        </div>

        <hr />

        <div style="display: flex; justify-content: center; flex-wrap: wrap-reverse;">
            <div style="padding-right: 10px; padding-top: 15px;">
                <asp:Button ID="btnSearchAdministrators" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server" Text="חפש" OnClick="btnSearchAdministrators_Click" />
            </div>
            <div>
                <div style="text-align: center;">
                    <asp:Label ID="Label7" runat="server" Text="שם משפחה"></asp:Label>
                </div>
                <asp:TextBox ID="tbAdministratorLastNameSearch" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
            </div>
            <div>
                <div style="text-align: center;">
                    <asp:Label ID="Label6" runat="server" Text="שם פרטי"></asp:Label>
                </div>
                <asp:TextBox ID="tbAdministratorFirstNameSearch" MaxLength="35" dir="rtl" runat="server"></asp:TextBox>
            </div>
            <div>
                <div style="text-align: center;">
                    <asp:Label ID="Label5" runat="server" Text="מספר זהות"></asp:Label>
                </div>
                <asp:TextBox ID="tbAdministratorIDSearch" dir="rtl" TextMode="Number" runat="server"></asp:TextBox>
            </div>
        </div>

        <br />

        <div style="flex: 1;">
            <asp:GridView ID="gvAdministrators" runat="server" AutoGenerateColumns="False" DataKeyNames="AdministratorID" DataSourceID="sdsAdministrators" ForeColor="#707083" OnRowDeleting="gvAdministrators_RowDeleting" AllowSorting="True" CssClass="grid" AllowPaging="True" OnRowCommand="gvAdministrators_RowCommand">
                <AlternatingRowStyle BackColor="PaleGoldenrod" CssClass="alt" />
                <Columns>
                    <asp:TemplateField HeaderText="פעיל" SortExpression="IsActive">
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkIsActiveEdit" runat="server" Checked='<%# Bind("IsActive") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkIsActiveItem" runat="server" Checked='<%# Bind("IsActive") %>' Enabled="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="אימייל" SortExpression="Email" ItemStyle-Wrap="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbAdministratorEmailEdit" Height="20px" runat="server" Width="80%" MaxLength="100" Style="text-align: center" Text='<%# Bind("Email") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAdministratorEmailEdit" runat="server" Display="None" ErrorMessage="הזן אימייל" ControlToValidate="tbAdministratorEmailEdit" ValidationGroup="AdministratorEdit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revAdministratorEmailEdit" runat="server" Display="None" ErrorMessage="אימייל שגוי" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ValidationGroup="AdministratorEdit" ControlToValidate="tbAdministratorEmailEdit"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: left;">
                                <asp:Label ID="Label4" runat="server" Width="150px" Text='<%# Bind("Email") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="שם משפחה" SortExpression="LastName" ItemStyle-Wrap="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbAdministratorLastNameEdit" Height="20px" runat="server" Width="80%" MaxLength="35" Style="text-align: center" Text='<%# Bind("LastName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAdministratorLastNameEdit" runat="server" Display="None" ErrorMessage="הזן שם משפחה" ControlToValidate="tbAdministratorLastNameEdit" ValidationGroup="AdministratorEdit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: right; direction: rtl">
                                <asp:Label ID="Label3" runat="server" Width="150px" Text='<%# Bind("LastName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="שם פרטי" SortExpression="FirstName" ItemStyle-Wrap="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbAdministratorFirstNameEdit" Height="20px" Width="80%" runat="server" MaxLength="35" Style="text-align: center" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAdministratorFirstNameEdit" runat="server" Display="None" ErrorMessage="הזן שם פרטי" ControlToValidate="tbAdministratorFirstNameEdit" ValidationGroup="AdministratorEdit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <div style="overflow: auto; text-align: right; direction: rtl">
                                <asp:Label ID="Label2" runat="server" Width="150px" Text='<%# Bind("FirstName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סיסמה" SortExpression="Password" Visible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Password") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="AdministratorID" HeaderText="מספר זהות" ReadOnly="True" SortExpression="AdministratorID" />
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Cancel" Text="בטל"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" ForeColor="#8C4510" CommandName="Update" Text="עדכן" ValidationGroup="AdministratorEdit"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Edit" Text="ערוך"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Delete" Text="מחק"></asp:LinkButton>
                            <asp:LinkButton ID="lbReset" CommandName="Reset" ForeColor="#8C4510" runat="server" CausesValidation="False" CommandArgument='<%#Eval("AdministratorID") + ";" + Eval("Email") %>'>אפס</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <SelectedRowStyle Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
            </asp:GridView>
        </div>

        <br />

        <div style="text-align: center; font-weight: bold; font-size: large">
            <asp:Label ID="lblEditAdministratorMessage" runat="server" Text=""></asp:Label>
        </div>
        <div style="text-align: center;">
            <asp:ValidationSummary ID="vsAdministratorEdit" ForeColor="red" runat="server" ValidationGroup="AdministratorEdit" DisplayMode="List" />
        </div>
        <asp:SqlDataSource ID="sdsAdministrators" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" DeleteCommand="spDeleteAdministrator" DeleteCommandType="StoredProcedure" InsertCommand="spAddAdministrator" InsertCommandType="StoredProcedure" ProviderName="System.Data.SqlClient" UpdateCommand="spUpdateAdministrator" UpdateCommandType="StoredProcedure" OnInserted="sdsAdministrators_Inserted" OnUpdated="sdsAdministrators_Updated" OnDeleted="sdsAdministrators_Deleted" SelectCommand="spGetAdministrators" SelectCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="AdministratorID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="AdministratorID" Type="Int32" />
                <asp:Parameter Name="Password" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="AdministratorID" Type="Int32" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="IsActive" Type="Boolean" />
            </UpdateParameters>
        </asp:SqlDataSource>

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

        <div class="modal fade" id="ResetConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" style="float: left;" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h5 class="modal-title" style="float: right;" id="exampleModalLabel3">!אזהרה</h5>
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
