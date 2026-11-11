using System;

namespace CodeSphereAcademy
{
    public partial class LearnerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Authorization Check: If the user is NOT logged in, kick them back to the login page
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                // Retrieve the user's name from the Session variable we set during Login
                if (Session["FullName"] != null)
                {
                    lblUserName.Text = Session["FullName"].ToString();
                }
            }
        }
    }
}