<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <title></title>
    <script>
        function DisableButton() {
            document.getElementById("<%=btnAdministratorLogin.ClientID %>").disabled = true;
        }
        window.onbeforeunload = DisableButton;
    </script>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%">

        <div class="container">

            <div style="text-align: right; width: 350px; height: 50%;">

                <div style="text-align: center;">
                    <h5>כניסת מנהל</h5>
                    <p>הזן מספר זהות וסיסמה</p>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="tbAdministratorID" runat="server" TextMode="Number" dir="rtl" placeholder="מספר זהות" CssClass="form-control" aria-describedby="emailHelp"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAdministratorID" runat="server" ErrorMessage="הזן מספר זהות" Text="*" Display="None" ControlToValidate="tbAdministratorID" ForeColor="Red" ValidationGroup="Login"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revAdministratorID" runat="server" ErrorMessage="שדה מספר זהות צריך להכיל 9 ספרות" Display="None" Text="*" ControlToValidate="tbAdministratorID" ValidationExpression="[0-9]{9}" ForeColor="Red" ValidationGroup="Login"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="tbAdministratorPassword" TextMode="Password" runat="server" dir="rtl" placeholder="סיסמה" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAdministratorPassword" runat="server" ErrorMessage="הזן סיסמא" Text="*" Display="None" ControlToValidate="tbAdministratorPassword" ForeColor="Red" ValidationGroup="Login"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group form-check">
                    <asp:CheckBox ID="chbRememberMe" runat="server" CssClass="form-check-input" Checked="True" />
                    <label style="font-size: 13px;" class="form-check-label" for="exampleCheck1">זכור אותי</label>
                </div>

                <asp:Button ID="btnAdministratorLogin" runat="server" Text="התחבר" CssClass="btn btn-primary" OnClick="btnAdministratorLogin_Click" ValidationGroup="Login" />
                <br />
                <div style="font-weight: bold; font-size: medium">
                    <asp:ValidationSummary ID="vsLogin" ForeColor="Red" ValidationGroup="Login" runat="server" DisplayMode="List" />
                    <asp:Label ID="lblErrorMessage" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>




    </form>
</body>
</html>
