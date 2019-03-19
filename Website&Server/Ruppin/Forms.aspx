<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Forms.aspx.cs" Inherits="Forms" %>

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
            $('#AcceptConfirm').modal('show');
        }
        function openModal3() {
            $('#DeclineConfirm').modal('show');
        }
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

        <div style="text-align: center; font-size: 10px;">
            <h5>אישורים</h5>
        </div>

        <hr />

        <div style="display: flex; justify-content: center; flex-wrap: wrap-reverse;">
            <div style="padding-right: 10px; padding-top: 15px;">
                <asp:Button ID="btnSearchForms" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server" Text="חפש" OnClick="btnSearchForms_Click" />
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
            <asp:GridView ID="gvForms" runat="server" AutoGenerateColumns="False" DataKeyNames="FormID" DataSourceID="sdsForms" ForeColor="#707083" AllowSorting="True" CssClass="grid" AllowPaging="True" OnRowDataBound="gvForms_RowDataBound" OnRowDeleting="gvForms_RowDeleting" OnRowCommand="gvForms_RowCommand">
                <AlternatingRowStyle BackColor="PaleGoldenrod" CssClass="alt" />
                <Columns>
                    <asp:TemplateField HeaderText="סטטוס" SortExpression="FormStatusName">
                        <ItemTemplate>
                            <asp:Label ID="lbFormStatusName" runat="server" Text='<%# Bind("FormStatusName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="תמונה" SortExpression="Picture">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnPicture" runat="server" CommandName="Download" CommandArgument='<%# Eval("Picture") + ";" +Eval("StudentID") %>'>הורדה</asp:LinkButton>
                            <%-- <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Picture") %>' />--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סיום" SortExpression="EndDate">
                        <ItemTemplate>
                            <asp:Label ID="lbEndDate" runat="server" Text='<%# Bind("EndDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="פתיחה" SortExpression="OpenDate">
                        <ItemTemplate>
                            <asp:Label ID="lbOpenDate" runat="server" Text='<%# Bind("OpenDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="מספר זהות" SortExpression="StudentID">
                        <ItemTemplate>
                            <asp:Label ID="lbStudentID" runat="server" Text='<%# Bind("StudentID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnDelete" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Delete" Text="מחק"></asp:LinkButton>
                            <asp:LinkButton ID="lnkbtnAccept" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Accept" Text="אשר"></asp:LinkButton>
                            <asp:LinkButton ID="lnkbtnDecline" runat="server" CausesValidation="False" ForeColor="#8C4510" CommandName="Decline" Text="סרב"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <SelectedRowStyle Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" HorizontalAlign="Center" Font-Bold="True" />
            </asp:GridView>
        </div>

        <br />

        <div style="text-align: center; font-weight: bold; font-size: large">
            <asp:Label ID="lblDeleteFormMessage" runat="server" Text=""></asp:Label>
        </div>

        <asp:SqlDataSource ID="sdsForms" runat="server" ConnectionString="<%$ ConnectionStrings:Live %>" ProviderName="System.Data.SqlClient" UpdateCommand="spUpdateForm" UpdateCommandType="StoredProcedure" SelectCommand="spGetForms" SelectCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:Parameter Name="FormID" Type="Int32" />
                <asp:Parameter Name="FormStatusID" Type="String" />
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

        <div class="modal fade" id="AcceptConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                        <asp:Button ID="btnCancelAccept" runat="server" Text="לא" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmAccept" runat="server" Text="כן" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmAccept_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="DeclineConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                        <asp:Button ID="btnCancelDecline" runat="server" Text="לא" CssClass="btn btn-secondary" data-dismiss="modal" />
                        <asp:Button ID="btnConfirmDecline" runat="server" Text="כן" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" OnClick="btnConfirmDecline_Click" />
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
