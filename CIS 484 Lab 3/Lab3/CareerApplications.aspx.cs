using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.IO;
using System.Configuration;
using System.Drawing;

//This class is responsible for the updates of internship and job applications
namespace Lab3
{
    public partial class CareerApplications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Checks for log in status and appropriate user type
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
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //this event shows the job applications as reviewed
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE [jobApp] SET AppStatus = 'Reviewed' WHERE [JAppID] = @JAppID";
            sqlCommand.Parameters.AddWithValue("@JAppID", (int)grdvStudent.DataKeys[0].Value);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnEdit_Click1(object sender, EventArgs e)
        {
            //this event shows the internship applications as reviewed
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE [jobApp] SET AppStatus = 'Reviewed' WHERE [JAppID] = @JAppID";
            sqlCommand.Parameters.AddWithValue("@JAppID", (int)grdvJobs.DataKeys[0].Value);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}