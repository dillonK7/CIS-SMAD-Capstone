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

//This method is for the administrator to see and edit existing members
namespace Lab3
{
    public partial class MemberPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("LogIn.aspx");
            }
            if (Session["UserType"].ToString().Equals("Admin"))
            {
            }
            else
            {
                Session["Incorrect Account Type"] = "You must be a Member to view that Page! Students are not allowed to view";
                Response.Redirect("Home.aspx");
            }
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            //updates selected member
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE [Members] SET [FirstName] = @FirstName, [LastName] = @LastName, [Email] = @Email, " +
                "[PhoneNumber] = @PhoneNumber, [GradDate] = @GradDate, [Major] = @Major WHERE [MemberID] = @MemberID";
            sqlCommand.Parameters.AddWithValue("@FirstName", txtFName.Text);
            sqlCommand.Parameters.AddWithValue("@LastName", txtLName.Text);
            sqlCommand.Parameters.AddWithValue("@Email", txtEmail.Text);
            sqlCommand.Parameters.AddWithValue("@PhoneNumber", txtPhoneNum.Text);
            sqlCommand.Parameters.AddWithValue("@GradDate", txtGradDate.Text);
            sqlCommand.Parameters.AddWithValue("@Major", txtMajor.Text);
            sqlCommand.Parameters.AddWithValue("@MemberID", Grid.index);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void grdvMember_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //populate textboxes of selected member
            Grid.index = int.Parse((string)e.CommandArgument);
            string sqlQuery = "SELECT * FROM Members WHERE MemberID=" + Grid.index;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            SqlDataReader results = sqlCommand.ExecuteReader();
            while (results.Read())
            {
                txtFName.Text = results["FirstName"].ToString();
                txtLName.Text = results["LastName"].ToString();
                txtEmail.Text = results["Email"].ToString();
                txtPhoneNum.Text = results["PhoneNumber"].ToString();
                txtGradDate.Text = results["GradDate"].ToString();
                txtMajor.Text = results["Major"].ToString();
            }
            sqlConnect.Close();
            results.Close();
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            PnlMember.Visible = true;
        }
    }
}