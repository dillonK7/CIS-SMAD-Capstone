using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

//Nick Kirbabas
//03/12/2022
//This class does the code behind for the mentorship page

namespace Lab3
{
    public partial class WebForm2 : System.Web.UI.Page
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
            } else
            {
                Session["Incorrect Account Type"] = "You must be a Member to view that Page! Students are not allowed to view";
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            //this button connects to the sql db and adds a members Id to a student 
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            String student = ddlStudents.SelectedValue.ToString();
            String member = ddlMembers.SelectedValue.ToString();
            string sqlQuery = "UPDATE Students SET MemberID = " + member +  " WHERE StudentID = " + student + ";"; 
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;

            sqlConnect.Open();
            sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnect.Close();
            

        }

        protected void updateFromDB()
        {

        }

        protected void ddlStudents_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedStudent = ddlStudents.SelectedValue.ToString();
            
        }
    }
}