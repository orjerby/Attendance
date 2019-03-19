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

public partial class Courses : System.Web.UI.Page
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
            cblDepartments.Visible = false;
            cblLecturers.Visible = false;
            lblDepartmentsOfCourse.Visible = false;
            lblLecturersOfCourse.Visible = false;
            btnReplaceDepartmentsOfCourse.Visible = false;
            btnReplaceLecturersOfCourse.Visible = false;
            ViewState["NormalSearch"] = true;
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
        lblEditCourseMessage.Text = "";
        lblReplaceDepartmentsOfCourseMessage.Text = "";
        lblReplaceLecturersOfCourseMessage.Text = "";
        lblAddCourseMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsCourses.SelectCommand = "spGetCoursesBy";
        }
    }

    /// <summary>
    /// Add course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddCourse_Click(object sender, EventArgs e)
    {
        sdsCourses.InsertParameters["CourseName"].DefaultValue = tbCourseNameAdd.Text;
        sdsCourses.Insert();
    }

    /// <summary>
    /// Try to delete the course - show warning messages by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCourses_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        ViewState["CourseID"] = e.Keys["CourseID"].ToString();
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
    /// Refresh the DepartmentsOfCourse and LecturersOfCourse gridviews by the selected course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCourses_SelectedIndexChanged(object sender, EventArgs e)
    {
        cblDepartments.ClearSelection();
        cblLecturers.ClearSelection();
        sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = gvCourses.SelectedValue.ToString();
        sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = gvCourses.SelectedValue.ToString();
        if (ViewState["SelectedRowIndex"] != null && gvCourses.SelectedIndex == int.Parse(ViewState["SelectedRowIndex"].ToString()))
        {
            gvCourses.SelectedIndex = -1;
            sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
            sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
            cblDepartments.Visible = false;
            cblLecturers.Visible = false;
            lblDepartmentsOfCourse.Visible = false;
            lblLecturersOfCourse.Visible = false;
            btnReplaceDepartmentsOfCourse.Visible = false;
            btnReplaceLecturersOfCourse.Visible = false;
        }
        else
        {
            cblDepartments.Visible = true;
            cblLecturers.Visible = true;
            lblDepartmentsOfCourse.Visible = true;
            lblLecturersOfCourse.Visible = true;
            btnReplaceDepartmentsOfCourse.Visible = true;
            btnReplaceLecturersOfCourse.Visible = true;
        }
        ViewState["SelectedRowIndex"] = gvCourses.SelectedIndex;
        cblDepartments.ClearSelection();
        cblLecturers.ClearSelection();
    }

    /// <summary>
    /// Replace departments of the selected course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReplaceDepartmentsOfCourse_Click(object sender, EventArgs e)
    {
        string departmentsIDValues = ";";
        foreach (ListItem item in cblDepartments.Items)
        {
            if (item.Selected)
            {
                departmentsIDValues += item.Value + ";";
            }
        }
        ViewState["ListOfDepartments"] = departmentsIDValues;
        sdsDepartmentsOfCourse.InsertParameters["CourseID"].DefaultValue = gvCourses.SelectedValue == null ? "-1" : gvCourses.SelectedValue.ToString();
        sdsDepartmentsOfCourse.InsertParameters["ListOfDepartments"].DefaultValue = ViewState["ListOfDepartments"].ToString();
        sdsDepartmentsOfCourse.Insert();
    }

    /// <summary>
    /// Replace lecturers of the selected course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReplaceLecturersOfCourse_Click(object sender, EventArgs e)
    {
        string lecturersIDValues = ";";
        foreach (ListItem item in cblLecturers.Items)
        {
            if (item.Selected)
            {
                lecturersIDValues += item.Value + ";";
            }
        }
        ViewState["ListOfLecturers"] = lecturersIDValues;
        sdsLecturersOfCourse.InsertParameters["CourseID"].DefaultValue = gvCourses.SelectedValue == null ? "-1" : gvCourses.SelectedValue.ToString();
        sdsLecturersOfCourse.InsertParameters["ListOfLecturers"].DefaultValue = ViewState["ListOfLecturers"].ToString();
        sdsLecturersOfCourse.Insert();
    }

    /// <summary>
    /// Try to replace the departments of the course - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsDepartmentsOfCourse_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblReplaceDepartmentsOfCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceDepartmentsOfCourseMessage.Text = "הרשומות עודכנו בהצלחה";
            btnReplaceDepartmentsOfCourse.Enabled = true;
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal3();", true);
            lblConfirmMessage3.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }

    /// <summary>
    /// Try to replace the lecturers of the course - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsLecturersOfCourse_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblReplaceLecturersOfCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceLecturersOfCourseMessage.Text = "הרשומות עודכנו בהצלחה";
            btnReplaceLecturersOfCourse.Enabled = true;
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal4();", true);
            lblConfirmMessage4.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }

    /// <summary>
    /// Make the check boxes of departments get auto selected and unselected by the selected course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvDepartmentsOfCourse_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string optionValue = DataBinder.Eval(e.Row.DataItem, "DepartmentID").ToString();
            cblDepartments.Items.FindByValue(optionValue).Selected = true;

            if (ViewState["DefaultDepartments"] == null)
            {
                List<string> values = new List<string>();
                values.Add(optionValue);
                ViewState["DefaultDepartments"] = values;
            }
            else
            {
                List<string> values = (List<string>)ViewState["DefaultDepartments"];
                values.Add(optionValue);
                ViewState["DefaultDepartments"] = values;
            }
        }
    }

    /// <summary>
    /// Make the check boxes of lecturers get auto selected and unselected by the selected course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LecturersOfCourse_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string optionValue = DataBinder.Eval(e.Row.DataItem, "LecturerID").ToString();
            cblLecturers.Items.FindByValue(optionValue).Selected = true;

            if (ViewState["DefaultLecturers"] == null)
            {
                List<string> values = new List<string>();
                values.Add(optionValue);
                ViewState["DefaultLecturers"] = values;
            }
            else
            {
                List<string> values = (List<string>)ViewState["DefaultLecturers"];
                values.Add(optionValue);
                ViewState["DefaultLecturers"] = values;
            }
        }
    }

    /// <summary>
    /// Refresh the Courses gridview after updating course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCourses_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        gvCourses.SelectedIndex = -1;
        sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
        cblDepartments.ClearSelection();
        cblLecturers.ClearSelection();
        cblDepartments.Visible = false;
        cblLecturers.Visible = false;
        lblDepartmentsOfCourse.Visible = false;
        lblLecturersOfCourse.Visible = false;
        btnReplaceDepartmentsOfCourse.Visible = false;
        btnReplaceLecturersOfCourse.Visible = false;
        if (e.AffectedRows > 0)
        {
            lblEditCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCourseMessage.Text = "הקורס עודכן בהצלחה";
        }
        else
        {
            lblEditCourseMessage.ForeColor = System.Drawing.Color.Red;
            lblEditCourseMessage.Text = "הקורס לא עודכן בהצלחה";
        }
    }

    /// <summary>
    /// Refresh the Courses gridview after inserting course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsCourses_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvCourses.SelectedIndex = -1;
        sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
        cblDepartments.ClearSelection();
        cblLecturers.ClearSelection();
        if (e.AffectedRows > 0)
        {
            lblAddCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblAddCourseMessage.Text = "הקורס נוצר בהצלחה";
            tbCourseNameAdd.Text = "";
            gvCourses.EditIndex = -1;
            cblDepartments.Visible = false;
            cblLecturers.Visible = false;
            lblDepartmentsOfCourse.Visible = false;
            lblLecturersOfCourse.Visible = false;
            btnReplaceDepartmentsOfCourse.Visible = false;
            btnReplaceLecturersOfCourse.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblAddCourseMessage.ForeColor = System.Drawing.Color.Red;
            lblAddCourseMessage.Text = "הקורס לא נוצר בהצלחה";
        }
        btnAddCourse.Enabled = true;
    }

    /// <summary>
    /// Delete the course
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        Course course = new Course(int.Parse(ViewState["CourseID"].ToString()));
        int affectedRows = Operations.DeleteCourseSoft(course);
        gvCourses.DataBind();
        gvCourses.SelectedIndex = -1;
        sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
        cblDepartments.ClearSelection();
        cblLecturers.ClearSelection();
        if (affectedRows > 0)
        {
            lblEditCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCourseMessage.Text = "הקורס נמחק בהצלחה";
            cblDepartments.ClearSelection();
            cblLecturers.ClearSelection();
            cblDepartments.Visible = false;
            cblLecturers.Visible = false;
            lblDepartmentsOfCourse.Visible = false;
            lblLecturersOfCourse.Visible = false;
            sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
            sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
            btnReplaceDepartmentsOfCourse.Visible = false;
            btnReplaceLecturersOfCourse.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblEditCourseMessage.ForeColor = System.Drawing.Color.Red;
            lblEditCourseMessage.Text = "הקורס לא נמחק בהצלחה";
        }
    }

    /// <summary>
    /// Delete the course and all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete2_Click(object sender, EventArgs e)
    {
        Course course = new Course(int.Parse(ViewState["CourseID"].ToString()));
        int affectedRows = Operations.DeleteCourseHard(course);
        gvCourses.DataBind();
        gvCourses.SelectedIndex = -1;
        sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
        cblDepartments.ClearSelection();
        cblLecturers.ClearSelection();
        if (affectedRows > 0)
        {
            lblEditCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCourseMessage.Text = "הקורס נמחק בהצלחה";
            cblDepartments.ClearSelection();
            cblLecturers.ClearSelection();
            cblDepartments.Visible = false;
            cblLecturers.Visible = false;
            lblDepartmentsOfCourse.Visible = false;
            lblLecturersOfCourse.Visible = false;
            sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
            sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
            btnReplaceDepartmentsOfCourse.Visible = false;
            btnReplaceLecturersOfCourse.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblEditCourseMessage.ForeColor = System.Drawing.Color.Red;
            lblEditCourseMessage.Text = "הקורס לא נמחק בהצלחה";
        }
    }

    /// <summary>
    /// Replace the departments of the course and delete all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmReplace_Click(object sender, EventArgs e)
    {
        Course course = new Course(gvCourses.SelectedValue == null ? -1 : int.Parse(gvCourses.SelectedValue.ToString()));
        int affectedRows = Operations.ReplaceDepartmentsOfCourse(course, ViewState["ListOfDepartments"].ToString());
        cblDepartments.ClearSelection();
        gvDepartmentsOfCourse.DataBind();
        if (affectedRows > 0)
        {
            lblReplaceDepartmentsOfCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceDepartmentsOfCourseMessage.Text = "הרשומות עודכנו בהצלחה";
        }
        else
        {
            lblReplaceDepartmentsOfCourseMessage.ForeColor = System.Drawing.Color.Red;
            lblReplaceDepartmentsOfCourseMessage.Text = "הרשומות לא עודכנו בהצלחה";
        }
        btnReplaceDepartmentsOfCourse.Enabled = true;
    }

    protected void btnCancelReplace_Click(object sender, EventArgs e)
    {
        cblDepartments.ClearSelection();
        List<string> values = (List<string>)ViewState["DefaultDepartments"];
        foreach (var value in values)
        {
            cblDepartments.Items.FindByValue(value).Selected = true;
        }
    }
    
    /// <summary>
    /// Replace the lecturers of the course and all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmReplace2_Click(object sender, EventArgs e)
    {
        Course course = new Course(int.Parse(gvCourses.SelectedValue == null ? "-1" : gvCourses.SelectedValue.ToString()));
        int affectedRows = Operations.ReplaceLecturersOfCourse(course, ViewState["ListOfLecturers"].ToString());
        cblLecturers.ClearSelection();
        gvLecturersOfCourse.DataBind();
        if (affectedRows > 0)
        {
            lblReplaceLecturersOfCourseMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceLecturersOfCourseMessage.Text = "הרשומות עודכנו בהצלחה";
        }
        else
        {
            lblReplaceLecturersOfCourseMessage.ForeColor = System.Drawing.Color.Red;
            lblReplaceLecturersOfCourseMessage.Text = "הרשומות לא עודכנו בהצלחה";
        }
        btnReplaceLecturersOfCourse.Enabled = true;
    }

    protected void btnCancelReplace2_Click(object sender, EventArgs e)
    {
        cblLecturers.ClearSelection();
        List<string> values = (List<string>)ViewState["DefaultLecturers"];
        foreach (var value in values)
        {
            cblLecturers.Items.FindByValue(value).Selected = true;
        }
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchCourses_Click(object sender, EventArgs e)
    {
        if (tbCourseNameSearch.Text == "")
        {
            sdsCourses.SelectCommand = "spGetCourses";
            sdsCourses.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsCourses.SelectCommand = "spGetCoursesBy";
            sdsCourses.SelectParameters.Clear();
            Parameter courseName = new Parameter("CourseName", DbType.String, "");
            courseName.ConvertEmptyStringToNull = false;
            sdsCourses.SelectParameters.Add(courseName);
            sdsCourses.SelectParameters["CourseName"].DefaultValue = tbCourseNameSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["CourseNameSearch"] = tbCourseNameSearch.Text;
        }
        gvCourses.EditIndex = -1;
        gvCourses.SelectedIndex = -1;
        cblDepartments.ClearSelection();
        cblLecturers.ClearSelection();
        sdsDepartmentsOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        sdsLecturersOfCourse.SelectParameters["CourseID"].DefaultValue = "-1";
        cblDepartments.Visible = false;
        cblLecturers.Visible = false;
        lblDepartmentsOfCourse.Visible = false;
        lblLecturersOfCourse.Visible = false;
        btnReplaceDepartmentsOfCourse.Visible = false;
        btnReplaceLecturersOfCourse.Visible = false;
        ViewState["SelectedRowIndex"] = null;
    }

    protected void gvCourses_PageIndexChanged(object sender, EventArgs e)
    {
        gvCourses.SelectedIndex = -1;
    }
}