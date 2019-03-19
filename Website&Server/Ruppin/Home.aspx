<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

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
    <script type="text/javascript">
        $(document).ready(function () {
            $('.leftmenutrigger').on('click', function (e) {
                $('.side-nav').toggleClass("open");
                e.preventDefault();
            });
        });
    </script>
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
        </div>
    </form>
</body>
</html>
