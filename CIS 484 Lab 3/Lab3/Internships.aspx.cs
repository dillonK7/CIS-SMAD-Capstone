using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

//this method lets a member create and edit internships
namespace Lab3
{
    public partial class Internships : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("Home.aspx");
            }

            if (Session["UserType"].ToString().Equals("Member") || Session["UserType"].ToString().Equals("Admin"))
            {
            }
            else
            {
                Session["Incorrect Account Type"] = "You must be a Member to view that Page! Students are not allowed to view";
                Response.Redirect("InternApply.aspx");
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            //This sql query inserts a row into the internship table
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            string sqlQuery = "INSERT INTO Internship (InternDesc, InternYr, StartDate, EndDate, CompanyID) Values('" +
                txtDescription.Text.ToString() + "','" + ddlYear.SelectedValue.ToString() + "','" +
                txtStartDate.Text.ToString() + "','" + txtEndDate.Text.ToString() + "','" + ddlCompany.SelectedValue.ToString() + "');";
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
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            lblEndDate2.Visible = true;
            lblStartDate2.Visible = true;
            lblInternDesc.Visible = true;
            lblInternYear.Visible = true;
            txtInternDesc.Visible = true;
            ddlInternYr.Visible = true;
            txtStartDate2.Visible = true;
            txtEndDate2.Visible = true;
            btnUpdate.Visible = true;
        }

        protected void grdvIntern_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //this populates the textboxes for the row that is selected
            Grid.index = int.Parse((string)e.CommandArgument);
            string sqlQuery = "SELECT * FROM Internship WHERE InternID=" + Grid.index;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            SqlDataReader results = sqlCommand.ExecuteReader();
            while (results.Read())
            {
                txtInternDesc.Text = results["InternDesc"].ToString();
                ddlInternYr.SelectedValue = results["InternYr"].ToString();
                txtStartDate2.Text = results["StartDate"].ToString();
                txtEndDate2.Text = results["EndDate"].ToString();


            }
            sqlConnect.Close();
            results.Close();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            //this updates the internship that was selected
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE Internship Set InternDesc = @InternDesc, InternYr = @InternYr, StartDate = @StartDate, " +
                "EndDate = @EndDate WHERE InternID = @InternID";
            sqlCommand.Parameters.AddWithValue("@InternDesc", txtInternDesc.Text);
            sqlCommand.Parameters.AddWithValue("@InternYr", ddlInternYr.Text);
            sqlCommand.Parameters.AddWithValue("@StartDate", txtStartDate2.Text);
            sqlCommand.Parameters.AddWithValue("@EndDate", txtEndDate2.Text);
            sqlCommand.Parameters.AddWithValue("@InternID", Grid.index);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnClearEdit_Click(object sender, EventArgs e)
        {

        }
    }
}