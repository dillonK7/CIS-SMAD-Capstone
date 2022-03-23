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
    public partial class AccountCreation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //kicks out user if they are already signed in
            if (Session["UserName"] != null)
            {
                Session["InvalidUsage"] = "You already have an account";
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString.ToString());
            //depending on which button is pressed, the type of user put in the application will vary
            if (RadioButtonList1.SelectedItem.Value == "Student")
            {
                
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandText = "INSERT INTO AccountApp(UserType, Username, UserPassword, FirstName, LastName, Email," +
                    " PhoneNumber, GradDate, Major, EmployStatus) VALUES ('Student', @UserName, @PassWord, @FirstName, @LastName," +
                    "@Email, @PhoneNumber, @GradDate, @Major,@EmployStatus)";
                sqlCommand.Parameters.AddWithValue("@UserName", txtUserName.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@PassWord", PasswordHash.HashPassword(txtPassword.Text));
                sqlCommand.Parameters.AddWithValue("@FirstName", txtFName.Text);
                sqlCommand.Parameters.AddWithValue("@LastName", txtLName.Text);
                sqlCommand.Parameters.AddWithValue("@Email", txtEmail.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@PhoneNumber", txtPhoneNum.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@GradDate", txtGradDate.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@Major", txtMajor.Text);
                sqlCommand.Parameters.AddWithValue("@EmployStatus", DDEmployList.SelectedValue.ToString());
                sqlConnection.Open();
                sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
                sqlConnection.Close();
                lblUpload.Text = "Application successfully Uploaded! Please wait for a member to approve your account";
            } else
            {
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandText = "INSERT INTO AccountApp(UserType, Username, UserPassword, FirstName, LastName, Email," +
                    " PhoneNumber, GradDate, Major) VALUES ('Member', @UserName, @PassWord, @FirstName, @LastName," +
                    "@Email, @PhoneNumber, @GradDate, @Major)";
                sqlCommand.Parameters.AddWithValue("@UserName", txtUserName.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@PassWord", PasswordHash.HashPassword(txtPassword.Text));
                sqlCommand.Parameters.AddWithValue("@FirstName", txtFName.Text);
                sqlCommand.Parameters.AddWithValue("@LastName", txtLName.Text);
                sqlCommand.Parameters.AddWithValue("@Email", txtEmail.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@PhoneNumber", txtPhoneNum.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@GradDate", txtGradDate.Text.ToString());
                sqlCommand.Parameters.AddWithValue("@Major", txtMajor.Text);
                sqlConnection.Open();
                sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
                sqlConnection.Close();

                lblUpload.Text = "Application successfully Uploaded! Please wait for the administrator to approve your account";
            }

        }
        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //changes label and shows relevant fields for each type of user
            if (RadioButtonList1.SelectedItem.Value == "Student")
            {
                pnlEmployStatus.Visible = true;
                lblGradDate.Text = "Expected Graduation Date";
               
            } 
            else
            {
                pnlEmployStatus.Visible = false;
                lblGradDate.Text = "Graduation Date";
               
            }
        }
    }
}