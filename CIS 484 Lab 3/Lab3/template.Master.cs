using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Lab3
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"].ToString().Equals("Student"))
            {
                HLHome.Visible = true;
                HLStudentApply.Visible = true;
                HLAccountInfo.Visible = true;
                HLCareers.Visible = true;
                HLStudentApply.Visible = true;
            }
            else if (Session["UserType"].ToString().Equals("Member"))
            {
                HLHome.Visible = true;
                HLAccountInfo.Visible = true;
                HLSignUp.Visible = true;
                HLMentorship.Visible = true;
                HLScholarships.Visible = true;
                HLCompanies.Visible = true;
                HLScholarApp.Visible = true;
                HLCareerApp.Visible = true;
                HLInternship.Visible = true;
                HLJobs.Visible = true;
            } else //admin
            {
                HLHome.Visible = true;
                HLUserApps.Visible = true;
                HLSignUp.Visible = true;
                HLMentorship.Visible = true;
                HLScholarships.Visible = true;
                HLCompanies.Visible = true;
                HLScholarApp.Visible = true;
                HLCareerApp.Visible = true;
                HLInternship.Visible = true;
                HLJobs.Visible = true;
                HLStudentApply.Visible = true;
                HLCareers.Visible = true;
                HLStudentApply.Visible = true;
                HLMemberPage.Visible = true;

            }
            lblLoggedIn.Text = "Logged in as " + Session["UserName"].ToString();
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session["UserName"] = null;
            Response.Redirect("LogIn.aspx");

            
        }
    }
}