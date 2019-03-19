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

public partial class Cycles : System.Web.UI.Page
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
            lblDepartmentsOfCycle.Visible = false;
            btnReplaceDepartmentsOfCycle.Visible = false;
            ViewState["NormalSearch"] = true;
            int waitingFormsCount = Operations.GetNumberOfWaitingForms();
            if (waitingFormsCount > 0)
            {
                lnkbtnForms.ForeColor = System.Drawing.Color.Red;
            }
        }
        lblEditCycleMessage.Text = "";
        lblReplaceDepartmentsOfCycleMessage.Text = "";
        lblAddCycleMessage.Text = "";
        if (Convert.ToBoolean(ViewState["NormalSearch"]) == false)
        {
            sdsCycles.SelectCommand = "spGetCyclesBy";
        }
    }

    /// <summary>
    /// Add cycle
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddCycle_Click(object sender, EventArgs e)
    {
        sdsCycles.InsertParameters["CycleName"].DefaultValue = tbCycleNameAdd.Text;
        sdsCycles.InsertParameters["Year"].DefaultValue = tbCycleYearAdd.Text;
        sdsCycles.Insert();
    }

    /// <summary>
    /// Try to delete the cycle - show warning messages by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCycles_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        ViewState["CycleID"] = e.Keys["CycleID"].ToString();
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
    /// Refresh the DepartmentsOfCycle gridview by the selected cycle
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCycles_SelectedIndexChanged(object sender, EventArgs e)
    {
        cblDepartments.ClearSelection();
        sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = gvCycles.SelectedValue.ToString();
        if (ViewState["SelectedRowIndex"] != null && gvCycles.SelectedIndex == int.Parse(ViewState["SelectedRowIndex"].ToString()))
        {
            gvCycles.SelectedIndex = -1;
            sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
            cblDepartments.Visible = false;
            lblDepartmentsOfCycle.Visible = false;
            btnReplaceDepartmentsOfCycle.Visible = false;
        }
        else
        {
            cblDepartments.Visible = true;
            lblDepartmentsOfCycle.Visible = true;
            btnReplaceDepartmentsOfCycle.Visible = true;
        }
        ViewState["SelectedRowIndex"] = gvCycles.SelectedIndex;
        cblDepartments.ClearSelection();
    }

    /// <summary>
    /// Replace departments of the selected cycle
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReplaceDepartmentsOfCycle_Click(object sender, EventArgs e)
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
        sdsDepartmentsOfCycle.InsertParameters["CycleID"].DefaultValue = gvCycles.SelectedValue == null ? "-1" : gvCycles.SelectedValue.ToString();
        sdsDepartmentsOfCycle.InsertParameters["ListOfDepartments"].DefaultValue = ViewState["ListOfDepartments"].ToString();
        sdsDepartmentsOfCycle.Insert();
    }

    /// <summary>
    /// Try to replace the departments of the cycle - show warning message by the situation
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsDepartmentsOfCycle_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            lblReplaceDepartmentsOfCycleMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceDepartmentsOfCycleMessage.Text = "הרשומות עודכנו בהצלחה";
            btnReplaceDepartmentsOfCycle.Enabled = true;
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "pop", "openModal3();", true);
            lblConfirmMessage3.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }



    /// <summary>
    /// Make the check boxes of departments get auto selected and unselected by the selected cycle
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvDepartmentsOfCycle_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string optionValue = DataBinder.Eval(e.Row.DataItem, "DepartmentID").ToString(); //this can return value from Label
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
    /// Refresh the Cycles gridview after updating cycle
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCycles_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        gvCycles.SelectedIndex = -1;
        cblDepartments.ClearSelection();
        ViewState["SelectedRowIndex"] = null;
        cblDepartments.Visible = false;
        lblDepartmentsOfCycle.Visible = false;
        btnReplaceDepartmentsOfCycle.Visible = false;
        sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
        if (e.AffectedRows > 0)
        {
            lblEditCycleMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCycleMessage.Text = "המחזור עודכן בהצלחה";
        }
        else
        {
            lblEditCycleMessage.ForeColor = System.Drawing.Color.Red;
            lblEditCycleMessage.Text = "המחזור לא עודכן בהצלחה";
        }
    }

    /// <summary>
    /// Refresh the Cycles gridview after inserting cycle
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sdsCycles_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvCycles.SelectedIndex = -1;
        cblDepartments.ClearSelection();
        ViewState["SelectedRowIndex"] = null;
        sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
        if (e.AffectedRows > 0)
        {
            lblAddCycleMessage.ForeColor = System.Drawing.Color.Green;
            lblAddCycleMessage.Text = "המחזור נוצר בהצלחה";
            tbCycleNameAdd.Text = "";
            tbCycleYearAdd.Text = "";
            gvCycles.EditIndex = -1;
            cblDepartments.Visible = false;
            lblDepartmentsOfCycle.Visible = false;
            btnReplaceDepartmentsOfCycle.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblAddCycleMessage.ForeColor = System.Drawing.Color.Red;
            lblAddCycleMessage.Text = "המחזור לא נוצר בהצלחה";
        }
        btnAddCycle.Enabled = true;
    }

    /// <summary>
    /// Delete cycle
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        Cycle cycle = new Cycle(int.Parse(ViewState["CycleID"].ToString()));
        int affectedRows = Operations.DeleteCycleSoft(cycle);
        gvCycles.DataBind();
        gvCycles.SelectedIndex = -1;
        sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
        cblDepartments.ClearSelection();
        if (affectedRows > 0)
        {
            lblEditCycleMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCycleMessage.Text = "המחזור נמחק בהצלחה";
            sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
            cblDepartments.ClearSelection();
            cblDepartments.Visible = false;
            lblDepartmentsOfCycle.Visible = false;
            btnReplaceDepartmentsOfCycle.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblEditCycleMessage.ForeColor = System.Drawing.Color.Red;
            lblEditCycleMessage.Text = "המחזור לא נמחק בהצלחה";
        }
    }

    /// <summary>
    /// Delete the cycle and all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmDelete2_Click(object sender, EventArgs e)
    {
        Cycle cycle = new Cycle(int.Parse(ViewState["CycleID"].ToString()));
        int affectedRows = Operations.DeleteCycleHard(cycle);
        gvCycles.DataBind();
        gvCycles.SelectedIndex = -1;
        sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
        ViewState["SelectedRowIndex"] = null;
        cblDepartments.ClearSelection();
        if (affectedRows > 0)
        {
            lblEditCycleMessage.ForeColor = System.Drawing.Color.Green;
            lblEditCycleMessage.Text = "המחזור נמחק בהצלחה";
            sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
            cblDepartments.ClearSelection();
            cblDepartments.Visible = false;
            lblDepartmentsOfCycle.Visible = false;
            btnReplaceDepartmentsOfCycle.Visible = false;
            ViewState["SelectedRowIndex"] = null;
        }
        else
        {
            lblEditCycleMessage.ForeColor = System.Drawing.Color.Red;
            lblEditCycleMessage.Text = "המחזור לא נמחק בהצלחה";
        }
    }

    /// <summary>
    /// Replace the departments of the course and delete all the lectures connected to it
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmReplace_Click(object sender, EventArgs e)
    {
        Cycle cycle = new Cycle(gvCycles.SelectedValue == null ? -1 : int.Parse(gvCycles.SelectedValue.ToString()));
        int affectedRows = Operations.ReplaceDepartmentsOfCycle(cycle, ViewState["ListOfDepartments"].ToString());
        cblDepartments.ClearSelection();
        gvDepartmentsOfCycle.DataBind();
        if (affectedRows > 0)
        {
            lblReplaceDepartmentsOfCycleMessage.ForeColor = System.Drawing.Color.Green;
            lblReplaceDepartmentsOfCycleMessage.Text = "הרשומות עודכנו בהצלחה";
        }
        else
        {
            lblReplaceDepartmentsOfCycleMessage.ForeColor = System.Drawing.Color.Red;
            lblReplaceDepartmentsOfCycleMessage.Text = "הרשומות לא עודכנו בהצלחה";
        }
        btnReplaceDepartmentsOfCycle.Enabled = true;
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
    
    protected void lnkbtnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/Login.aspx");
    }

    protected void btnSearchCycles_Click(object sender, EventArgs e)
    {
        if (tbCycleNameSearch.Text == "" && tbCycleYearSearch.Text == "")
        {
            sdsCycles.SelectCommand = "spGetCycles";
            sdsCycles.SelectParameters.Clear();
            ViewState["NormalSearch"] = true;
        }
        else
        {
            sdsCycles.SelectCommand = "spGetCyclesBy";
            sdsCycles.SelectParameters.Clear();
            Parameter cycleName = new Parameter("CycleName", DbType.String, "");
            Parameter year = new Parameter("Year", DbType.String, "");
            cycleName.ConvertEmptyStringToNull = false;
            year.ConvertEmptyStringToNull = false;
            sdsCycles.SelectParameters.Add(cycleName);
            sdsCycles.SelectParameters.Add(year);
            sdsCycles.SelectParameters["CycleName"].DefaultValue = tbCycleNameSearch.Text;
            sdsCycles.SelectParameters["Year"].DefaultValue = tbCycleYearSearch.Text == "" ? "0" : tbCycleYearSearch.Text;
            ViewState["NormalSearch"] = false;
            ViewState["CycleNameSearch"] = tbCycleNameSearch.Text;
            ViewState["CycleYearSearch"] = tbCycleYearSearch.Text;
        }
        gvCycles.EditIndex = -1;
        gvCycles.SelectedIndex = -1;
        sdsDepartmentsOfCycle.SelectParameters["CycleID"].DefaultValue = "-1";
        cblDepartments.ClearSelection();
        cblDepartments.Visible = false;
        lblDepartmentsOfCycle.Visible = false;
        btnReplaceDepartmentsOfCycle.Visible = false;
        ViewState["SelectedRowIndex"] = null;
    }


    protected void gvCycles_PageIndexChanged(object sender, EventArgs e)
    {
        gvCycles.SelectedIndex = -1;
    }
}