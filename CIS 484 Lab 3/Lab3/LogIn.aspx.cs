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
    public partial class LogIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            try
            {
                //connects to the AUTH DB to see if there are matching credentials
                System.Data.SqlClient.SqlConnection sc = new SqlConnection(WebConfigurationManager.ConnectionStrings["AUTH"].ConnectionString.ToString());
                //lblStatus.Text = "Database Connection Successful";

                sc.Open();
                System.Data.SqlClient.SqlCommand findPass = new System.Data.SqlClient.SqlCommand();
                findPass.Connection = sc;
                // SELECT PASSWORD STRING WHERE THE ENTERED USERNAME MATCHES
                findPass.CommandText = "SELECT UserPassword FROM User_Credentials WHERE Username = @Username";
                findPass.Parameters.Add(new SqlParameter("@Username", txtUserName.Text));

                SqlDataReader reader = findPass.ExecuteReader(); // create a reader

                if (reader.HasRows) // if the username exists, it will continue
                {
                    while (reader.Read()) // this will read the single record that matches the entered username
                    {
                        string storedHash = reader["UserPassword"].ToString(); // store the database password into this variable

                        if (PasswordHash.ValidatePassword(txtPassword.Text, storedHash)) // if the entered password matches what is stored, it will show success
                        {
                            reader.Close();
                            System.Data.SqlClient.SqlCommand findType = new System.Data.SqlClient.SqlCommand();
                            findType.Connection = sc;
                            findType.CommandText = "SELECT UserType FROM User_Credentials WHERE Username = @Username";
                            findType.Parameters.Add(new SqlParameter("@Username", txtUserName.Text));

                        
                            SqlDataReader reader2 = findType.ExecuteReader();
                            reader2.Read();
                            string storedType = reader2["UserType"].ToString();

                            Session["UserType"] = storedType;
                            Session["Username"] = txtUserName.Text;
                            Response.Redirect("Home.aspx");
                        }
                        else
                        {
                            lblIncorrectLogin.Text = "Password is wrong.";
                        }
                    }
                }
                else // if the username doesn't exist, it will show failure
                    lblIncorrectLogin.Text = "Login failed.";

                sc.Close();
            }
            catch
            {

                lblIncorrectLogin.Text = "Database Error.";
            }
        }
    

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            //sends user to the sign up page
            Response.Redirect("AccountCreation.aspx");
        }
    }
}