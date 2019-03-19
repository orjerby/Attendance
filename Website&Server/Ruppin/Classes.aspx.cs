using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Classes : System.Web.UI.Page
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
        lblEditClassMessage.Text = "";
        lblAddClassMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsClasses.SelectCommand = "spGetClassesBy";
        }
    }

    /// <summary>
    /// Add class
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddClass_Click(object sender, EventArgs e)
    {
        sdsClasses.InsertParameters["ClassName"].DefaultValue = tbClassNameAdd.Text;
        sdsClasses.Insert();
    }

    /// <summary>
    /// Trying to delete the class - showing warning messages by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvClasses_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        ViewState["ClassID"] = e.Keys["ClassID"].ToString();
        if (e.Exception == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal();", true);
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal2();", true);
            lblConfirmMessage2.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }

    protected void gvClasses_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblEditClassMessage.ForeColor = System.Drawing.Color.Green;
            lblEditClassMessage.Text = "הכיתה עודכנה בהצלחה";
        }
        else
        {
            lblEditClassMessage.ForeColor = System.Drawing.Color.Red;
            lblEditClassMessage.Text = "הכיתה לא עודכנה בהצלחה";
        }
    }

    protected void sdsClasses_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblAddClassMessage.ForeColor = System.Drawing.Color.Green;
            lblAddClassMessage.Text = "הכיתה נוצרה בהצלחה";
            tbClassNameAdd.Text = "";
            gvClasses.EditIndex = -1;
        }
        else
        {
            lblAddClassMessage.ForeColor = System.Drawing.Color.Red;
            lblAddClassMessage.Text = "הכיתה לא נוצרה בהצלחה";
        }
        btnAddClass.Enabled = true;
    }

    /// <summary>
    /// Delete the class
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        Class class1 = new Class(int.Parse(ViewState["ClassID"].ToString()));
        int affectedRows = Operations.DeleteClassSoft(class1);
        gvClasses.DataBind();
        if (affectedRows > 0)
        {
            lblEditClassMessage.ForeColor = System.Drawing.Color.Green;
            lblEditClassMessage.Text = "הכיתה נמחקה בהצלחה";
        }
        else
        {
            lblEditClassMessage.ForeColor = System.Drawing.Color.Red;
            lblEditClassMessage.Text = "הכיתה לא נמחקה בהצלחה";
        }
    }

    /// <summary>
    /// Delete the class and all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete2_Click(object sender, EventArgs e)
    {
        Class class1 = new Class(int.Parse(ViewState["ClassID"].ToString()));
        int affectedRows = Operations.DeleteClassHard(class1);
        gvClasses.DataBind();
        if (affectedRows > 0)
        {
            lblEditClassMessage.ForeColor = System.Drawing.Color.Green;
            lblEditClassMessage.Text = "הכיתה נמחקה בהצלחה";
        }
        else
        {
            lblEditClassMessage.ForeColor = System.Drawing.Color.Red;
            lblEditClassMessage.Text = "הכיתה לא נמחקה בהצלחה";
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchClasses_Click(object sender, EventArgs e)
    {
        if (tbClassNameSearch.Text == "")
        {
            sdsClasses.SelectCommand = "spGetClasses";
            sdsClasses.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsClasses.SelectCommand = "spGetClassesBy";
            sdsClasses.SelectParameters.Clear();
            Parameter className = new Parameter("ClassName", DbType.String, "");
            className.ConvertEmptyStringToNull = false;
            sdsClasses.SelectParameters.Add(className);
            sdsClasses.SelectParameters["ClassName"].DefaultValue = tbClassNameSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["ClassName"] = tbClassNameSearch.Text;
        }
        gvClasses.EditIndex = -1;
    }

}