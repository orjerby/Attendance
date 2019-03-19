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

public partial class LocationManagers : System.Web.UI.Page
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
        lblEditLocationManagerMessage.Text = "";
        lblAddLocationManagerMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsLocationManagers.SelectCommand = "spGetLocationManagersBy";
        }
    }

    /// <summary>
    /// Add LocationManager
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddLocationManager_Click(object sender, EventArgs e)
    {
        sdsLocationManagers.InsertParameters["LocationManagerID"].DefaultValue = tbLocationManagerIDAdd.Text;
        sdsLocationManagers.InsertParameters["FirstName"].DefaultValue = tbLocationManagerFirstNameAdd.Text;
        sdsLocationManagers.InsertParameters["LastName"].DefaultValue = tbLocationManagerLastNameAdd.Text;
        sdsLocationManagers.InsertParameters["Email"].DefaultValue = tbLocationManagerEmailAdd.Text;

        string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random random = new Random();
        char[] password = new char[5];
        for (int i = 0; i < 5; i++)
        {
            password[i] = passChars[(int)(35 * random.NextDouble())];
        }
        User user = new User(new string(password));
        LocationManager locationManager = new LocationManager(int.Parse(tbLocationManagerIDAdd.Text), tbLocationManagerEmailAdd.Text, user);
        string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(locationManager.User.Password, "SHA1");
        sdsLocationManagers.InsertParameters["Password"].DefaultValue = encryptedPassword;
        ViewState["LocationManager"] = locationManager;

        sdsLocationManagers.Insert();
    }

    /// <summary>
    /// Show warning message before deleting the LocationManager
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvLocationManagers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        ViewState["LocationManagerID"] = e.Keys["LocationManagerID"].ToString();
        Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal();", true);
    }

    /// <summary>
    /// Try to add LocationManager - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsLocationManagers_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            string from = "orjerby@gmail.com";
            string to = ((LocationManager)ViewState["LocationManager"]).Email;
            string subject = "סיסמה זמנית לאפליקציה";
            string body = "הסיסמה הזמנית שלך היא: " + "\n" + ((LocationManager)ViewState["LocationManager"]).User.Password;
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
            
            lblAddLocationManagerMessage.ForeColor = System.Drawing.Color.Green;
            lblAddLocationManagerMessage.Text = "האחראי מיקום נוצר בהצלחה";
            tbLocationManagerIDAdd.Text = "";
            tbLocationManagerFirstNameAdd.Text = "";
            tbLocationManagerLastNameAdd.Text = "";
            tbLocationManagerEmailAdd.Text = "";
            gvLocationManagers.EditIndex = -1;
        }
        else
        {
            e.ExceptionHandled = true;
            lblAddLocationManagerMessage.ForeColor = System.Drawing.Color.Red;
            lblAddLocationManagerMessage.Text = e.Exception.Message;
        }
        btnAddLocationManager.Enabled = true;
    }

    /// <summary>
    /// Try to update LocationManager - show warning message by the situationn
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsLocationManagers_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblEditLocationManagerMessage.ForeColor = System.Drawing.Color.Green;
            lblEditLocationManagerMessage.Text = "האחראי מיקום עודכן בהצלחה";
        }
        else
        {
            e.ExceptionHandled = true;
            lblEditLocationManagerMessage.ForeColor = System.Drawing.Color.Red;
            lblEditLocationManagerMessage.Text = e.Exception.Message;

        }
    }

    /// <summary>
    /// Delete the LocationManager
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        sdsLocationManagers.DeleteParameters["LocationManagerID"].DefaultValue = ViewState["LocationManagerID"].ToString();
        sdsLocationManagers.Delete();
    }

    protected void sdsLocationManagers_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblEditLocationManagerMessage.ForeColor = System.Drawing.Color.Green;
            lblEditLocationManagerMessage.Text = "האחראי מיקום נמחק בהצלחה";
        }
        else
        {
            lblEditLocationManagerMessage.ForeColor = System.Drawing.Color.Red;
            lblEditLocationManagerMessage.Text = "האחראי מיקום לא נמחק בהצלחה";
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchLocationManagers_Click(object sender, EventArgs e)
    {
        if (tbLocationManagerIDSearch.Text == "" && tbLocationManagerFirstNameSearch.Text == "" && tbLocationManagerLastNameSearch.Text == "")
        {
            sdsLocationManagers.SelectCommand = "spGetLocationManagers";
            sdsLocationManagers.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsLocationManagers.SelectCommand = "spGetLocationManagersBy";
            sdsLocationManagers.SelectParameters.Clear();
            Parameter locationManagerID = new Parameter("LocationManagerID", DbType.Int32, "0");
            Parameter firstName = new Parameter("FirstName", DbType.String, "");
            Parameter lastName = new Parameter("LastName", DbType.String, "");
            locationManagerID.ConvertEmptyStringToNull = false;
            firstName.ConvertEmptyStringToNull = false;
            lastName.ConvertEmptyStringToNull = false;
            sdsLocationManagers.SelectParameters.Add(locationManagerID);
            sdsLocationManagers.SelectParameters.Add(firstName);
            sdsLocationManagers.SelectParameters.Add(lastName);
            sdsLocationManagers.SelectParameters["LocationManagerID"].DefaultValue = tbLocationManagerIDSearch.Text == "" ? "0" : tbLocationManagerIDSearch.Text;
            sdsLocationManagers.SelectParameters["FirstName"].DefaultValue = tbLocationManagerFirstNameSearch.Text;
            sdsLocationManagers.SelectParameters["LastName"].DefaultValue = tbLocationManagerLastNameSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["LocationManagerIDSearch"] = tbLocationManagerIDSearch.Text;
            ViewState["LocationManagerFirstNameSearch"] = tbLocationManagerFirstNameSearch.Text;
            ViewState["LocationManagerLastNameSearch"] = tbLocationManagerLastNameSearch.Text;
        }
        gvLocationManagers.EditIndex = -1;
        gvLocationManagers.SelectedIndex = -1;
    }

    protected void gvLocationManagers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Reset")
        {
            string[] arg = new string[8];
            arg = e.CommandArgument.ToString().Split(';');
            int locationManagerID = int.Parse(arg[0]);
            string email = arg[1];
            string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            Random random = new Random();
            char[] password = new char[5];
            for (int i = 0; i < 5; i++)
            {
                password[i] = passChars[(int)(35 * random.NextDouble())];
            }
            User user = new User(new string(password));
            LocationManager locationManager = new LocationManager(locationManagerID, email, user);
            ViewState["LocationManager"] = locationManager;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal2();", true);
        }
    }


    protected void btnConfirmReset_Click(object sender, EventArgs e)
    {
        LocationManager locationManager = ViewState["LocationManager"] as LocationManager;
        Operations.UpdateLocationManagerPasswordForAdministrator(locationManager);
        gvLocationManagers.EditIndex = -1;
    }
}