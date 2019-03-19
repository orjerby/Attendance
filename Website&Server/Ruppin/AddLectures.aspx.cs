using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddLectures : System.Web.UI.Page
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
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
        lblEditLecturesInSemesterMessage.Text = "";
        lblAddLecturesInSemesterMessage.Text = "";
        tbOpenDateAdd.Attributes.Add("readonly", "readonly");
        tbEndDateAdd.Attributes.Add("readonly", "readonly");
        tbBeginHourAdd.Attributes.Add("readonly", "readonly");
        tbEndHourAdd.Attributes.Add("readonly", "readonly");
        tbBeginHourAdd2.Attributes.Add("readonly", "readonly");
        tbEndHourAdd2.Attributes.Add("readonly", "readonly");
        tbLectureDateAdd.Attributes.Add("readonly", "readonly");
    }

    /// <summary>
    /// Check if can add coursesintime
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddLecturesInSemester_Click(object sender, EventArgs e)
    {
        sdsLecturesInSemesters.InsertParameters["CourseID"].DefaultValue = ddlCoursesAdd.SelectedValue;
        sdsLecturesInSemesters.InsertParameters["DepartmentID"].DefaultValue = ddlDepartmentsAdd.SelectedValue;
        sdsLecturesInSemesters.InsertParameters["CycleID"].DefaultValue = ddlCyclesAdd.SelectedValue;
        sdsLecturesInSemesters.InsertParameters["LecturerID"].DefaultValue = ddlLecturersAdd.SelectedValue;
        sdsLecturesInSemesters.InsertParameters["BeginHour"].DefaultValue = tbBeginHourAdd.Text;
        sdsLecturesInSemesters.InsertParameters["EndHour"].DefaultValue = tbEndHourAdd.Text;
        sdsLecturesInSemesters.Insert();
    }

    /// <summary>
    /// Try to add coursesintimes - show warning messages by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsLecturesInSemesters_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            Course course = new Course(int.Parse(ddlCoursesAdd.SelectedValue));
            Department department = new Department(int.Parse(ddlDepartmentsAdd.SelectedValue));
            Cycle cycle = new Cycle(int.Parse(ddlCyclesAdd.SelectedValue));
            Weekday weekday = new Weekday(int.Parse(ddlWeekdaysAdd.SelectedValue));
            Class class1 = new Class(int.Parse(ddlClassesAdd.SelectedValue));
            Lecturer lecturer = new Lecturer(int.Parse(ddlLecturersAdd.SelectedValue));
            string beginHour = tbBeginHourAdd.Text;
            string endHour = tbEndHourAdd.Text;
            Lecture lecture = new Lecture(course, department, cycle, lecturer, class1, beginHour, endHour);
            DateTime openDate = DateTime.ParseExact(tbOpenDateAdd.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime endDate = DateTime.ParseExact(tbEndDateAdd.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            LecturesInSemester lecturesInSemester = new LecturesInSemester(lecture, weekday, openDate, endDate);
            ViewState["LecturesInSemester"] = lecturesInSemester;
            string error = Operations.CheckAddLecturesInSemester(lecturesInSemester);
            if (error == null)
            {
                error = Operations.AddLecturesInSemesterTry(lecturesInSemester);
                if (error == null)
                {
                    gvLecturesInSemesters.DataBind();
                    lblAddLecturesInSemesterMessage.ForeColor = System.Drawing.Color.Green;
                    lblAddLecturesInSemesterMessage.Text = "ההרצאות נוצרו בהצלחה";
                    ddlDepartmentsAdd.SelectedValue = "-1";
                    ddlCyclesAdd.SelectedValue = "-1";
                    ddlCoursesAdd.SelectedValue = "-1";
                    ddlLecturersAdd.SelectedValue = "-1";
                    ddlClassesAdd.SelectedValue = "-1";
                    ddlWeekdaysAdd.SelectedValue = "-1";
                    tbBeginHourAdd.Text = "";
                    tbEndHourAdd.Text = "";
                    tbOpenDateAdd.Text = "";
                    tbEndDateAdd.Text = "";
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal2();", true);
                    lblConfirmMessage2.Text = error;
                }
            }
            else
            {
                lblAddLecturesInSemesterMessage.ForeColor = System.Drawing.Color.Red;
                lblAddLecturesInSemesterMessage.Text = error;
            }
        }
        else
        {
            e.ExceptionHandled = true;
            lblAddLecturesInSemesterMessage.ForeColor = System.Drawing.Color.Red;
            lblAddLecturesInSemesterMessage.Text = e.Exception.Message;
        }
        btnAddLecturesInSemester.Enabled = true;
    }

    /// <summary>
    /// Try to add lecture - show warning messages by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddLecture_Click(object sender, EventArgs e)
    {
        Course course = new Course(int.Parse(ddlCoursesAdd2.SelectedValue));
        Department department = new Department(int.Parse(ddlDepartmentsAdd2.SelectedValue));
        Cycle cycle = new Cycle(int.Parse(ddlCyclesAdd2.SelectedValue));
        Lecturer lecturer = new Lecturer(int.Parse(ddlLecturersAdd2.SelectedValue));
        Class class1 = new Class(int.Parse(ddlClassesAdd2.SelectedValue));
        DateTime lectureDate = DateTime.ParseExact(tbLectureDateAdd.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        string beginHour = tbBeginHourAdd2.Text;
        string endHour = tbEndHourAdd2.Text;
        Lecture lecture = new Lecture(course, department, cycle, lecturer, class1, lectureDate, beginHour, endHour);
        Lecture lecture2 = new Lecture(course, department, cycle, lecturer, beginHour, endHour);

        string error = Operations.CheckAddLecture(lecture2);
        if (error == null)
        {
            error = Operations.AddLectureTry(lecture);
            if (error == null)
            {
                lblAddLectureMessage.ForeColor = System.Drawing.Color.Green;
                lblAddLectureMessage.Text = "ההרצאה נוצרה בהצלחה";
                ddlDepartmentsAdd2.SelectedValue = "-1";
                ddlCyclesAdd2.SelectedValue = "-1";
                ddlCoursesAdd2.SelectedValue = "-1";
                ddlLecturersAdd2.SelectedValue = "-1";
                ddlClassesAdd2.SelectedValue = "-1";
                tbBeginHourAdd2.Text = "";
                tbEndHourAdd2.Text = "";
                tbLectureDateAdd.Text = "";
            }
            else
            {
                lblAddLectureMessage.ForeColor = System.Drawing.Color.Red;
                lblAddLectureMessage.Text = error;
            }
        }
        else
        {
            lblAddLectureMessage.ForeColor = System.Drawing.Color.Red;
            lblAddLectureMessage.Text = error;
        }
        btnAddLecture.Enabled = true;
    }

    /// <summary>
    /// Manually delete lectures in semester
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvLecturesInSemesters_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteRow")
        {
            string[] arg = new string[7];
            arg = e.CommandArgument.ToString().Split(';');
            Department department = new Department(int.Parse(arg[0]));
            Cycle cycle = new Cycle(int.Parse(arg[1]));
            Weekday weekday = new Weekday(int.Parse(arg[2]));
            string beginHour = arg[3];
            string endHour = arg[4];
            DateTime openDate = Convert.ToDateTime(arg[5]);
            DateTime endDate = Convert.ToDateTime(arg[6]);
            Lecture lecture = new Lecture(department, cycle, beginHour, endHour);
            LecturesInSemester lecturesInSemester = new LecturesInSemester(lecture, weekday, openDate, endDate);
            ViewState["LecturesInSemester"] = lecturesInSemester;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal();", true);
        }
    }

    /// <summary>
    /// Refresh Cycles, Courses and lecturers drop down lists by the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlDepartmentsAdd_SelectedIndexChanged(object sender, EventArgs e)
    {
        sdsCyclesAdd.SelectParameters["DepartmentID"].DefaultValue = ddlDepartmentsAdd.SelectedValue;
        sdsCoursesAdd.SelectParameters["DepartmentID"].DefaultValue = ddlDepartmentsAdd.SelectedValue;
        sdsLecturersAdd.SelectParameters["CourseID"].DefaultValue = "-1";
    }

    /// <summary>
    /// Refresh Lecturers drop down list by the selected course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCoursesAdd_SelectedIndexChanged(object sender, EventArgs e)
    {
        sdsLecturersAdd.SelectParameters["CourseID"].DefaultValue = ddlCoursesAdd.SelectedValue;
    }

    /// <summary>
    /// Refresh Cycles, Courses and lecturers drop down lists by the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlDepartmentsAdd2_SelectedIndexChanged(object sender, EventArgs e)
    {
        sdsCyclesAdd2.SelectParameters["DepartmentID"].DefaultValue = ddlDepartmentsAdd2.SelectedValue;
        sdsCoursesAdd2.SelectParameters["DepartmentID"].DefaultValue = ddlDepartmentsAdd2.SelectedValue;
        sdsLecturersAdd2.SelectParameters["CourseID"].DefaultValue = "-1";
    }

    /// <summary>
    /// Refresh Lecturers drop down list by the selected course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCoursesAdd2_SelectedIndexChanged(object sender, EventArgs e)
    {
        sdsLecturersAdd2.SelectParameters["CourseID"].DefaultValue = ddlCoursesAdd2.SelectedValue;
    }

    /// <summary>
    /// Append default option to ddlCourses
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCoursesAdd_DataBound(object sender, EventArgs e)
    {
        ddlCoursesAdd.Items.Insert(0, new ListItem("בחר קורס", "-1"));
    }

    /// <summary>
    /// Append default option to ddlLecturers
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlLecturersAdd_DataBound(object sender, EventArgs e)
    {
        ddlLecturersAdd.Items.Insert(0, new ListItem("בחר מרצה", "-1"));
    }

    /// <summary>
    /// Append default option to ddlCourses2
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCoursesAdd2_DataBound(object sender, EventArgs e)
    {
        ddlCoursesAdd2.Items.Insert(0, new ListItem("בחר קורס", "-1"));
    }

    /// <summary>
    /// Append default option to ddlLecturers2
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlLecturersAdd2_DataBound(object sender, EventArgs e)
    {
        ddlLecturersAdd2.Items.Insert(0, new ListItem("בחר מרצה", "-1"));
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
    /// Append default option to ddlCycles2
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlCyclesAdd2_DataBound(object sender, EventArgs e)
    {
        ddlCyclesAdd2.Items.Insert(0, new ListItem("בחר מחזור", "-1"));
    }

    /// <summary>
    /// Delete lectures in semester
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        int affectedRows = Operations.DeleteLecturesInSemester((LecturesInSemester)ViewState["LecturesInSemester"]);
        gvLecturesInSemesters.DataBind();
        if (affectedRows > 0)
        {
            lblEditLecturesInSemesterMessage.ForeColor = System.Drawing.Color.Green;
            lblEditLecturesInSemesterMessage.Text = "ההרצאות נמחקו";
        }
        else
        {
            lblEditLecturesInSemesterMessage.ForeColor = System.Drawing.Color.Red;
            lblEditLecturesInSemesterMessage.Text = "ההרצאות לא נמחקו";
        }
    }

    /// <summary>
    /// Add lectures in semester
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmAdd_Click(object sender, EventArgs e)
    {
        int affectedRows = Operations.AddLecturesInSemester((LecturesInSemester)ViewState["LecturesInSemester"]);
        gvLecturesInSemesters.DataBind();
        if (affectedRows > 0)
        {
            lblAddLecturesInSemesterMessage.ForeColor = System.Drawing.Color.Green;
            lblAddLecturesInSemesterMessage.Text = "ההרצאות נוצרו בהצלחה";
            lblAddLecturesInSemesterMessage.Text = "ההרצאות נוצרו בהצלחה";
            ddlDepartmentsAdd.SelectedValue = "-1";
            ddlCyclesAdd.SelectedValue = "-1";
            ddlCoursesAdd.SelectedValue = "-1";
            ddlLecturersAdd.SelectedValue = "-1";
            ddlClassesAdd.SelectedValue = "-1";
            ddlWeekdaysAdd.SelectedValue = "-1";
            tbBeginHourAdd.Text = "";
            tbEndHourAdd.Text = "";
            tbOpenDateAdd.Text = "";
            tbEndDateAdd.Text = "";
        }
        else
        {
            lblAddLecturesInSemesterMessage.ForeColor = System.Drawing.Color.Red;
            lblAddLecturesInSemesterMessage.Text = "ההרצאות לא נוצרו בהצלחה";
        }
    }

    protected void gvLecturesInSemesters_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblEndHour = e.Row.FindControl("lblEndHour") as Label;
            Label lblBeginHour = e.Row.FindControl("lblBeginHour") as Label;
            if (lblEndHour != null)
            {
                lblEndHour.Text = lblEndHour.Text.Substring(0, 5);
            }
            if (lblBeginHour != null)
            {
                lblBeginHour.Text = lblBeginHour.Text.Substring(0, 5);
            }
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }
}