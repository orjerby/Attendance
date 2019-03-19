using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrators : System.Web.UI.Page
{
    /// <summary>
    /// Go to Error page if the user is not connected
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewState["NormalSearch"] = true;
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
        lblEditAdministratorMessage.Text = "";
        lblAddAdministratorMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsAdministrators.SelectCommand = "spGetAdministratorsBy";
        }
    }

    /// <summary>
    /// Add administrator
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddAdministrator_Click(object sender, EventArgs e)
    {
        sdsAdministrators.InsertParameters["AdministratorID"].DefaultValue = tbAdministratorIDAdd.Text;
        sdsAdministrators.InsertParameters["FirstName"].DefaultValue = tbAdministratorFirstNameAdd.Text;
        sdsAdministrators.InsertParameters["LastName"].DefaultValue = tbAdministratorLastNameAdd.Text;
        sdsAdministrators.InsertParameters["Email"].DefaultValue = tbAdministratorEmailAdd.Text;

        string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random random = new Random();
        char[] password = new char[5];
        for (int i = 0; i < 5; i++)
        {
            password[i] = passChars[(int)(35 * random.NextDouble())];
        }
        User user = new User(new string(password));
        Administrator administrator = new Administrator(int.Parse(tbAdministratorIDAdd.Text), tbAdministratorEmailAdd.Text, user);
        string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(administrator.User.Password, "SHA1");
        sdsAdministrators.InsertParameters["Password"].DefaultValue = encryptedPassword;
        ViewState["Administrator"] = administrator;
        
        sdsAdministrators.Insert();
    }

    /// <summary>
    /// Show warning message before deleting the administrator
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvAdministrators_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        ViewState["AdministratorID"] = e.Keys["AdministratorID"].ToString();
        Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal();", true);
    }

    /// <summary>
    /// Try to add Administrator - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsAdministrators_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            string from = "orjerby@gmail.com";
            string to = ((Administrator)ViewState["Administrator"]).Email;
            string subject = "סיסמה זמנית לאפליקציה";
            string body = "הסיסמה הזמנית שלך היא: " + "\n" + ((Administrator)ViewState["Administrator"]).User.Password;
            MailMessage message = new MailMessage(from, to, subject, body);
            SmtpClient smtp = new SmtpClient();
            try
            {
                smtp.Send(message);
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
            
            lblAddAdministratorMessage.ForeColor = System.Drawing.Color.Green;
            lblAddAdministratorMessage.Text = "האדמיניסטרטור נוצר בהצלחה";
            tbAdministratorIDAdd.Text = "";
            tbAdministratorFirstNameAdd.Text = "";
            tbAdministratorLastNameAdd.Text = "";
            tbAdministratorEmailAdd.Text = "";
            gvAdministrators.EditIndex = -1;
        }
        else
        {
            e.ExceptionHandled = true;
            lblAddAdministratorMessage.ForeColor = System.Drawing.Color.Red;
            lblAddAdministratorMessage.Text = e.Exception.Message;
        }
        btnAddAdministrator.Enabled = true;
    }

    /// <summary>
    /// Try to update Administrator - show warning message by the situationn
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsAdministrators_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblEditAdministratorMessage.ForeColor = System.Drawing.Color.Green;
            lblEditAdministratorMessage.Text = "האדמיניסטרטור עודכן בהצלחה";
        }
        else
        {
            e.ExceptionHandled = true;
            lblEditAdministratorMessage.ForeColor = System.Drawing.Color.Red;
            lblEditAdministratorMessage.Text = e.Exception.Message;

        }
    }

    /// <summary>
    /// Delete the administrator
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        sdsAdministrators.DeleteParameters["AdministratorID"].DefaultValue = ViewState["AdministratorID"].ToString();
        sdsAdministrators.Delete();
    }

    protected void sdsAdministrators_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblEditAdministratorMessage.ForeColor = System.Drawing.Color.Green;
            lblEditAdministratorMessage.Text = "האדמיניסטרטור נמחק בהצלחה";
        }
        else
        {
            lblEditAdministratorMessage.ForeColor = System.Drawing.Color.Red;
            lblEditAdministratorMessage.Text = "האדמיניסטרטור לא נמחק בהצלחה";
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchAdministrators_Click(object sender, EventArgs e)
    {
        if (tbAdministratorIDSearch.Text == "" && tbAdministratorFirstNameSearch.Text == "" && tbAdministratorLastNameSearch.Text == "")
        {
            sdsAdministrators.SelectCommand = "spGetAdministrators";
            sdsAdministrators.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsAdministrators.SelectCommand = "spGetAdministratorsBy";
            sdsAdministrators.SelectParameters.Clear();
            Parameter administratorID = new Parameter("AdministratorID", DbType.Int32, "0");
            Parameter firstName = new Parameter("FirstName", DbType.String, "");
            Parameter lastName = new Parameter("LastName", DbType.String, "");
            administratorID.ConvertEmptyStringToNull = false;
            firstName.ConvertEmptyStringToNull = false;
            lastName.ConvertEmptyStringToNull = false;
            sdsAdministrators.SelectParameters.Add(administratorID);
            sdsAdministrators.SelectParameters.Add(firstName);
            sdsAdministrators.SelectParameters.Add(lastName);
            sdsAdministrators.SelectParameters["AdministratorID"].DefaultValue = tbAdministratorIDSearch.Text == "" ? "0" : tbAdministratorIDSearch.Text;
            sdsAdministrators.SelectParameters["FirstName"].DefaultValue = tbAdministratorFirstNameSearch.Text;
            sdsAdministrators.SelectParameters["LastName"].DefaultValue = tbAdministratorLastNameSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["AdministratorIDSearch"] = tbAdministratorIDSearch.Text;
            ViewState["AdministratorFirstNameSearch"] = tbAdministratorFirstNameSearch.Text;
            ViewState["AdministratorLastNameSearch"] = tbAdministratorLastNameSearch.Text;
        }
        gvAdministrators.EditIndex = -1;
        gvAdministrators.SelectedIndex = -1;
    }

    protected void gvAdministrators_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Reset")
        {
            string[] arg = new string[8];
            arg = e.CommandArgument.ToString().Split(';');
            int administratorID = int.Parse(arg[0]);
            string email = arg[1];
            string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            Random random = new Random();
            char[] password = new char[5];
            for (int i = 0; i < 5; i++)
            {
                password[i] = passChars[(int)(35 * random.NextDouble())];
            }
            User user = new User(new string(password));
            Administrator administrator = new Administrator(administratorID, email, user);
            ViewState["Administrator"] = administrator;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal2();", true);
        }
    }


    protected void btnConfirmReset_Click(object sender, EventArgs e)
    {
        Administrator administrator = ViewState["Administrator"] as Administrator;
        Operations.UpdateAdministratorPassword(administrator);
        gvAdministrators.EditIndex = -1;
    }
}