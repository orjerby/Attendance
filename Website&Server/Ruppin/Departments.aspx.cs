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

public partial class Departments : System.Web.UI.Page
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
            cblCycles.Visible = false;
            lblCoursesOfDepartment.Visible = false;
            lblCyclesOfDepartment.Visible = false;
            btnReplaceCoursesOfDepartment.Visible = false;
            btnReplaceCyclesOfDepartment.Visible = false;
            ViewState["NormalSearch"] = true;
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
        lblEditDepartmentMessage.Text = "";
        lblReplaceCoursesOfDepartmentMessage.Text = "";
        lblReplaceCyclesOfDepartmentMessage.Text = "";
        lblAddDepartmentMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsDepartments.SelectCommand = "spGetDepartmentsBy";
        }
    }

    /// <summary>
    /// Add department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddDepartment_Click(object sender, EventArgs e)
    {
        sdsDepartments.InsertParameters["DepartmentName"].DefaultValue = tbDepartmentNameAdd.Text;
        sdsDepartments.Insert();
    }

    /// <summary>
    /// Try to delete the department - show warning messages by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvDepartments_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        ViewState["DepartmentID"] = e.Keys["DepartmentID"].ToString();
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
    /// Refresh the CoursesOfDepartment and CyclesOfDepartment gridviews by the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvDepartments_SelectedIndexChanged(object sender, EventArgs e)
    {
        cblCourses.ClearSelection();
        cblCycles.ClearSelection();
        sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = gvDepartments.SelectedValue.ToString();
        sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = gvDepartments.SelectedValue.ToString();
        if (ViewState["SelectedRowIndex"] != null && gvDepartments.SelectedIndex == int.Parse(ViewState["SelectedRowIndex"].ToString()))
        {
            gvDepartments.SelectedIndex = -1;
            sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
            sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
            cblCourses.Visible = false;
            cblCycles.Visible = false;
            lblCoursesOfDepartment.Visible = false;
            lblCyclesOfDepartment.Visible = false;
            btnReplaceCoursesOfDepartment.Visible = false;
            btnReplaceCyclesOfDepartment.Visible = false;
        }
        else
        {
            cblCourses.Visible = true;
            cblCycles.Visible = true;
            lblCoursesOfDepartment.Visible = true;
            lblCyclesOfDepartment.Visible = true;
            btnReplaceCoursesOfDepartment.Visible = true;
            btnReplaceCyclesOfDepartment.Visible = true;
        }
        ViewState["SelectedRowIndex"] = gvDepartments.SelectedIndex;
        cblCourses.ClearSelection();
        cblCycles.ClearSelection();
    }

    /// <summary>
    /// Replace courses of the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReplaceCoursesOfDepartment_Click(object sender, EventArgs e)
    {
        string coursesIDValues = ";";
        foreach (ListItem item in cblCourses.Items)
        {
            if (item.Selected)
            {
                coursesIDValues += item.Value + ";";
            }
        }
        ViewState["ListOfCourses"] = coursesIDValues;
        sdsCoursesOfDepartment.InsertParameters["DepartmentID"].DefaultValue = gvDepartments.SelectedValue == null ? "-1" : gvDepartments.SelectedValue.ToString();
        sdsCoursesOfDepartment.InsertParameters["ListOfCourses"].DefaultValue = ViewState["ListOfCourses"].ToString();
        sdsCoursesOfDepartment.Insert();
    }

    /// <summary>
    /// Replace cycles of the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReplaceCyclesOfDepartment_Click(object sender, EventArgs e)
    {
        string cyclesIDValues = ";";
        foreach (ListItem item in cblCycles.Items)
        {
            if (item.Selected)
            {
                cyclesIDValues += item.Value + ";";
            }
        }
        ViewState["ListOfCycles"] = cyclesIDValues;
        sdsCyclesOfDepartment.InsertParameters["DepartmentID"].DefaultValue = gvDepartments.SelectedValue == null ? "-1" : gvDepartments.SelectedValue.ToString();
        sdsCyclesOfDepartment.InsertParameters["ListOfCycles"].DefaultValue = ViewState["ListOfCycles"].ToString();
        sdsCyclesOfDepartment.Insert();
    }

    /// <summary>
    /// Try to replace the courses of the department - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsCoursesOfDepartment_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblReplaceCoursesOfDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceCoursesOfDepartmentMessage.Text = "הרשומות עודכנו בהצלחה";
            btnReplaceCoursesOfDepartment.Enabled = true;
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal3();", true);
            lblConfirmMessage3.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }


    /// <summary>
    /// Try to replace the cycles of the department - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsCyclesOfDepartment_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblReplaceCyclesOfDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceCyclesOfDepartmentMessage.Text = "הרשומות עודכנו בהצלחה";
            btnReplaceCyclesOfDepartment.Enabled = true;
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal4();", true);
            lblConfirmMessage4.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }


    /// <summary>
    /// Make the check boxes of courses get auto selected and unselected by the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCoursesOfDepartment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //List<string> values = new List<string>();
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
    /// Make the check boxes of cycles get auto selected and unselected by the selected department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCyclesOfDepartment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string optionValue = DataBinder.Eval(e.Row.DataItem, "CycleID").ToString();
            cblCycles.Items.FindByValue(optionValue).Selected = true;

            if (ViewState["DefaultCycles"] == null)
            {
                List<string> values = new List<string>();
                values.Add(optionValue);
                ViewState["DefaultCycles"] = values;
            }
            else
            {
                List<string> values = (List<string>)ViewState["DefaultCycles"];
                values.Add(optionValue);
                ViewState["DefaultCycles"] = values;
            }
        }
    }

    /// <summary>
    /// Refresh the Departments gridview after updating department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvDepartments_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        gvDepartments.SelectedIndex = -1;
        ViewState["SelectedRowIndex"] = null;
        sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        cblCourses.ClearSelection();
        cblCycles.ClearSelection();
        cblCourses.Visible = false;
        cblCycles.Visible = false;
        lblCoursesOfDepartment.Visible = false;
        lblCyclesOfDepartment.Visible = false;
        btnReplaceCoursesOfDepartment.Visible = false;
        btnReplaceCyclesOfDepartment.Visible = false;
        if (e.AffectedRows > 0)
        {
            lblEditDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblEditDepartmentMessage.Text = "המגמה עודכנה בהצלחה";
        }
        else
        {
            lblEditDepartmentMessage.ForeColor = System.Drawing.Color.Red;
            lblEditDepartmentMessage.Text = "המגמה לא עודכנה בהצלחה";
        }
    }

    /// <summary>
    /// Refresh the Departments gridview after inserting department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsDepartments_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvDepartments.SelectedIndex = -1;
        ViewState["SelectedRowIndex"] = null;
        sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        cblCourses.ClearSelection();
        cblCycles.ClearSelection();
        if (e.AffectedRows > 0)
        {
            lblAddDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblAddDepartmentMessage.Text = "המגמה נוצרה בהצלחה";
            tbDepartmentNameAdd.Text = "";
            gvDepartments.EditIndex = -1;
            cblCourses.Visible = false;
            cblCycles.Visible = false;
            lblCoursesOfDepartment.Visible = false;
            lblCyclesOfDepartment.Visible = false;
            btnReplaceCoursesOfDepartment.Visible = false;
            btnReplaceCyclesOfDepartment.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblAddDepartmentMessage.ForeColor = System.Drawing.Color.Red;
            lblAddDepartmentMessage.Text = "המגמה לא נוצרה בהצלחה";
        }
        btnAddDepartment.Enabled = true;
    }

    /// <summary>
    /// Delete department
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        Department department = new Department(int.Parse(ViewState["DepartmentID"].ToString()));
        int affectedRows = Operations.DeleteDepartmentSoft(department);
        gvDepartments.DataBind();
        gvDepartments.SelectedIndex = -1;
        ViewState["SelectedRowIndex"] = null;
        sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        cblCourses.ClearSelection();
        cblCycles.ClearSelection();
        if (affectedRows > 0)
        {
            lblEditDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblEditDepartmentMessage.Text = "המגמה נמחקה בהצלחה";
            cblCourses.ClearSelection();
            cblCycles.ClearSelection();
            cblCourses.Visible = false;
            cblCycles.Visible = false;
            lblCoursesOfDepartment.Visible = false;
            lblCyclesOfDepartment.Visible = false;
            sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
            sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
            btnReplaceCoursesOfDepartment.Visible = false;
            btnReplaceCyclesOfDepartment.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblEditDepartmentMessage.ForeColor = System.Drawing.Color.Red;
            lblEditDepartmentMessage.Text = "המגמה לא נמחקה בהצלחה";
        }
    }

    /// <summary>
    /// Delete the department and all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete2_Click(object sender, EventArgs e)
    {
        Department department = new Department(int.Parse(ViewState["DepartmentID"].ToString()));
        int affectedRows = Operations.DeleteDepartmentHard(department);
        gvDepartments.DataBind();
        gvDepartments.SelectedIndex = -1;
        ViewState["SelectedRowIndex"] = null;
        sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        cblCourses.ClearSelection();
        cblCycles.ClearSelection();
        if (affectedRows > 0)
        {
            lblEditDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblEditDepartmentMessage.Text = "המגמה נמחקה בהצלחה";
            cblCourses.ClearSelection();
            cblCycles.ClearSelection();
            cblCourses.Visible = false;
            cblCycles.Visible = false;
            lblCoursesOfDepartment.Visible = false;
            lblCyclesOfDepartment.Visible = false;
            sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
            sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
            btnReplaceCoursesOfDepartment.Visible = false;
            btnReplaceCyclesOfDepartment.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblEditDepartmentMessage.ForeColor = System.Drawing.Color.Red;
            lblEditDepartmentMessage.Text = "המגמה לא נמחקה בהצלחה";
        }
    }

    /// <summary>
    /// Replace the courses of the department and delete all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmReplace_Click(object sender, EventArgs e)
    {
        Department department = new Department(gvDepartments.SelectedValue == null ? -1 : int.Parse(gvDepartments.SelectedValue.ToString()));
        int affectedRows = Operations.ReplaceCoursesOfDepartment(ViewState["ListOfCourses"].ToString(), department);
        cblCourses.ClearSelection();
        gvCoursesOfDepartment.DataBind();
        if (affectedRows > 0)
        {
            lblReplaceCoursesOfDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceCoursesOfDepartmentMessage.Text = "הרשומות עודכנו בהצלחה";
        }
        else
        {
            lblReplaceCoursesOfDepartmentMessage.ForeColor = System.Drawing.Color.Red;
            lblReplaceCoursesOfDepartmentMessage.Text = "הרשומות לא עודכנו בהצלחה";
        }
        btnReplaceCoursesOfDepartment.Enabled = true;
    }

    /// <summary>
    /// Replace the cycles of the department and delete all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmReplace2_Click(object sender, EventArgs e)
    {
        Department department = new Department(gvDepartments.SelectedValue == null ? -1 : int.Parse(gvDepartments.SelectedValue.ToString()));
        int affectedRows = Operations.ReplaceCyclesOfDepartment(ViewState["ListOfCycles"].ToString(), department);
        cblCycles.ClearSelection();
        gvCyclesOfDepartment.DataBind();
        if (affectedRows > 0)
        {
            lblReplaceCyclesOfDepartmentMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceCyclesOfDepartmentMessage.Text = "הרשומות עודכנו בהצלחה";
        }
        else
        {
            lblReplaceCyclesOfDepartmentMessage.ForeColor = System.Drawing.Color.Red;
            lblReplaceCyclesOfDepartmentMessage.Text = "הרשומות לא עודכנו בהצלחה";
        }
        btnReplaceCyclesOfDepartment.Enabled = true;
    }

    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchDepartments_Click(object sender, EventArgs e)
    {
        if (tbDepartmentNameSearch.Text == "")
        {
            sdsDepartments.SelectCommand = "spGetDepartments";
            sdsDepartments.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsDepartments.SelectCommand = "spGetDepartmentsBy";
            sdsDepartments.SelectParameters.Clear();
            Parameter departmentName = new Parameter("DepartmentName", DbType.String, "");
            departmentName.ConvertEmptyStringToNull = false;
            sdsDepartments.SelectParameters.Add(departmentName);
            sdsDepartments.SelectParameters["DepartmentName"].DefaultValue = tbDepartmentNameSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["DepartmentNameSearch"] = tbDepartmentNameSearch.Text;
        }
        gvDepartments.EditIndex = -1;
        gvDepartments.SelectedIndex = -1;
        cblCourses.ClearSelection();
        cblCycles.ClearSelection();
        sdsCyclesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        sdsCoursesOfDepartment.SelectParameters["DepartmentID"].DefaultValue = "-1";
        cblCourses.Visible = false;
        cblCycles.Visible = false;
        lblCoursesOfDepartment.Visible = false;
        lblCyclesOfDepartment.Visible = false;
        btnReplaceCoursesOfDepartment.Visible = false;
        btnReplaceCyclesOfDepartment.Visible = false;
        ViewState["SelectedRowIndex"] = null;
    }

    protected void gvDepartments_PageIndexChanged(object sender, EventArgs e)
    {
        gvDepartments.SelectedIndex = -1;
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

    protected void btnCancelReplace2_Click(object sender, EventArgs e)
    {
        cblCycles.ClearSelection();
        List<string> values = (List<string>)ViewState["DefaultCycles"];
        foreach (var value in values)
        {
            cblCycles.Items.FindByValue(value).Selected = true;
        }
    }
    
}
