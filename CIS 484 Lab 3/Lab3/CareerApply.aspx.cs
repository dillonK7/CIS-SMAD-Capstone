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

//this class allows a student to apply to an opening for either a job or internship
namespace Lab3
{
    public partial class InternApply : System.Web.UI.Page
    {
        int stuID;
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
            txtAppDate.Text = DateTime.Now.ToString(); //makes application date current date

        }

        protected void btnCommit_Click(object sender, EventArgs e)
        {
            
            //returns studentID based on session username
            SqlConnection sqlConnectID = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            string sqlQueryID = "Select StudentID from Students WHERE SUsername = @Username";
            SqlCommand sqlCommandID = new SqlCommand();
            sqlCommandID.Connection = sqlConnectID;
            sqlCommandID.CommandType = CommandType.Text;
            sqlCommandID.CommandText = sqlQueryID;
            sqlCommandID.Parameters.AddWithValue("@UserName", Session["UserName"]);

            sqlConnectID.Open();
            stuID = Convert.ToInt32(sqlCommandID.ExecuteScalar());
            sqlConnectID.Close();

            //If true that means there is an internship with those values 
            if (checkInternships())
            {
                //Values are inserted into jobApp table using an internID
                SqlConnection sqlConnectI = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
                string sqlQueryI = "INSERT INTO JobApp(StudentID, InternID, ApplyDate) VALUES('" + stuID.ToString() + "','" +
                    ddlJob.SelectedValue.ToString() + "','" + txtAppDate.Text.ToString() + "')";
                SqlCommand sqlCommandI = new SqlCommand();
                sqlCommandI.Connection = sqlConnectI;
                sqlCommandI.CommandType = CommandType.Text;
                sqlCommandI.CommandText = sqlQueryI;
                sqlConnectI.Open();
                sqlCommandI.ExecuteScalar();
                sqlConnectI.Close();

            } else
            {
                //If it is not an internship it must be a job so it is inserted with a jobID
                SqlConnection sqlConnectJ = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
                string sqlQueryJ = "INSERT INTO JobApp(StudentID, [Job].JobID, ApplyDate) VALUES('" + stuID.ToString() + "','" +
                    ddlJob.SelectedValue.ToString() + "','" + txtAppDate.Text.ToString() + "')";
                SqlCommand sqlCommandJ = new SqlCommand();
                sqlCommandJ.Connection = sqlConnectJ;
                sqlCommandJ.CommandType = CommandType.Text;
                sqlCommandJ.CommandText = sqlQueryJ;
                sqlConnectJ.Open();
                sqlCommandJ.ExecuteScalar(); 
                sqlConnectJ.Close();
            }
            
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected Boolean checkInternships() //
        {
            //Sql query checks to see if the position selected is in the internship table
            SqlConnection sqlConnectI = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);

            string sqlQueryI = "select count(*) from Internship WHERE InternDesc = '" + 
                ddlJob.SelectedItem.Text +  "' AND " + "CompanyID = " + ddlJob.SelectedValue.ToString();
            SqlCommand sqlCommandI = new SqlCommand();
            sqlCommandI.Connection = sqlConnectI;
            sqlCommandI.CommandType = CommandType.Text;
            sqlCommandI.CommandText = sqlQueryI;

            sqlConnectI.Open();
            int count = Convert.ToInt32(sqlCommandI.ExecuteScalar());
            sqlConnectI.Close();

            if (count == 1)
            {
                return true; //Means there is an internship
            } else
            {
                return false; //not internship
            }
            
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //if (ResumeUpload.HasFile)
            //    try
            //    {

            //        ResumeUpload.SaveAs(Server.MapPath("/Resumes/") + Session["UserName"].ToString() + "_" +
            //             ResumeUpload.FileName);
            //        lblResume.Text = "File name: " +
            //             ResumeUpload.PostedFile.FileName + "<br>" +
            //             ResumeUpload.PostedFile.ContentLength + " kb<br>" +
            //             "Content type: " + ResumeUpload.PostedFile.ContentType;

            //        SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            //        string sqlQuery = "INSERT INTO jobApp(resumeFile) VALUES ('" + Session["UserName"].ToString() + ResumeUpload.FileName + "') WHERE StudentID = " + stuID;
            //        SqlCommand sqlCommand = new SqlCommand();
            //        sqlCommand.Connection = sqlConnect;
            //        sqlCommand.CommandType = CommandType.Text;
            //        sqlCommand.CommandText = sqlQuery;
            //        sqlConnect.Open();
            //        sqlConnect.Close();

            //    }
            //    catch (Exception ex)
            //    {
            //        lblResume.Text = "ERROR: " + ex.Message.ToString();
            //    }
            //else
            //{
            //    lblResume.Text = "You have not specified a file.";
            //}

        }

    }
}