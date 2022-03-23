using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

//this method is for a student applying to scholarship
namespace Lab3
{
    public partial class StudentApply : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("LogIn.aspx");
            }
            if (Session["UserType"].ToString().Equals("Member"))
            {
                Response.Redirect("CareerApplications.aspx");
            }
            txtAppDate.Text = DateTime.Now.ToString();
            

        }

        protected void btnCommit_Click(object sender, EventArgs e)
        {
            //This looks for the students ID for later use in code
            SqlConnection sqlConnect2 = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            string sqlQuery2 = "Select StudentID from Students WHERE SUsername = @Username";
            SqlCommand sqlCommand2 = new SqlCommand();
            sqlCommand2.Connection = sqlConnect2;
            sqlCommand2.CommandType = CommandType.Text;
            sqlCommand2.CommandText = sqlQuery2;
            sqlCommand2.Parameters.AddWithValue("@UserName", Session["UserName"]);

            sqlConnect2.Open();
            int stuID = Convert.ToInt32(sqlCommand2.ExecuteScalar());
            sqlConnect2.Close();

            //This method connects to the SQL database and inserts a row into the table given values filled in the form
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            string sqlQuery = "INSERT INTO Applications (StudentID, ScholarshipID, AppDate, AppText) Values('" +
                stuID.ToString() + "','" + ddlScholarships.SelectedValue.ToString() + "','" +
                txtAppDate.Text.ToString() + "','" + txtAppText.Text.ToString() + "');";
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;

            sqlConnect.Open();
            sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnect.Close();

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}