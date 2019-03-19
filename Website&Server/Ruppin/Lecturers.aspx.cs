using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Transactions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Lecturers : System.Web.UI.Page
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
            cblCourses.Visible = false;
            lblCoursesOfLecturer.Visible = false;
            btnReplaceCoursesOfLecturer.Visible = false;
            ViewState["NormalSearch"] = true;
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
        lblEditLecturerMessage.Text = "";
        lblReplaceCoursesOfLecturerMessage.Text = "";
        lblAddLecturerMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsLecturers.SelectCommand = "spGetLecturersBy";
        }
    }

    /// <summary>
    /// Add lecturer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddLecturer_Click(object sender, EventArgs e)
    {
        if (fulPictureAdd.PostedFile.ContentLength < 5000000)
        {
            using (TransactionScope tran = new TransactionScope())
            {
                string pictureName;
                try
                {
                    pictureName = DateTimeOffset.UtcNow.ToUnixTimeSeconds() + tbLecturerIDAdd.Text + ".jpg";
                    fulPictureAdd.PostedFile.SaveAs(HttpContext.Current.Server.MapPath($"~/Images/Lecturers/" + pictureName));
                }
                catch (Exception ex)
                {
                    lblAddLecturerMessage.ForeColor = System.Drawing.Color.Red;
                    lblAddLecturerMessage.Text = "הייתה בעיה עם העלאת התמונה";
                    return;
                }
                sdsLecturers.InsertParameters["Picture"].DefaultValue = pictureName;
                sdsLecturers.InsertParameters["LecturerID"].DefaultValue = tbLecturerIDAdd.Text;
                sdsLecturers.InsertParameters["FirstName"].DefaultValue = tbLecturerFirstNameAdd.Text;
                sdsLecturers.InsertParameters["LastName"].DefaultValue = tbLecturerLastNameAdd.Text;
                sdsLecturers.InsertParameters["Email"].DefaultValue = tbLecturerEmailAdd.Text;
                string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                Random random = new Random();
                char[] password = new char[5];
                for (int i = 0; i < 5; i++)
                {
                    password[i] = passChars[(int)(35 * random.NextDouble())];
                }
                User user = new User(new string(password));
                Lecturer lecturer = new Lecturer(int.Parse(tbLecturerIDAdd.Text), tbLecturerEmailAdd.Text, user);
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(lecturer.User.Password, "SHA1");
                sdsLecturers.InsertParameters["Password"].DefaultValue = encryptedPassword;
                ViewState["Lecturer"] = lecturer;
                sdsLecturers.Insert();

                tran.Complete();
            }
        }
        else
        {
            lblAddLecturerMessage.ForeColor = System.Drawing.Color.Red;
            lblAddLecturerMessage.Text = "התמונה שוקלת יותר מדי";
        }
    }

    /// <summary>
    /// Try to delete the lecturer - show warning messages by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvLecturers_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        ViewState["LecturerID"] = e.Keys["LecturerID"].ToString();
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


    /// <summary>
    /// Refresh the CoursesOfLecturer gridview by the selected lecturer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvLecturers_SelectedIndexChanged(object sender, EventArgs e)
    {
        cblCourses.ClearSelection();
        sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = gvLecturers.SelectedValue.ToString();
        if (ViewState["SelectedRowIndex"] != null && gvLecturers.SelectedIndex == int.Parse(ViewState["SelectedRowIndex"].ToString()))
        {
            gvLecturers.SelectedIndex = -1;
            sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
            cblCourses.Visible = false;
            lblCoursesOfLecturer.Visible = false;
            btnReplaceCoursesOfLecturer.Visible = false;
        }
        else
        {
            cblCourses.Visible = true;
            lblCoursesOfLecturer.Visible = true;
            btnReplaceCoursesOfLecturer.Visible = true;
        }
        ViewState["SelectedRowIndex"] = gvLecturers.SelectedIndex;
        cblCourses.ClearSelection();
    }

    /// <summary>
    /// Replace courses of the selected lecturer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReplaceCoursesOfLecturer_Click(object sender, EventArgs e)
    {
        tbLecturerIDSearch.Text = "";
        tbLecturerFirstNameSearch.Text = "";
        tbLecturerLastNameSearch.Text = "";
        string coursesIDValues = ";";
        foreach (ListItem item in cblCourses.Items)
        {
            if (item.Selected)
            {
                coursesIDValues += item.Value + ";";
            }
        }
        ViewState["ListOfCourses"] = coursesIDValues;
        sdsCoursesOfLecturer.InsertParameters["LecturerID"].DefaultValue = gvLecturers.SelectedValue == null ? "-1" : gvLecturers.SelectedValue.ToString();
        sdsCoursesOfLecturer.InsertParameters["ListOfCourses"].DefaultValue = ViewState["ListOfCourses"].ToString();
        sdsCoursesOfLecturer.Insert();
        cblCourses.ClearSelection();
    }

    /// <summary>
    /// Try to replace the courses of the lecturer - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsCoursesOfLecturer_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblReplaceCoursesOfLecturerMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceCoursesOfLecturerMessage.Text = "הרשומות עודכנו בהצלחה";
            btnReplaceCoursesOfLecturer.Enabled = true;
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal3();", true);
            lblConfirmMessage3.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }



    /// <summary>
    /// Make the check boxes of courses get auto selected and unselected by the selected lecturer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCoursesOfLecturer_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string optionValue = DataBinder.Eval(e.Row.DataItem, "CourseID").ToString();
            cblCourses.Items.FindByValue(optionValue).Selected = true;

            if (ViewState["DefaultCourses"] == null)
            {
                List<string> values = new List<string>();
                values.Add(optionValue);
                ViewState["DefaultCourses"] = values;
            }
            else
            {
                List<string> values = (List<string>)ViewState["DefaultCourses"];
                values.Add(optionValue);
                ViewState["DefaultCourses"] = values;
            }
        }
    }

    /// <summary>
    /// Refresh the CoursesOfLecturer gridview after updating lecturer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvLecturers_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        gvLecturers.SelectedIndex = -1;
        ViewState["SelectedRowIndex"] = null;
        sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
        cblCourses.ClearSelection();
        cblCourses.Visible = false;
        lblCoursesOfLecturer.Visible = false;
        btnReplaceCoursesOfLecturer.Visible = false;
    }

    /// <summary>
    /// Refresh the Lecturers gridview after inserting lecturer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsLecturers_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            string from = "orjerby@gmail.com";
            string to = ((Lecturer)ViewState["Lecturer"]).Email;
            string subject = "סיסמה זמנית לאפליקציה";
            string body = "הסיסמה הזמנית שלך היא: " + "\n" + ((Lecturer)ViewState["Lecturer"]).User.Password;
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

            lblAddLecturerMessage.ForeColor = System.Drawing.Color.Green;
            lblAddLecturerMessage.Text = "המרצה נוצר בהצלחה";
            tbLecturerIDAdd.Text = "";
            tbLecturerFirstNameAdd.Text = "";
            tbLecturerLastNameAdd.Text = "";
            tbLecturerEmailAdd.Text = "";
            gvLecturers.EditIndex = -1;
            cblCourses.Visible = false;
            lblCoursesOfLecturer.Visible = false;
            btnReplaceCoursesOfLecturer.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            e.ExceptionHandled = true;
            lblAddLecturerMessage.ForeColor = System.Drawing.Color.Red;
            lblAddLecturerMessage.Text = e.Exception.Message;
        }
        gvLecturers.SelectedIndex = -1;
        ViewState["SelectedRowIndex"] = null;
        sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
        cblCourses.ClearSelection();
        btnAddLecturer.Enabled = true;
    }

    /// <summary>
    /// Try to update Lecturer - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsLecturers_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblEditLecturerMessage.ForeColor = System.Drawing.Color.Green;
            lblEditLecturerMessage.Text = "המרצה עודכן בהצלחה";
        }
        else
        {
            e.ExceptionHandled = true;
            lblEditLecturerMessage.ForeColor = System.Drawing.Color.Red;
            lblEditLecturerMessage.Text = e.Exception.Message;
        }
    }

    /// <summary>
    /// Delete the lecturer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        using (TransactionScope tran = new TransactionScope())
        {
            Lecturer lecturer = new Lecturer(int.Parse(ViewState["LecturerID"].ToString()));
            int affectedRows = Operations.DeleteLecturerSoft(lecturer);
            gvLecturers.DataBind();
            gvLecturers.SelectedIndex = -1;
            ViewState["SelectedRowIndex"] = null;
            sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
            cblCourses.ClearSelection();
            if (affectedRows > 0)
            {
                try
                {
                    // string path = ConfigurationManager.AppSettings["LecturersImagesPath"];
                    // int pathLength = path.Length;
                    // string pictureName = ViewState["Picture"].ToString().Substring(pathLength);
                    if (File.Exists(HttpContext.Current.Server.MapPath($"~/Images/Lecturers/" + ViewState["Picture"].ToString())))
                    {
                        File.Delete(HttpContext.Current.Server.MapPath($"~/Images/Lecturers/" + ViewState["Picture"].ToString()));
                    }
                }
                catch (Exception ex)
                {
                    ex.ToString();
                }

                lblEditLecturerMessage.ForeColor = System.Drawing.Color.Green;
                lblEditLecturerMessage.Text = "המרצה נמחק בהצלחה";
                cblCourses.ClearSelection();
                cblCourses.Visible = false;
                lblCoursesOfLecturer.Visible = false;
                sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
                btnReplaceCoursesOfLecturer.Visible = false;
                ViewState["SelectedRowIndex"] = null;
            }
            else
            {
                lblEditLecturerMessage.ForeColor = System.Drawing.Color.Red;
                lblEditLecturerMessage.Text = "המרצה לא נמחק בהצלחה";
            }

            tran.Complete();
        }
    }

    /// <summary>
    /// Delete the lecturer and all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete2_Click(object sender, EventArgs e)
    {
        Lecturer lecturer = new Lecturer(int.Parse(ViewState["LecturerID"].ToString()));
        int affectedRows = Operations.DeleteLecturerHard(lecturer);
        gvLecturers.DataBind();
        gvLecturers.SelectedIndex = -1;
        ViewState["SelectedRowIndex"] = null;
        sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
        cblCourses.ClearSelection();
        if (affectedRows > 0)
        {
            lblEditLecturerMessage.ForeColor = System.Drawing.Color.Green;
            lblEditLecturerMessage.Text = "המרצה נמחק בהצלחה";
            cblCourses.ClearSelection();
            cblCourses.Visible = false;
            lblCoursesOfLecturer.Visible = false;
            sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
            btnReplaceCoursesOfLecturer.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblEditLecturerMessage.ForeColor = System.Drawing.Color.Red;
            lblEditLecturerMessage.Text = "המרצה לא נמחק בהצלחה";
        }
    }

    /// <summary>
    /// Replace the courses of the lecturer and delete all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmReplace_Click(object sender, EventArgs e)
    {
        Lecturer lecturer = new Lecturer(gvLecturers.SelectedValue == null ? -1 : int.Parse(gvLecturers.SelectedValue.ToString()));
        int affectedRows = Operations.ReplaceCoursesOfLecturer(ViewState["ListOfCourses"].ToString(), lecturer);
        cblCourses.ClearSelection();
        gvCoursesOfLecturer.DataBind();
        if (affectedRows > 0)
        {
            lblReplaceCoursesOfLecturerMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceCoursesOfLecturerMessage.Text = "הרשומות עודכנו בהצלחה";
        }
        else
        {
            lblReplaceCoursesOfLecturerMessage.ForeColor = System.Drawing.Color.Red;
            lblReplaceCoursesOfLecturerMessage.Text = "הרשומות לא עודכנו בהצלחה";
        }
        btnReplaceCoursesOfLecturer.Enabled = true;
    }

    protected void btnCancelReplace_Click(object sender, EventArgs e)
    {
        cblCourses.ClearSelection();
        List<string> values = (List<string>)ViewState["DefaultCourses"];
        foreach (var value in values)
        {
            cblCourses.Items.FindByValue(value).Selected = true;
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchLecturers_Click(object sender, EventArgs e)
    {
        if (tbLecturerIDSearch.Text == "" && tbLecturerFirstNameSearch.Text == "" && tbLecturerLastNameSearch.Text == "")
        {
            sdsLecturers.SelectCommand = "spGetLecturers";
            sdsLecturers.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsLecturers.SelectCommand = "spGetLecturersBy";
            sdsLecturers.SelectParameters.Clear();
            Parameter lecturerID = new Parameter("LecturerID", DbType.Int32, "0");
            Parameter firstName = new Parameter("FirstName", DbType.String, "");
            Parameter lastName = new Parameter("LastName", DbType.String, "");
            lecturerID.ConvertEmptyStringToNull = false;
            firstName.ConvertEmptyStringToNull = false;
            lastName.ConvertEmptyStringToNull = false;
            sdsLecturers.SelectParameters.Add(lecturerID);
            sdsLecturers.SelectParameters.Add(firstName);
            sdsLecturers.SelectParameters.Add(lastName);
            sdsLecturers.SelectParameters["LecturerID"].DefaultValue = tbLecturerIDSearch.Text == "" ? "0" : tbLecturerIDSearch.Text;
            sdsLecturers.SelectParameters["FirstName"].DefaultValue = tbLecturerFirstNameSearch.Text;
            sdsLecturers.SelectParameters["LastName"].DefaultValue = tbLecturerLastNameSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["LecturerIDSearch"] = tbLecturerIDSearch.Text;
            ViewState["LecturerFirstNameSearch"] = tbLecturerFirstNameSearch.Text;
            ViewState["LecturerLastNameSearch"] = tbLecturerLastNameSearch.Text;
        }
        gvLecturers.EditIndex = -1;
        gvLecturers.SelectedIndex = -1;
        cblCourses.ClearSelection();
        sdsCoursesOfLecturer.SelectParameters["LecturerID"].DefaultValue = "-1";
        cblCourses.Visible = false;
        lblCoursesOfLecturer.Visible = false;
        btnReplaceCoursesOfLecturer.Visible = false;
        ViewState["SelectedRowIndex"] = null;
    }


    protected void gvLecturers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Reset")
        {
            string[] arg = new string[8];
            arg = e.CommandArgument.ToString().Split(';');
            int lecturerID = int.Parse(arg[0]);
            string email = arg[1];
            string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            Random random = new Random();
            char[] password = new char[5];
            for (int i = 0; i < 5; i++)
            {
                password[i] = passChars[(int)(35 * random.NextDouble())];
            }
            User user = new User(new string(password));
            Lecturer lecturer = new Lecturer(lecturerID, email, user);
            ViewState["Lecturer"] = lecturer;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal4();", true);
        }
        else if (e.CommandName == "Delete")
        {
            string picture = e.CommandArgument.ToString();
            ViewState["Picture"] = picture;
        }
    }

    protected void btnConfirmReset_Click(object sender, EventArgs e)
    {
        Lecturer lecturer = ViewState["Lecturer"] as Lecturer;
        Operations.UpdateLecturerPasswordForAdministrator(lecturer);
        gvLecturers.EditIndex = -1;
    }

    protected void gvLecturers_PageIndexChanged(object sender, EventArgs e)
    {
        gvLecturers.SelectedIndex = -1;
    }
}