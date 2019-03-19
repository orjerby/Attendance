using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forms : System.Web.UI.Page
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
            ViewState["lnkbtnFormsOriginalColor"] = System.Drawing.ColorTranslator.ToHtml(lnkbtnForms.ForeColor);
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
        lblDeleteFormMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsForms.SelectCommand = "spGetFormsByStudent";
        }
    }

    protected void btnSearchForms_Click(object sender, EventArgs e)
    {
        if (tbStudentIDSearch.Text == "")
        {
            sdsForms.SelectCommand = "spGetForms";
            sdsForms.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsForms.SelectCommand = "spGetFormsByStudent";
            sdsForms.SelectParameters.Clear();
            Parameter studentID = new Parameter("StudentID", DbType.Int32, "0");
            studentID.ConvertEmptyStringToNull = false;
            sdsForms.SelectParameters.Add(studentID);
            sdsForms.SelectParameters["StudentID"].DefaultValue = tbStudentIDSearch.Text == "" ? "0" : tbStudentIDSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["StudentIDSearch"] = tbStudentIDSearch.Text;
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void gvForms_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnkbtnAccept = e.Row.FindControl("lnkbtnAccept") as LinkButton;
            LinkButton lnkbtnDecline = e.Row.FindControl("lnkbtnDecline") as LinkButton;
            int formStatusID = int.Parse(DataBinder.Eval(e.Row.DataItem, "FormStatusID").ToString());
            switch (formStatusID)
            {
                case 1: // waiting
                    lnkbtnAccept.Visible = true;
                    lnkbtnDecline.Visible = true;
                    break;
                case 2: // accept
                    lnkbtnAccept.Visible = false;
                    lnkbtnDecline.Visible = false;
                    break;
                case 3: // decline
                    lnkbtnAccept.Visible = false;
                    lnkbtnDecline.Visible = false;
                    break;
                default:
                    break;
            }
        }
    }

    protected void gvForms_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        ViewState["FormID"] = e.Keys["FormID"].ToString();
        Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal();", true);
    }

    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        Form form = new Form(int.Parse(ViewState["FormID"].ToString()));
        bool isOk = Operations.DeleteForm(form);
        if (isOk)
        {
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lnkbtnForms.ForeColor = System.Drawing.ColorTranslator.FromHtml(ViewState["lnkbtnFormsOriginalColor"].ToString());
            }
            lblDeleteFormMessage.ForeColor = System.Drawing.Color.Green;
            lblDeleteFormMessage.Text = "האישור נמחק בהצלחה";
            gvForms.DataBind();
        }
        else
        {
            lblDeleteFormMessage.ForeColor = System.Drawing.Color.Red;
            lblDeleteFormMessage.Text = "האישור לא נמחק בהצלחה";
        }
    }
    
    protected void gvForms_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Accept")
        {
            int rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            int formID = int.Parse(gvForms.DataKeys[rowIndex].Values["FormID"].ToString());
            Form form = new Form(formID);
            ViewState["Form"] = form;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal2();", true);
        }
        else if (e.CommandName == "Decline")
        {
            int rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            int formID = int.Parse(gvForms.DataKeys[rowIndex].Values["FormID"].ToString());
            Form form = new Form(formID);
            ViewState["Form"] = form;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal3();", true);
        }
        else if (e.CommandName == "Download")
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            string picture = arg[0];
            string studentID = arg[1];
            // string path = ConfigurationManager.AppSettings["FormsImagesPath"];
            // int pathLength = path.Length;
            // string pictureName = picture.Substring(pathLength);
            Response.Clear();
            Response.ContentType = "image/JPEG";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + studentID + ".jpg");
            Response.TransmitFile(HttpContext.Current.Server.MapPath($"~/Images/Forms/" + picture));
            Response.End();
        }
    }

    protected void btnConfirmAccept_Click(object sender, EventArgs e)
    {
        Form form = ViewState["Form"] as Form;
        Operations.AcceptForm(form);
        int waitingFormsCount = Operations.GetNumberOfWaitingForms();
        if (waitingFormsCount > 0)
        {
            lnkbtnForms.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            lnkbtnForms.ForeColor = System.Drawing.ColorTranslator.FromHtml(ViewState["lnkbtnFormsOriginalColor"].ToString());
        }
        gvForms.DataBind();
    }

    protected void btnConfirmDecline_Click(object sender, EventArgs e)
    {
        Form form = ViewState["Form"] as Form;
        Operations.DeclineForm(form);
        int waitingFormsCount = Operations.GetNumberOfWaitingForms();
        if (waitingFormsCount > 0)
        {
            lnkbtnForms.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            lnkbtnForms.ForeColor = System.Drawing.ColorTranslator.FromHtml(ViewState["lnkbtnFormsOriginalColor"].ToString());
        }
        gvForms.DataBind();
    }
}