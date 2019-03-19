﻿<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Settings.aspx.cs" Inherits="Settings" %>

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
        function DisableButton() {
            document.getElementById("<%=btnUpdateAdministratorPassword.ClientID %>").disabled = true;
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
                <asp:ValidationSummary ID="vsAdministratorPasswordUpdate" ValidationGroup="AdministratorUpdatePassword" ForeColor="Red" runat="server" DisplayMode="List" />
            </div>
            <div style="width: 300px;">
                <div style="text-align: center; font-size: 10px;">
                    <h5>שינוי סיסמה</h5>
                </div>
                <div>
                    <asp:RequiredFieldValidator ID="rfvAdministratorCurrentPasswordUpdate" runat="server" Display="None" ErrorMessage="הזן סיסמה נוכחית" ControlToValidate="tbAdministratorCurrentPasswordUpdate" ValidationGroup="AdministratorUpdatePassword"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="tbAdministratorCurrentPasswordUpdate" TextMode="Password" runat="server"></asp:TextBox>
                    <div style="float: right">
                        <asp:Label ID="lblAdministratorCurrentPasswordUpdate" runat="server" Text="סיסמה נוכחית"></asp:Label>
                    </div>
                </div>
                <div>
                    <asp:RequiredFieldValidator ID="rfvAdministratorNewPasswordUpdate" runat="server" Display="None" ErrorMessage="הזן סיסמה חדשה" ControlToValidate="tbAdministratorNewPasswordUpdate" ValidationGroup="AdministratorUpdatePassword"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="tbAdministratorNewPasswordUpdate" TextMode="Password" runat="server"></asp:TextBox>
                    <div style="float: right">
                        <asp:Label ID="lblAdministratorNewPasswordUpdate" runat="server" Text="סיסמה חדשה"></asp:Label>
                    </div>
                </div>
                <div>
                    <asp:RequiredFieldValidator ID="rfvAdministratorAgainPasswordUpdate" runat="server" Display="None" ErrorMessage="הזן אימות סיסמה" ControlToValidate="tbAdministratorAgainPasswordUpdate" ValidationGroup="AdministratorUpdatePassword"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvAdministratorAgainPasswordUpdate" runat="server" ErrorMessage="הסיסמאות לא תואמות" Display="None" ControlToCompare="tbAdministratorNewPasswordUpdate" ControlToValidate="tbAdministratorAgainPasswordUpdate" ValidationGroup="AdministratorUpdatePassword"></asp:CompareValidator>
                    <asp:TextBox ID="tbAdministratorAgainPasswordUpdate" TextMode="Password" runat="server"></asp:TextBox>
                    <div style="float: right">
                        <asp:Label ID="lblAdministratorAgainPasswordUpdate" runat="server" Text="אימות סיסמה"></asp:Label>
                    </div>
                </div>
                <div style="text-align: center; padding-top: 5px;">
                    <asp:Button ID="btnUpdateAdministratorPassword" CssClass="btn btn-secondary btn-sm" runat="server" Text="עדכן" OnClick="btnUpdateAdministratorPassword_Click" ValidationGroup="AdministratorUpdatePassword" />
                </div>
                <div style="text-align: center; font-weight: bold; font-size: large;">
                    <asp:Label ID="lblUpdateAdministratorPasswordMessage" runat="server" Text=""></asp:Label>
                    <br />
                </div>
            </div>
        </div>

    </form>
</body>
</html>
