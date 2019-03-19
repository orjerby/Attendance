using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Settings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnUpdateAdministratorPassword_Click(object sender, EventArgs e)
    {
        string currentPassword = tbAdministratorCurrentPasswordUpdate.Text;
        string newPassword = tbAdministratorNewPasswordUpdate.Text;
        int administratorID = int.Parse(Page.User.Identity.Name);
        Administrator administrator = new Administrator(administratorID);
        bool isOk = Operations.UpdateAdministratorPasswordFromSettingsPage(administrator, currentPassword, newPassword);

        if (isOk)
        {
            lblUpdateAdministratorPasswordMessage.ForeColor = System.Drawing.Color.Green;
            lblUpdateAdministratorPasswordMessage.Text = "הסיסמה שונתה בהצלחה";
        }
        else
        {
            lblUpdateAdministratorPasswordMessage.ForeColor = System.Drawing.Color.Red;
            lblUpdateAdministratorPasswordMessage.Text = "הסיסמה שגויה";
        }
    }
}