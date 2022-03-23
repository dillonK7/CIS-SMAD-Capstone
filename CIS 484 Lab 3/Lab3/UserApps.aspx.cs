using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Drawing;

namespace Lab3
{
    public partial class UserApps : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("LogIn.aspx");
            }
            if (Session["UserType"].Equals("Admin"))
            {
            }
            else
            {
                Session["Incorrect Account Type"] = "This Page is restricted";
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnCommit_Click(object sender, EventArgs e) 
        {
            changeStatus();
            SqlConnection sqlConnectionA = new SqlConnection(WebConfigurationManager.ConnectionStrings["AUTH"].ConnectionString.ToString());
            SqlCommand sqlCommandA = new SqlCommand();
            sqlCommandA.Connection = sqlConnectionA;
            sqlCommandA.CommandText = "USE AUTH INSERT INTO AUTH.dbo.User_Credentials(User_Credentials.UserType, User_Credentials.Username, " +
                "User_Credentials.UserPassword) select AccountApp.UserType, AccountApp.Username, " +
                "AccountApp.UserPassword From [Lab3].dbo.AccountApp where AccountApp.UserAppID = @UserAppID";
            sqlCommandA.Parameters.AddWithValue("@UserAppID", ddlNames.SelectedValue.ToString());

          

            sqlConnectionA.Open();
            sqlCommandA.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnectionA.Close();


            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString.ToString());
            SqlCommand sqlCommandB = new SqlCommand();
            sqlCommandB.Connection = sqlConnection;
            sqlCommandB.CommandText = "Select UserType from AccountApp Where UserAppID = @UserAppID"; //need to add query that returns usertype
            sqlCommandB.Parameters.AddWithValue("@UserAppID", ddlNames.SelectedValue.ToString());
            sqlConnection.Open();
            string UType = (string)sqlCommandB.ExecuteScalar();

            if (UType.Equals("Member"))
            {

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandText = "insert INTO Members (MUsername, FirstName, LastName, Email, PhoneNumber, GradDate, Major) " +
                    "Select Username, FirstName, LastName, Email, PhoneNumber, GradDate, Major From AccountApp Where UserAppID = @UserAppID";
                sqlCommand.Parameters.AddWithValue("@UserAppID", ddlNames.SelectedValue.ToString());

                sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            } else
            {
                SqlCommand sqlCommandS = new SqlCommand();
                sqlCommandS.Connection = sqlConnection;
                sqlCommandS.CommandText = "insert INTO Students (SUsername, FirstName, LastName, Email, PhoneNumber, GradDate, Major, EmployStatus) " +
                    "Select Username, FirstName, LastName, Email, PhoneNumber, GradDate, Major, EmployStatus From AccountApp Where UserAppID = @UserAppID";
                sqlCommandS.Parameters.AddWithValue("@UserAppID", ddlNames.SelectedValue.ToString());

                sqlCommandS.ExecuteScalar(); // Used for other than SELECT Queries
            }
            
            sqlConnection.Close();

            
            
        }

        protected void changeStatus()
        {
            SqlConnection sqlConnectionA = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString.ToString());
            SqlCommand sqlCommandA = new SqlCommand();
            sqlCommandA.Connection = sqlConnectionA;
            sqlCommandA.CommandText = "UPDATE AccountApp set AppStatus = 'Accepted' where UserAppID = @UserAppID";
            sqlCommandA.Parameters.AddWithValue("@UserAppID", ddlNames.SelectedValue.ToString());
            sqlConnectionA.Open();
            sqlCommandA.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnectionA.Close();
        }
    }
}