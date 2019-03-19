<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Classes.aspx.cs" Inherits="Classes" %>

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
            $('#DeleteConfirm2').modal('show');
        }
        function DisableButton() {
            document.getElementById("<%=btnAddClass.ClientID %>").disabled = true;
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
                <div style="width: 150px; text-align: right; padding-right: 15px; margin-top: -40px;">
                    <asp:ValidationSummary ID="vsClassAdd" ForeColor="Red" ValidationGroup="ClassAdd" runat="server" DisplayMode="List" />
                </div>
                <div style="width: 250px;">
                    <div style="text-align: center; font-size: 10px;">
                        <h5>יצירת כיתה</h5>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvClassNameAdd" Display="None" runat="server" ErrorMessage="הזן שם כיתה" ControlToValidate="tbClassNameAdd" ValidationGroup="ClassAdd"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="tbClassNameAdd" dir="rtl" MaxLength="30" runat="server"></asp:TextBox>
                        <div style="float: right">
                            <asp:Label ID="lblClassNameAdd" runat="server" Text="שם כיתה"></asp:Label>
                        </div>
                    </div>
                    <div style="text-align: center; padding-top: 5px;">
                        <asp:Button ID="btnAddClass" runat="server" Text="הוסף" CssClass="btn btn-secondary btn-sm" OnClick="btnAddClass_Click" ValidationGroup="ClassAdd" />
                    </div>
                    <div style="text-align: center; font-weight: bold; font-size: large;">
                        <asp:Label ID="lblAddClassMessage" runat="server" Text=""></asp:Label>
                        <br />
                    </div>
                </div>
            </div>

            <hr />

            <div style="display: flex; justify-content: center; flex-wrap: wrap-reverse;">
                <div style="padding-right: 10px; padding-top: 15px;">
                    <asp:Button ID="btnSearchClasses" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server" Text="חפש" OnClick="btnSearchClasses_Click" />
                </div>
                <div>
                    <div style="text-align: center;">
                        <asp:Label ID="Label7" runat="server" Text="שם כיתה"></asp:Label>
                    </div>
                    <asp:TextBox ID="tbClassNameSearch" MaxLength="30" dir="rtl" runat="server"></asp:TextBox>
                </div>
            </div>

            <br />

            <div style="flex: 1;">
                <asp:GridView ID="gvClasses" runat="server" ForeColor="#707083" AutoGenerateColumns="False" DataKeyNames="ClassID" DataSourceID="sdsClasses" OnRowDeleted="gvClasses_RowDeleted" AllowSorting="True" CssClass="grid" AllowPaging="True" OnRowUpdated="gvClasses_RowUpdated">
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
                        <asp:TemplateField HeaderText="שם כיתה" SortExpression="ClassName">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbClassNameEdit" runat="server" dir="rtl" Height="20px" Width="80%" MaxLength="30" Style="text-align: center" Text='<%# Bind("ClassName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvClassNameEdit" Display="None" ControlToValidate="tbClassNameEdit" runat="server" ErrorMessage="הזן שם כיתה" ValidationGroup="ClassEdit"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" dir="rtl" Text='<%# Bind("ClassName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Cancel" Text="בטל"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" ForeColor="#8C4510" CommandName="Update" Text="עדכן" ValidationGroup="ClassEdit"></asp:LinkButton>

                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Edit" Text="ערוך"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Delete" Text="מחק"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
                </asp:GridView>
            </div>

            <br />

            <div style="text-align: center; font-weight: bold; font-size: large">
                <asp:Label ID="lblEditClassMessage" runat="server" Text=""></asp:Label>
            </div>
            <div style="text-align: center;">
                <asp:ValidationSummary ID="vsClassEdit" ForeColor="Red" ValidationGroup="ClassEdit" runat="server" DisplayMode="List" />
            </div>
            <asp:SqlDataSource ID="sdsClasses" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" DeleteCommand="spCheckDeleteClass" DeleteCommandType="StoredProcedure" InsertCommand="spAddClass" InsertCommandType="StoredProcedure" ProviderName="System.Data.SqlClient" UpdateCommand="spUpdateClass" UpdateCommandType="StoredProcedure" OnInserted="sdsClasses_Inserted" SelectCommand="spGetClasses" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="ClassID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ClassName" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ClassName" Type="String" />
                    <asp:Parameter Name="ClassID" Type="Int32" />
                    <asp:Parameter Name="IsActive" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>
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
    </form>
</body>
</html>
