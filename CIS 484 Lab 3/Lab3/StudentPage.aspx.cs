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

//this method is for members to search and edit students
namespace Lab3
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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


        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void Duplication()
        {
            //deletes the most recent student with a matching phonenumber to an existing one
            string sqlQuery = "DELETE FROM Students WHERE StudentID NOT IN (SELECT MIN(StudentID) FROM Students GROUP BY SUsername)";
            // Define the connection to the DB:
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            // Create and Structure the Query Command:
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            // Execute the Query and Retrieve the Results
            sqlConnect.Open();
            sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnect.Close();
        }

       protected void lnkDownload_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            string sqlQuery = "Select resumeFile from Students Where StudentID = @StudentID";
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.AddWithValue("@StudentID", Grid.index);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            string fileName = sqlCommand.ExecuteScalar().ToString();
            sqlConnect.Close();

            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            string filePath = "/Resumes/" + fileName;
            Response.ContentType = "PDF";
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filePath + "\"");
            Response.TransmitFile(Server.MapPath(filePath));
            Response.End();
        }

        protected void grdvStudent_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Grid.index = int.Parse((string)e.CommandArgument);
            string sqlQuery = "SELECT * FROM Students WHERE StudentID=" + Grid.index;
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
                DDEmployList.SelectedValue = results["EmployStatus"].ToString();
            }
            sqlConnect.Close();
                results.Close();
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            pnlStudent.Visible = true;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE [Students] SET [FirstName] = @FirstName, [LastName] = @LastName, [Email] = @Email, " +
            "[PhoneNumber] = @PhoneNumber, [GradDate] = @GradDate, [Major] = @Major, [EmployStatus] = @EmployStatus" +
            " WHERE[StudentID] = @StudentID";
            sqlCommand.Parameters.AddWithValue("@FirstName", txtFName.Text);
            sqlCommand.Parameters.AddWithValue("@LastName", txtLName.Text);
            sqlCommand.Parameters.AddWithValue("@Email", txtEmail.Text);
            sqlCommand.Parameters.AddWithValue("@PhoneNumber", txtPhoneNum.Text);
            sqlCommand.Parameters.AddWithValue("@GradDate", txtGradDate.Text);
            sqlCommand.Parameters.AddWithValue("@Major", txtMajor.Text);
            sqlCommand.Parameters.AddWithValue("@EmployStatus", DDEmployList.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@StudentID", Grid.index);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //query looks for search result using LIKE command 
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            string query = "select SUsername, FirstName, LastName, Email, PhoneNumber, GradDate, Major, " +
                "EmployStatus from Students where FirstName + ' ' + LastName like '" + txtSearch.Text + "%'";
            SqlDataAdapter da = new SqlDataAdapter(query, sqlConnect);
            DataSet ds = new DataSet();
            da.Fill(ds);
            grdv_Search.DataSource = ds;
            grdv_Search.DataBind();
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = query;
            sqlConnect.Open();
            SqlDataReader reader = sqlCommand.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();
                //rep_bind();
                grdv_Search.Visible = true;
                txtSearch.Text = "";
                lblSearch.Text = "";
                reader.Close();
            }
            else
            {
                grdv_Search.Visible = false;
                lblSearch.Visible = true;
                lblSearch.Text = "The search Term " + txtSearch.Text + " Is Not Available in the Records";
            }
            sqlConnect.Close();
        }

        protected void showDownloadLink(object sender, EventArgs e)
        {
            //download link becomes visible when download button clicked
            lnkDownload.Visible = true;
        }
    }
       
 }

