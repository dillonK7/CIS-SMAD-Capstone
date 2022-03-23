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
    public partial class Application : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //These checks make sure the user is signed in and to the appropriate account type
            if (Session["UserName"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("LogIn.aspx");
            }

            if (Session["UserType"].ToString().Equals("Student"))
            {
                Response.Redirect("StudentApply.aspx");
            }


        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            //When a member approves a student for a scholarship the status of their application is changed
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE [Applications] SET AppStatus = 'Accepted' WHERE [StudentID] = @StudentID";
            sqlCommand.Parameters.AddWithValue("@StudentID", (int)grdvStudentScholarship.DataKeys[0].Value);
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