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
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Checks for user and displays any error messages from trying to access wrong pages
            lblError.Text = "";
            if (Session["UserName"] == null)
            {
                Session["InvalidUsage"] = "You must first Log In to view the site!";
                Response.Redirect("LogIn.aspx");
            }
            if (Session["Incorrect Account Type"] != null)
            {
                lblError.Text = Session["Incorrect Account Type"].ToString();
            }
            lblWelcome.Text = "Welcome to DukeGroup, " + Session["UserName"].ToString() + "!";
        }

       
           
    }
}