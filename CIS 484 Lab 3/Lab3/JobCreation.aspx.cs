using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Lab3
{
    public partial class JobCreation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("LogIn.aspx");
            }

            if (Session["UserType"].ToString().Equals("Member") || Session["UserType"].ToString().Equals("Admin"))
            {
            }
            else
            {
                Session["Incorrect Account Type"] = "You must be a Member to view that Page! Students are not allowed to view";
                Response.Redirect("CareerApply.aspx");
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            string sqlQuery = "INSERT INTO Job (CompanyID, JobPosition, StartDate, EndDate) Values('" +
               ddlCompany.SelectedValue.ToString() + "','" + txtDescription.Text.ToString() + "','" +
                txtStartDate.Text.ToString() + "','" + txtEndDate.Text.ToString() +  "');";
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;

            sqlConnect.Open();
            sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            //this updates the seleted company
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE Job Set JobPosition = @JobPosition, StartDate = @StartDate, EndDate = @EndDate " +
                " WHERE JobID = @JobID";
            sqlCommand.Parameters.AddWithValue("@JobPosition", txtJobTitle.Text);
            sqlCommand.Parameters.AddWithValue("@StartDate", txtStartDate2.Text);
            sqlCommand.Parameters.AddWithValue("@EndDate", txtEndDate2.Text);
            sqlCommand.Parameters.AddWithValue("@JobID", Grid.index);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void grdvJobCreation_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //this fills the textboxes with the information of the selected company
            Grid.index = int.Parse((string)e.CommandArgument);
            string sqlQuery = "SELECT * FROM Job WHERE JobID=" + Grid.index;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            SqlDataReader results = sqlCommand.ExecuteReader();
            while (results.Read())
            {
                txtJobTitle.Text = results["JobPosition"].ToString();
                txtStartDate2.Text = results["StartDate"].ToString();
                txtEndDate2.Text = results["EndDate"].ToString();
                
            }
            sqlConnect.Close();
            results.Close();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //makes panel with textboxes and labels visible
            pnlJob.Visible = true;
        }
    }
}