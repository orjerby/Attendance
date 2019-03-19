using System;
using System.Collections.Generic;
using System.Linq;
using BEL;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BAL;
using System.Data;
using System.Web.Security;
using System.Net.Mail;
using System.Net;
using System.IO;
using System.Transactions;
using System.Configuration;

public partial class Students : System.Web.UI.Page
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
        lblEditStudentMessage.Text = "";
        lblEditCourseOfStudentMessage.Text = "";
        lblAddStudentMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsStudents.SelectCommand = "spGetStudentsBy";
        }
    }

    /// <summary>
    /// Add student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddStudent_Click(object sender, EventArgs e)
    {
        if (fulPictureAdd.PostedFile.ContentLength < 5000000)
        {
            using (TransactionScope tran = new TransactionScope())
            {
                string pictureName;
                try
                {
                    pictureName = DateTimeOffset.UtcNow.ToUnixTimeSeconds() + tbStudentIDAdd.Text + ".jpg";
                    fulPictureAdd.PostedFile.SaveAs(HttpContext.Current.Server.MapPath($"~/Images/Students/" + pictureName));
                }
                catch (Exception ex)
                {
                    lblAddStudentMessage.ForeColor = System.Drawing.Color.Red;
                    lblAddStudentMessage.Text = "הייתה בעיה עם העלאת התמונה";
                    return;
                }
                sdsStudents.InsertParameters["Picture"].DefaultValue = pictureName;
                sdsStudents.InsertParameters["StudentID"].DefaultValue = tbStudentIDAdd.Text;
                sdsStudents.InsertParameters["DepartmentID"].DefaultValue = ddlDepartmentsAdd.Text;
                sdsStudents.InsertParameters["CycleID"].DefaultValue = ddlCyclesAdd.Text;
                sdsStudents.InsertParameters["FirstName"].DefaultValue = tbStudentFirstNameAdd.Text;
                sdsStudents.InsertParameters["LastName"].DefaultValue = tbStudentLastNameAdd.Text;
                sdsStudents.InsertParameters["Email"].DefaultValue = tbStudentEmailAdd.Text;
                string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                Random random = new Random();
                char[] password = new char[5];
                for (int i = 0; i < 5; i++)
                {
                    password[i] = passChars[(int)(35 * random.NextDouble())];
                }
                User user = new User(new string(password));
                Student student = new Student(int.Parse(tbStudentIDAdd.Text), tbStudentEmailAdd.Text, user);
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(student.User.Password, "SHA1");
                sdsStudents.InsertParameters["Password"].DefaultValue = encryptedPassword;
                ViewState["Student"] = student;
                sdsStudents.Insert();

                tran.Complete();
            }
        }
        else
        {
            lblAddStudentMessage.ForeColor = System.Drawing.Color.Red;
            lblAddStudentMessage.Text = "התמונה שוקלת יותר מדי";
        }

    }

    /// <summary>
    /// Show warning message before deleting the student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        ViewState["StudentID"] = e.Keys["StudentID"].ToString();
        e.Cancel = true;
        Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal();", true);
    }

    /// <summary>
    /// Refresh the Cycles gridview by the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlDepartmentsAdd_SelectedIndexChanged(object sender, EventArgs e)
    {
        sdsCyclesAdd.SelectParameters["DepartmentID"].DefaultValue = "-1";
        sdsCyclesAdd.SelectParameters["DepartmentID"].DefaultValue = ddlDepartmentsAdd.SelectedValue;
    }

    /// <summary>
    /// Refresh the CoursesOfStudent gridview by the selected student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvStudents_SelectedIndexChanged(object sender, EventArgs e)
    {
        sdsCoursesOfStudent.SelectParameters["StudentID"].DefaultValue = gvStudents.SelectedValue.ToString();
        hfDepartmentID.Value = gvStudents.SelectedDataKey["DepartmentID"].ToString();
        gvCoursesOfStudent.DataBind();
        if (ViewState["SelectedRowIndex"] != null && gvStudents.SelectedIndex == int.Parse(ViewState["SelectedRowIndex"].ToString()))
        {
            gvStudents.SelectedIndex = -1;
            sdsCoursesOfStudent.SelectParameters["StudentID"].DefaultValue = "-1";
        }
        ViewState["SelectedRowIndex"] = gvStudents.SelectedIndex;
        gvCoursesOfStudent.EditIndex = -1;
    }

    /// <summary>
    /// Manually handle the row commands of gvStudents
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowIndex = -1;
        if (e.CommandName == "EditRow")
        {
            rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            gvStudents.EditIndex = rowIndex;
        }
        else if (e.CommandName == "UpdateRow")
        {
            rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            Department department = new Department(int.Parse(((DropDownList)gvStudents.Rows[rowIndex].FindControl("ddlDepartmentsEdit")).SelectedValue));
            Cycle cycle = new Cycle(int.Parse(((DropDownList)gvStudents.Rows[rowIndex].FindControl("ddlCyclesEdit2")).SelectedValue));
            string firstName = ((TextBox)gvStudents.Rows[rowIndex].FindControl("tbStudentFirstNameEdit")).Text;
            string lastName = ((TextBox)gvStudents.Rows[rowIndex].FindControl("tbStudentLastNameEdit")).Text;
            string email = ((TextBox)gvStudents.Rows[rowIndex].FindControl("tbStudentEmailEdit")).Text;
            bool isActive = ((CheckBox)gvStudents.Rows[rowIndex].FindControl("chkIsActive")).Checked;
            Student student = new Student(int.Parse(((Label)gvStudents.Rows[rowIndex].FindControl("lbStudentID")).Text), department, cycle, firstName, lastName, email, isActive);
            ViewState["Student"] = student;
            sdsStudents.UpdateParameters["StudentID"].DefaultValue = student.StudentID.ToString();
            sdsStudents.UpdateParameters["Email"].DefaultValue = student.Email;
            ViewState["UpdateFailed"] = false;
            sdsStudents.Update();
            gvStudents.EditIndex = -1;
            gvStudents.SelectedIndex = -1;
            sdsCoursesOfStudent.SelectParameters["StudentID"].DefaultValue = "-1";
            ViewState["SelectedRowIndex"] = null;
        }
        else if (e.CommandName == "CancelUpdate")
        {
            gvStudents.EditIndex = -1;
        }
        else if (e.CommandName == "Reset")
        {
            string[] arg = new string[8];
            arg = e.CommandArgument.ToString().Split(';');
            int studentID = int.Parse(arg[0]);
            string email = arg[1];
            string passChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            Random random = new Random();
            char[] password = new char[5];
            for (int i = 0; i < 5; i++)
            {
                password[i] = passChars[(int)(35 * random.NextDouble())];
            }
            User user = new User(new string(password));
            Student student = new Student(studentID, email, user);
            ViewState["Student"] = student;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal4();", true);
        }
        else if (e.CommandName == "Delete")
        {
            string picture = e.CommandArgument.ToString();
            ViewState["Picture"] = picture;
        }
    }

    /// <summary>
    /// Try to update the info of the student - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsStudents_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            string error = Operations.UpdateStudentTry((Student)ViewState["Student"]);
            if (error == null)
            {
                lblEditStudentMessage.ForeColor = System.Drawing.Color.Green;
                lblEditStudentMessage.Text = "הסטודנט עודכן בהצלחה";
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal2();", true);
                lblConfirmMessage2.Text = error;
                e.ExceptionHandled = true;
            }
        }
        else
        {
            e.ExceptionHandled = true;
            lblEditStudentMessage.ForeColor = System.Drawing.Color.Red;
            lblEditStudentMessage.Text = e.Exception.Message;
        }
    }

    /// <summary>
    /// Manually update the course of the student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCoursesOfStudent_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        e.Cancel = true;
        ViewState["StudentID"] = gvStudents.SelectedValue.ToString();
        ViewState["CourseID"] = e.Keys["CourseID"].ToString();
        ViewState["IsActive"] = e.NewValues["IsActive"].ToString();
        ViewState["OldCycleID"] = e.Keys["CycleID"].ToString();
        ViewState["CycleID"] = e.NewValues["CycleID"].ToString();
        sdsCoursesOfStudent.UpdateParameters["StudentID"].DefaultValue = ViewState["StudentID"].ToString();
        sdsCoursesOfStudent.UpdateParameters["CourseID"].DefaultValue = ViewState["CourseID"].ToString();
        sdsCoursesOfStudent.UpdateParameters["IsActive"].DefaultValue = ViewState["IsActive"].ToString();
        sdsCoursesOfStudent.UpdateParameters["OldCycleID"].DefaultValue = ViewState["OldCycleID"].ToString();
        sdsCoursesOfStudent.UpdateParameters["CycleID"].DefaultValue = ViewState["CycleID"].ToString();
        sdsCoursesOfStudent.Update();
        gvCoursesOfStudent.EditIndex = -1;
    }

    /// <summary>
    /// Try to update the course of the student - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsCoursesOfStudent_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblEditCourseOfStudentMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCourseOfStudentMessage.Text = "הרשומה עודכנה בהצלחה";
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal3();", true);
            lblConfirmMessage3.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }

    /// <summary>
    /// Select the current cycle of the student in ddlCycles inside Students gridview 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvStudents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList ddlCycles = e.Row.FindControl("ddlCyclesEdit") as DropDownList;
                Label lblCycleID = e.Row.FindControl("lblCycleID") as Label;
                ddlCycles.SelectedValue = Convert.ToString(lblCycleID.Text);

                DropDownList ddlCycles2 = e.Row.FindControl("ddlCyclesEdit2") as DropDownList;

                for (int i = 1; i < ddlCycles.Items.Count; i++)
                {
                    ddlCycles2.Items.Add(ddlCycles.Items[i]);
                }

                ddlCycles2.SelectedValue = ddlCycles.SelectedValue;
            }
        }
    }

    /// <summary>
    /// Refresh the gridviews after inserting new student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsStudents_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            string from = "orjerby@gmail.com";
            string to = ((Student)ViewState["Student"]).Email;
            string subject = "סיסמה זמנית לאפליקציה";
            string body = "הסיסמה הזמנית שלך היא: " + "\n" + ((Student)ViewState["Student"]).User.Password;
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
            lblAddStudentMessage.ForeColor = System.Drawing.Color.Green;
            lblAddStudentMessage.Text = "הסטודנט נוצר בהצלחה";
            tbStudentIDAdd.Text = "";
            tbStudentFirstNameAdd.Text = "";
            tbStudentLastNameAdd.Text = "";
            tbStudentEmailAdd.Text = "";
            ddlDepartmentsAdd.SelectedValue = "-1";
            ddlCyclesAdd.Items.Clear();
            ddlCyclesAdd.Items.Insert(0, new ListItem("בחר מחזור", "-1"));
            gvStudents.EditIndex = -1;
        }
        else
        {
            e.ExceptionHandled = true;
            lblAddStudentMessage.ForeColor = System.Drawing.Color.Red;
            lblAddStudentMessage.Text = e.Exception.Message;
        }
        gvStudents.SelectedIndex = -1;
        sdsCoursesOfStudent.SelectParameters["StudentID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
        btnAddStudent.Enabled = true;
    }

    /// <summary>
    /// Append default option to ddlDepartmentsSearch
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlDepartmentsSearch_DataBound(object sender, EventArgs e)
    {
        ddlDepartmentsSearch.Items.Insert(0, new ListItem("כל המגמות", "0"));
    }

    /// <summary>
    /// Append default option to ddlCyclesSearch
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCyclesSearch_DataBound(object sender, EventArgs e)
    {
        ddlCyclesSearch.Items.Insert(0, new ListItem("כל המחזורים", "0"));
    }

    /// <summary>
    /// Append default option to ddlDepartments
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlDepartmentsAdd_DataBound(object sender, EventArgs e)
    {
        ddlDepartmentsAdd.Items.Insert(0, new ListItem("בחר מגמה", "-1"));
    }

    /// <summary>
    /// Append default option to ddlCycles
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCyclesAdd_DataBound(object sender, EventArgs e)
    {
        ddlCyclesAdd.Items.Insert(0, new ListItem("בחר מחזור", "-1"));
    }

    /// <summary>
    /// Append default option to ddlCyclesEdit
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCyclesEdit_DataBinding(object sender, EventArgs e)
    {
        ((DropDownList)sender).Items.Clear();
        ((DropDownList)sender).Items.Insert(0, new ListItem("בחר מחזור", "-1"));
    }

    /// <summary>
    /// Append default option to ddlCyclesEdit2
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCyclesEdit2_DataBinding(object sender, EventArgs e)
    {
        ((DropDownList)sender).Items.Clear();
        ((DropDownList)sender).Items.Insert(0, new ListItem("בחר מחזור", "-1"));
    }

    protected void sdsStudents_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblEditStudentMessage.ForeColor = System.Drawing.Color.Green;
            lblEditStudentMessage.Text = "הסטודנט נמחק בהצלחה";
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lnkbtnForms.ForeColor = System.Drawing.ColorTranslator.FromHtml(ViewState["lnkbtnFormsOriginalColor"].ToString());
            }
        }
        else
        {
            lblEditStudentMessage.ForeColor = System.Drawing.Color.Red;
            lblEditStudentMessage.Text = "הסטודנט לא נמחק בהצלחה";
        }
    }

    /// <summary>
    /// Delete the student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        using (TransactionScope tran = new TransactionScope())
        {
            sdsStudents.DeleteParameters["StudentID"].DefaultValue = ViewState["StudentID"].ToString();
            sdsStudents.Delete();
            gvStudents.SelectedIndex = -1;
            sdsCoursesOfStudent.SelectParameters["StudentID"].DefaultValue = "-1";
            ViewState["SelectedRowIndex"] = null;

            try
            {
                // string path = ConfigurationManager.AppSettings["StudentsImagesPath"];
                // int pathLength = path.Length;
                // string pictureName = ViewState["Picture"].ToString().Substring(pathLength);
                if (File.Exists(HttpContext.Current.Server.MapPath($"~/Images/Students/" + ViewState["Picture"].ToString())))
                {
                    File.Delete(HttpContext.Current.Server.MapPath($"~/Images/Students/" + ViewState["Picture"].ToString()));
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            tran.Complete();
        }
    }

    /// <summary>
    /// Update the info of the student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmUpdate_Click(object sender, EventArgs e)
    {
        Student student = (Student)ViewState["Student"];
        int affectedRows = Operations.UpdateStudent(student);
        gvStudents.DataBind();
        if (affectedRows > 0)
        {
            lblEditStudentMessage.ForeColor = System.Drawing.Color.Green;
            lblEditStudentMessage.Text = "הסטודנט עודכן בהצלחה";
        }
        else
        {
            lblEditStudentMessage.ForeColor = System.Drawing.Color.Red;
            lblEditStudentMessage.Text = "הסטודנט לא עודכן בהצלחה";
        }
    }

    /// <summary>
    /// Update the course of the student
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmReplace_Click(object sender, EventArgs e)
    {
        Student student = new Student(int.Parse(ViewState["StudentID"].ToString()));
        Course course = new Course(int.Parse(ViewState["CourseID"].ToString()));
        Cycle cycle = new Cycle(int.Parse(ViewState["CycleID"].ToString()));
        Cycle oldCycle = new Cycle(int.Parse(ViewState["OldCycleID"].ToString()));
        CoursesOfStudent coursesOfStudent = new CoursesOfStudent(student, course, cycle, Convert.ToBoolean(ViewState["IsActive"].ToString()));
        int affectedRows = Operations.UpdateCourseOfStudent(coursesOfStudent, oldCycle);
        gvCoursesOfStudent.DataBind();
        if (affectedRows > 0)
        {
            lblEditCourseOfStudentMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCourseOfStudentMessage.Text = "הרשומה עודכנה בהצלחה";
        }
        else
        {
            lblEditCourseOfStudentMessage.ForeColor = System.Drawing.Color.Red;
            lblEditCourseOfStudentMessage.Text = "הרשומה לא עודכנה בהצלחה";
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchStudents_Click(object sender, EventArgs e)
    {
        if (tbStudentIDSearch.Text == "" && tbStudentFirstNameSearch.Text == "" && tbStudentLastNameSearch.Text == "" && ddlDepartmentsSearch.SelectedValue == "0" && ddlCyclesSearch.SelectedValue == "0")
        {
            sdsStudents.SelectCommand = "spGetStudents";
            sdsStudents.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsStudents.SelectCommand = "spGetStudentsBy";
            sdsStudents.SelectParameters.Clear();
            Parameter studentID = new Parameter("StudentID", DbType.Int32, "0");
            Parameter firstName = new Parameter("FirstName", DbType.String, "");
            Parameter lastName = new Parameter("LastName", DbType.String, "");
            Parameter departmentID = new Parameter("DepartmentID", DbType.Int32, "0");
            Parameter cycleID = new Parameter("CycleID", DbType.Int32, "0");
            studentID.ConvertEmptyStringToNull = false;
            firstName.ConvertEmptyStringToNull = false;
            lastName.ConvertEmptyStringToNull = false;
            departmentID.ConvertEmptyStringToNull = false;
            cycleID.ConvertEmptyStringToNull = false;
            sdsStudents.SelectParameters.Add(studentID);
            sdsStudents.SelectParameters.Add(firstName);
            sdsStudents.SelectParameters.Add(lastName);
            sdsStudents.SelectParameters.Add(departmentID);
            sdsStudents.SelectParameters.Add(cycleID);
            sdsStudents.SelectParameters["StudentID"].DefaultValue = tbStudentIDSearch.Text == "" ? "0" : tbStudentIDSearch.Text;
            sdsStudents.SelectParameters["FirstName"].DefaultValue = tbStudentFirstNameSearch.Text;
            sdsStudents.SelectParameters["LastName"].DefaultValue = tbStudentLastNameSearch.Text;
            sdsStudents.SelectParameters["DepartmentID"].DefaultValue = ddlDepartmentsSearch.SelectedValue;
            sdsStudents.SelectParameters["CycleID"].DefaultValue = ddlCyclesSearch.SelectedValue;
            ViewState["NormalSearch"] = false;
            ViewState["StudentIDSearch"] = tbStudentIDSearch.Text;
            ViewState["StudentFirstNameSearch"] = tbStudentFirstNameSearch.Text;
            ViewState["StudentLastNameSearch"] = tbStudentLastNameSearch.Text;
            ViewState["DepartmentSearch"] = ddlDepartmentsSearch.SelectedValue;
            ViewState["CycleSearch"] = ddlCyclesSearch.SelectedValue;
        }
        gvStudents.EditIndex = -1;
        gvStudents.SelectedIndex = -1;
        sdsCoursesOfStudent.SelectParameters["StudentID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
    }



    protected void btnConfirmReset_Click(object sender, EventArgs e)
    {
        Student student = ViewState["Student"] as Student;
        Operations.UpdateStudentPasswordForAdministrator(student);
        gvStudents.EditIndex = -1;
    }

    protected void gvStudents_PageIndexChanged(object sender, EventArgs e)
    {
        gvStudents.SelectedIndex = -1;
    }
}