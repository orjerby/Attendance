using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Lectures : System.Web.UI.Page
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
        lblEditLectureMessage.Text = "";
        lblEditStudentLectureMessage.Text = "";
        lblStudentsInLecture.Visible = false;
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsLectures.SelectCommand = "spGetLecturesBy";
        }
    }

    /// <summary>
    /// Manually handle the row commands of gvStudentsInLectures
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvStudentsInLectures_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteRow")
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Lecture lecture = new Lecture(int.Parse(arg[0]));
            Student student = new Student(int.Parse(arg[1]));
            StudentsInLecture studentsInLecture = new StudentsInLecture(lecture, student);
            ViewState["StudentInLecture"] = studentsInLecture;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal();", true);
        }
        else if (e.CommandName == "EditRow")
        {
            int rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            gvStudentsInLectures.EditIndex = rowIndex;
        }
        else if (e.CommandName == "UpdateRow")
        {
            int rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Lecture lecture = new Lecture(int.Parse(arg[0]));
            Student student = new Student(int.Parse(arg[1]));
            Status status = new Status(int.Parse(((DropDownList)gvStudentsInLectures.Rows[rowIndex].FindControl("ddlStatusesEdit")).SelectedValue));
            StudentsInLecture studentsInLecture = new StudentsInLecture(lecture, student, status);
            int affectedRows = Operations.UpdateStudentInLecture(studentsInLecture);
            gvStudentsInLectures.EditIndex = -1;
            if (affectedRows > 0)
            {
                lblEditStudentLectureMessage.ForeColor = System.Drawing.Color.Green;
                lblEditStudentLectureMessage.Text = "הרשומה עודכנה בהצלחה";
            }
        }
        else if (e.CommandName == "CancelUpdate")
        {
            gvStudentsInLectures.EditIndex = -1;
        }
    }

    /// <summary>
    /// Manually handle the row commands of gvLectures
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvLectures_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowIndex = -1;
        if (e.CommandName == "EditRow")
        {
            rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            string courseID = gvLectures.DataKeys[rowIndex].Values["CourseID"].ToString();
            sdsLecturersEdit.SelectParameters["CourseID"].DefaultValue = courseID;
            gvLectures.EditIndex = rowIndex;
        }
        else if (e.CommandName == "UpdateRow")
        {
            rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            string[] arg = new string[4];
            arg = e.CommandArgument.ToString().Split(';');
            Class class1 = new Class(int.Parse(((DropDownList)gvLectures.Rows[rowIndex].FindControl("ddlClassesEdit")).SelectedValue));
            Course course = new Course(int.Parse(arg[1]));
            Department department = new Department(int.Parse(arg[2]));
            Cycle cycle = new Cycle(int.Parse(arg[3]));
            Lecturer lecturer = new Lecturer(int.Parse(((DropDownList)gvLectures.Rows[rowIndex].FindControl("ddlLecturersEdit")).SelectedValue));
            string beginHour = ((TextBox)gvLectures.Rows[rowIndex].FindControl("tbBeginHourEdit")).Text;
            string endHour = ((TextBox)gvLectures.Rows[rowIndex].FindControl("tbEndHourEdit")).Text;
            DateTime lectureDate = DateTime.ParseExact(((TextBox)gvLectures.Rows[rowIndex].FindControl("tbLectureDateEdit")).Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            bool isCanceled = ((CheckBox)gvLectures.Rows[rowIndex].FindControl("chkIsCanceled")).Checked;
            Lecture lecture = new Lecture(int.Parse(arg[0]), course, department, cycle, lecturer, class1, lectureDate, beginHour, endHour, isCanceled);
            string error = Operations.UpdateLectureTry(lecture);
            if (error == null)
            {
                lblEditLectureMessage.ForeColor = System.Drawing.Color.Green;
                lblEditLectureMessage.Text = "ההרצאה עודכנה בהצלחה";
            }
            else
            {
                lblEditLectureMessage.ForeColor = System.Drawing.Color.Red;
                lblEditLectureMessage.Text = error;
            }
            gvLectures.EditIndex = -1;
            gvLectures.SelectedIndex = -1;
            sdsStudentsInLectures.SelectParameters["LectureID"].DefaultValue = "-1";
            lblStudentsInLecture.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else if (e.CommandName == "SelectRow")
        {
            rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            if (ViewState["SelectedRowIndex"] != null && rowIndex == int.Parse(ViewState["SelectedRowIndex"].ToString()))
            {
                gvLectures.SelectedIndex = -1;
                sdsStudentsInLectures.SelectParameters["LectureID"].DefaultValue = "-1";
                lblStudentsInLecture.Visible = false;
                ViewState["SelectedRowIndex"] = null;
            }
            else
            {
                gvLectures.SelectRow(rowIndex);
                string lectureID = gvLectures.DataKeys[rowIndex].Values["LectureID"].ToString();
                sdsStudentsInLectures.SelectParameters["LectureID"].DefaultValue = lectureID;
                lblStudentsInLecture.Visible = true;
                ViewState["SelectedRowIndex"] = rowIndex;
            }
            gvStudentsInLectures.EditIndex = -1;
        }
        else if (e.CommandName == "DeleteRow")
        {
            rowIndex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            int lectureID = int.Parse(e.CommandArgument.ToString());
            Lecture lecture = new Lecture(lectureID);
            ViewState["Lecture"] = lecture;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal2();", true);
            gvLectures.SelectedIndex = -1;
            sdsStudentsInLectures.SelectParameters["LectureID"].DefaultValue = "-1";
            lblStudentsInLecture.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else if (e.CommandName == "CancelUpdate")
        {
            gvLectures.EditIndex = -1;
        }
    }

    /// <summary>
    /// Go to AddLectures page
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnToAddLecturesPage_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/AddLectures.aspx");
    }

    protected void gvLectures_PageIndexChanged(object sender, EventArgs e)
    {
        gvLectures.SelectedIndex = -1;
        sdsStudentsInLectures.SelectParameters["LectureID"].DefaultValue = "-1";
        lblStudentsInLecture.Visible = false;
        ViewState["SelectedRowIndex"] = null;
    }


    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        int affectedRows = Operations.DeleteStudentInLecture((StudentsInLecture)ViewState["StudentInLecture"]);
        gvStudentsInLectures.DataBind();
        if (affectedRows > 0)
        {
            lblEditStudentLectureMessage.ForeColor = System.Drawing.Color.Green;
            lblEditStudentLectureMessage.Text = "הרשומה נמחקה בהצלחה";
        }
        else
        {
            lblEditStudentLectureMessage.ForeColor = System.Drawing.Color.Red;
            lblEditStudentLectureMessage.Text = "הרשומה לא נמחקה בהצלחה";
        }
    }

    protected void btnConfirmDelete2_Click(object sender, EventArgs e)
    {
        int affectedRows = Operations.DeleteLecture((Lecture)ViewState["Lecture"]);
        gvLectures.DataBind();
        if (affectedRows > 0)
        {
            lblEditLectureMessage.ForeColor = System.Drawing.Color.Green;
            lblEditLectureMessage.Text = "ההרצאה נמחקה בהצלחה";
        }
        else
        {
            lblEditLectureMessage.ForeColor = System.Drawing.Color.Red;
            lblEditLectureMessage.Text = "ההרצאה לא נמחקה בהצלחה";
        }
    }


    protected void gvLectures_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox tbLectureDateEdit = e.Row.FindControl("tbLectureDateEdit") as TextBox;
            TextBox tbBeginHourEdit = e.Row.FindControl("tbBeginHourEdit") as TextBox;
            TextBox tbEndHourEdit = e.Row.FindControl("tbEndHourEdit") as TextBox;
            Label lblEndHour = e.Row.FindControl("lblEndHour") as Label;
            Label lblBeginHour = e.Row.FindControl("lblBeginHour") as Label;
            if (tbLectureDateEdit != null)
            {
                tbLectureDateEdit.Attributes.Add("readonly", "readonly");
            }
            if (tbBeginHourEdit != null)
            {
                tbBeginHourEdit.Attributes.Add("readonly", "readonly");
            }
            if (tbEndHourEdit != null)
            {
                tbEndHourEdit.Attributes.Add("readonly", "readonly");
                tbEndHourEdit.Text = tbEndHourEdit.Text.Substring(0, 5);
            }
            if (tbBeginHourEdit != null)
            {
                tbBeginHourEdit.Attributes.Add("readonly", "readonly");
                tbBeginHourEdit.Text = tbBeginHourEdit.Text.Substring(0, 5);
            }
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


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (ddlDepartmentsSearch.SelectedValue == "0" && ddlCyclesSearch.SelectedValue == "0" && ddlCoursesSearch.SelectedValue == "0" && ddlLecturersSearch.SelectedValue == "0")
        {
            sdsLectures.SelectCommand = "spGetLectures";
            sdsLectures.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsLectures.SelectCommand = "spGetLecturesBy";
            sdsLectures.SelectParameters.Clear();
            Parameter departmentID = new Parameter("DepartmentID", DbType.Int32, "0");
            Parameter cycleID = new Parameter("CycleID", DbType.Int32, "0");
            Parameter courseID = new Parameter("CourseID", DbType.Int32, "0");
            Parameter lecturerID = new Parameter("LecturerID", DbType.Int32, "0");
            departmentID.ConvertEmptyStringToNull = false;
            cycleID.ConvertEmptyStringToNull = false;
            courseID.ConvertEmptyStringToNull = false;
            lecturerID.ConvertEmptyStringToNull = false;
            sdsLectures.SelectParameters.Add(departmentID);
            sdsLectures.SelectParameters.Add(cycleID);
            sdsLectures.SelectParameters.Add(courseID);
            sdsLectures.SelectParameters.Add(lecturerID);
            sdsLectures.SelectParameters["DepartmentID"].DefaultValue = ddlDepartmentsSearch.SelectedValue;
            sdsLectures.SelectParameters["CycleID"].DefaultValue = ddlCyclesSearch.SelectedValue;
            sdsLectures.SelectParameters["CourseID"].DefaultValue = ddlCoursesSearch.SelectedValue;
            sdsLectures.SelectParameters["LecturerID"].DefaultValue = ddlLecturersSearch.SelectedValue;
            ViewState["NormalSearch"] = false;
            ViewState["DepartmentSearch"] = ddlDepartmentsSearch.SelectedValue;
            ViewState["CycleSearch"] = ddlCyclesSearch.SelectedValue;
            ViewState["CourseSearch"] = ddlCoursesSearch.SelectedValue;
            ViewState["LecturerSearch"] = ddlLecturersSearch.SelectedValue;
        }
        gvLectures.EditIndex = -1;
        gvLectures.SelectedIndex = -1;
        sdsStudentsInLectures.SelectParameters["LectureID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
    }
    
}