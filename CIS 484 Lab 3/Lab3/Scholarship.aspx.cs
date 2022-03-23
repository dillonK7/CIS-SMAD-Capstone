using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

//this method is for the creation and editing of scholarships
namespace Lab3
{
    public partial class Scholarship : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            //Checks users for username and valid account type
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
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnCommit_Click(object sender, EventArgs e)
        {
            //sql statement to create scholarship
            String sqlQuery = "INSERT INTO Scholarship (ScholarshipName, ScholarshipAmt, ScholarshipYr)" +
                    "VALUES('" + txtScholarName.Text + "','" + txtScholarAmt.Text + "','" + txtScholarYr.Text + "')";

            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;

            sqlConnect.Open();
            sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnect.Close();
            duplicationsS();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void duplicationsS()
        {
            //This sql query selects all records with the same scholarshpi name and deletes the most recent
            string sqlQuery = "DELETE FROM Scholarship WHERE ScholarshipID NOT IN (SELECT MIN(ScholarshipID) FROM Scholarship GROUP BY ScholarshipID, ScholarshipYr)";
            // Define the connection to the DB:
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            // Create and Structure the Query Command:
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            // Execute the Query and Retrieve the Results
            sqlConnect.Open();
            sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnect.Close();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //makes textboxes and labels visible
            lblScholarName2.Visible = true;
            lblScholarAmount.Visible = true;
            lblScholarYear.Visible = true;
            txtScholarName2.Visible = true;
            txtScholarYear.Visible = true;
            txtScholarAmount.Visible = true;
            btnUpdate.Visible = true;
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            //updates row in sql
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "sp_updateScholarship";    
            sqlCommand.Parameters.AddWithValue("@ScholarshipName", txtScholarName2.Text.ToString());
            sqlCommand.Parameters.AddWithValue("@ScholarshipAmt", txtScholarAmount.Text);
            sqlCommand.Parameters.AddWithValue("@ScholarshipYr", txtScholarYear.Text.ToString());
            sqlCommand.Parameters.AddWithValue("@ScholarshipID", Grid.index);
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void grdvScholarship_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //fills textboxes with selected rows information
            Grid.index = Int32.Parse((string)e.CommandArgument);
            string sqlQuery = "SELECT * FROM Scholarship WHERE ScholarshipID=" + Grid.index;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            SqlDataReader results = sqlCommand.ExecuteReader();
            while (results.Read())
            {
                txtScholarName2.Text = results["ScholarshipName"].ToString();
                txtScholarYear.Text = results["ScholarshipYr"].ToString(); 
                txtScholarAmount.Text = results["ScholarshipAmt"].ToString();
            }
            sqlConnect.Close();
            results.Close();
        }

       
    }
}