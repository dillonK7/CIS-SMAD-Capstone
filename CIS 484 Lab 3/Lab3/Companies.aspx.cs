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

//this method allows a member to make and edit a company
namespace Lab3
{   
    class Grid
    {
        //this integer is used in all row commands for displaying the selected row
        //made public static to reduce number of intergers made in solution
        public static int index;
    }
    public partial class Companies : System.Web.UI.Page
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
            }
            else
            {
                Session["Incorrect Account Type"] = "You must be a Member to view that Page! Students are not allowed to view";
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnCommit_Click(object sender, EventArgs e)
        {
            //Performs sql query to insert data into company table based on values from webform

            String sqlQuery = "INSERT INTO Company (CompanyName, CompanyEmail, CompanyState, CompanyCity, CompanyStreet, CompanyZip)" +
                    " Values ('" + txtCompanyName.Text + "','" + txtCompanyEmail.Text + "','" + txtState.Text + "','" +
                    txtCity.Text + "','" + txtStreet.Text + "','" + txtZip.Text + "')";
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;

            sqlConnect.Open();
            sqlCommand.ExecuteScalar(); // Used for other than SELECT Queries
            sqlConnect.Close();
            duplicationsC();
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void duplicationsC()
        {
            //This sql query selects all records with the same company email and deletes the most recent
            string sqlQuery = "DELETE FROM Company WHERE CompanyID NOT IN (SELECT MIN(CompanyID) FROM Company GROUP BY CompanyEmail)";
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

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //makes labels and textboxes visible
            Label1.Visible = true;
            Label2.Visible = true;
            Label3.Visible = true;
            Label4.Visible = true;
            Label5.Visible = true;
            Label6.Visible = true;
            TextBox1.Visible = true;
            TextBox2.Visible = true;
            TextBox3.Visible = true;
            TextBox4.Visible = true;
            TextBox5.Visible = true;
            TextBox6.Visible = true;
            btnUpdate.Visible = true;
            btnClearEdit.Visible = true;
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            //this updates the companies information
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand();
            string sqlQuery = "UPDATE Company Set CompanyName = @CompanyName, CompanyEmail = @CompanyEmail, CompanyState = @CompanyState, " +
                "CompanyCity = @CompanyCity, CompanyStreet = @CompanyStreet, CompanyZip = @CompanyZip WHERE CompanyID = @CompanyID";
            sqlCommand.Parameters.AddWithValue("@CompanyName", TextBox1.Text);
            sqlCommand.Parameters.AddWithValue("@CompanyEmail", TextBox2.Text);
            sqlCommand.Parameters.AddWithValue("@CompanyState", TextBox3.Text);
            sqlCommand.Parameters.AddWithValue("@CompanyCity", TextBox4.Text);
            sqlCommand.Parameters.AddWithValue("@CompanyStreet", TextBox5.Text);
            sqlCommand.Parameters.AddWithValue("@CompanyZip", TextBox6.Text);
            sqlCommand.Parameters.AddWithValue("@CompanyID", Grid.index);
            sqlCommand.Connection = sqlConnect;
            sqlCommand.CommandType = CommandType.Text;
            sqlCommand.CommandText = sqlQuery;
            sqlConnect.Open();
            sqlCommand.ExecuteScalar();
            sqlConnect.Close();
            Response.Redirect(Request.Url.AbsoluteUri);

        }

        protected void btnClearEdit_Click(object sender, EventArgs e)
        {
            //addCurrentInfo();
        }


        protected void grdvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            Grid.index = int.Parse((string)e.CommandArgument);
            string sqlQuery = "SELECT * FROM Company WHERE CompanyID=" + Grid.index;
            SqlConnection sqlConnect = new SqlConnection(WebConfigurationManager.ConnectionStrings["Lab3"].ConnectionString);
            SqlCommand sqlCommand = new SqlCommand(sqlQuery, sqlConnect);
            sqlConnect.Open();
            SqlDataReader results = sqlCommand.ExecuteReader();
            while (results.Read())
            {
                TextBox1.Text = results["CompanyName"].ToString();
                TextBox2.Text = results["CompanyEmail"].ToString();
                TextBox3.Text = results["CompanyState"].ToString();
                TextBox4.Text = results["CompanyCity"].ToString();
                TextBox5.Text = results["CompanyStreet"].ToString();
                TextBox6.Text = results["CompanyZip"].ToString();
            }
            sqlConnect.Close();
            results.Close();
        }

      
    }
}