using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if(Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Home.aspx");
            }
        }
        lblErrorMessage.Text = "";
    }

    protected void btnAdministratorLogin_Click(object sender, EventArgs e)
    {
        User user = new User(tbAdministratorPassword.Text);
        Administrator administrator = new Administrator(int.Parse(tbAdministratorID.Text), user);
        administrator = Operations.ValidateAdministrator(administrator);
        if (administrator == null)
        {
            lblErrorMessage.ForeColor = System.Drawing.Color.Red;
            lblErrorMessage.Text = "מספר זהות או סיסמא שגויים";
            tbAdministratorPassword.Text = "";
        }
        else
        {
            FormsAuthentication.RedirectFromLoginPage(tbAdministratorID.Text, chbRememberMe.Checked);
        }
        btnAdministratorLogin.Enabled = true;
    }
}