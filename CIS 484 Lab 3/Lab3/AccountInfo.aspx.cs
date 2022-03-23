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
//This is the code behind for a user's account information

namespace Lab3 

{
    public partial class AccountInfo : System.Web.UI.Page
    {
        int stuID;
        protected void Page_Load(object sender, EventArgs e)
        {
                //Checks to see if user is logged in
            if (Session["UserName"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("LogIn.aspx");
            } 
            else if (Session["UserType"].Equals("Student"))
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

                lblResume.Visible = true;
                ResumeUpload.Visible = true;
                btnUpload.Visible = true;
                

            }

            

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //looks at extension of file to make sure its pdf
            string extension = System.IO.Path.GetExtension(ResumeUpload.FileName);
            if (ResumeUpload.HasFile && extension.ToLower() == (".pdf"))
                try
                {
                    //saves to the solution in Resumes folder and adds username to file name for ease of searching
                    ResumeUpload.SaveAs(Server.MapPath("/Resumes/") + Session["UserName"].ToString() + "_" +
                         ResumeUpload.FileName);
                    lblResume.Text = "File name: " +
                         ResumeUpload.PostedFile.FileName + "<br>" +
                         ResumeUpload.PostedFile.ContentLength + " kb<br>" +
                         "Content type: " + ResumeUpload.PostedFile.ContentType;

                    string fileName = Session["UserName"].ToString() + "_" + ResumeUpload.FileName.ToString();

                    SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
                    string sqlQuery = "UPDATE Students SET resumeFile  = '" + fileName + "' WHERE StudentID = @StudentID" ;
                    SqlCommand sqlCommand = new SqlCommand();
                    sqlCommand.Parameters.AddWithValue("@StudentID", stuID);
                    sqlCommand.Connection = sqlConnect;
                    sqlCommand.CommandType = CommandType.Text;
                    sqlCommand.CommandText = sqlQuery;
                    sqlConnect.Open();
                    sqlCommand.ExecuteScalar();
                    sqlConnect.Close();
                    Response.Redirect(Request.Url.AbsoluteUri);

                }
                catch (Exception ex)
                {
                    //error message
                    lblResume.Text = "ERROR: " + ex.Message.ToString();
                }
            else
            {
                lblResume.Text = "You have not specified a file Or have submitted a file type not supported (Upload Resume as PDF)";
            }
        }

        protected void lnkDownload_Click(object sender, EventArgs e)
        {
            //method looks for the students resume on the db
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            string sqlQuery = "Select resumeFile from Students Where StudentID = @StudentID";
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.AddWithValue("@StudentID", stuID);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            string fileName = sqlCommand.ExecuteScalar().ToString();
            sqlConnect.Close();

            //allows download of file
            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            string filePath = "/Resumes/" + fileName;
            Response.ContentType = "PDF";
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
            Response.TransmitFile(Server.MapPath(filePath));
            Response.End();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //make relevant labels and text boxes visible
            lblUsername.Visible = true;
            lblFirstName.Visible = true;
            lblLastName.Visible = true;
            lblEmail.Visible = true;
            lblMajor.Visible = true;
            lblPhone.Visible = true;
            lblGradDate.Visible = true;

            txtUsername.Visible = true;
            txtFirstName.Visible = true;
            txtLastName.Visible = true;
            txtEmail.Visible = true;
            txtMajor.Visible = true;
            txtPhone.Visible = true;
            txtGradDate.Visible = true;

            btnClear.Visible = true;
            btnUpdate.Visible = true;

            if (Session["UserType"].Equals("Student")) {
                
                lblEmploymentStatus.Visible = true;
                txtEmploymentStatus.Visible = true;
                addCurrentInfo();

            } else
            {
                addCurrentInfo();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            addCurrentInfo();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "";
            //if the user is a student a different query will be done for the edit
            if (Session["UserType"].Equals("Student")) {
                sqlQuery = "UPDATE Students Set SUsername = @SUsername, FirstName = @FirstName, LastName = @LastName, " +
                "Email = @Email, PhoneNumber = @PhoneNumber, GradDate = @GradDate, Major = @Major," +
                "EmployStatus = @EmployStatus WHERE StudentID = @StudentID";
            sqlCommand.Parameters.AddWithValue("@StudentID", stuID);
            sqlCommand.Parameters.AddWithValue("@SUsername", txtUsername.Text);
            sqlCommand.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
            sqlCommand.Parameters.AddWithValue("@LastName", txtLastName.Text);
            sqlCommand.Parameters.AddWithValue("@Email", txtEmail.Text);
            sqlCommand.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text);
            sqlCommand.Parameters.AddWithValue("@GradDate", txtGradDate.Text);
            sqlCommand.Parameters.AddWithValue("@Major", txtMajor.Text);
             sqlCommand.Parameters.AddWithValue("@EmployStatus", txtEmploymentStatus.Text);
            } else
            {
                sqlQuery = "UPDATE Members Set MUsername = @MUsername, FirstName = @FirstName, LastName = @LastName, " +
               "Email = @Email, PhoneNumber = @PhoneNumber, GradDate = @GradDate, Major = @Major " +
               "WHERE MUsername = @MUsername";
                sqlCommand.Parameters.AddWithValue("@MUsername", txtUsername.Text);
                sqlCommand.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                sqlCommand.Parameters.AddWithValue("@LastName", txtLastName.Text);
                sqlCommand.Parameters.AddWithValue("@Email", txtEmail.Text);
                sqlCommand.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text);
                sqlCommand.Parameters.AddWithValue("@GradDate", txtGradDate.Text);
                sqlCommand.Parameters.AddWithValue("@Major", txtMajor.Text);
            }

            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void addCurrentInfo ()
        {
            //depending on user type different data will be pulled from the two gridviews

            if (Session["UserType"].Equals("Student"))
            {
                txtUsername.Text = grdvStudent.Rows[0].Cells[2].Text;
                txtFirstName.Text = grdvStudent.Rows[0].Cells[3].Text;
                txtLastName.Text = grdvStudent.Rows[0].Cells[4].Text;
                txtEmail.Text = grdvStudent.Rows[0].Cells[5].Text;
                txtPhone.Text = grdvStudent.Rows[0].Cells[6].Text;
                txtGradDate.Text = grdvStudent.Rows[0].Cells[7].Text;
                txtMajor.Text = grdvStudent.Rows[0].Cells[8].Text;
                txtEmploymentStatus.Text = grdvStudent.Rows[0].Cells[9].Text;
            } else
            {
                txtUsername.Text = GridView1.Rows[0].Cells[2].Text;
                txtFirstName.Text = GridView1.Rows[0].Cells[3].Text;
                txtLastName.Text = GridView1.Rows[0].Cells[4].Text;
                txtEmail.Text = GridView1.Rows[0].Cells[5].Text;
                txtPhone.Text = GridView1.Rows[0].Cells[6].Text;
                txtGradDate.Text = GridView1.Rows[0].Cells[7].Text;
                txtMajor.Text = GridView1.Rows[0].Cells[8].Text;
            }
        }
    }
}