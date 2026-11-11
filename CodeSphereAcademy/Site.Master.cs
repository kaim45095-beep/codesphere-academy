using System;

namespace CodeSphereAcademy
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateNavigation();
            }
        }

        private void UpdateNavigation()
        {
            // Check if a user is logged in
            if (Session["Role"] != null)
            {
                string role = Session["Role"].ToString();

                // Hide Guest navigation, show Logout button
                phGuestNav.Visible = false;
                phLoggedInNav.Visible = true;

                // Show specific links based on the role
                if (role == "Admin")
                {
                    phAdminNav.Visible = true;
                }
                else if (role == "Learner")
                {
                    phLearnerNav.Visible = true;
                }
            }
            else
            {
                // Not logged in: Show default guest links
                phGuestNav.Visible = true;
                phLearnerNav.Visible = false;
                phAdminNav.Visible = false;
                phLoggedInNav.Visible = false;
            }
        }
    }
}