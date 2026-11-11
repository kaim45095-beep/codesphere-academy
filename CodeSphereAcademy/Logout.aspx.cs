using System;

namespace CodeSphereAcademy
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear all session variables securely
            Session.Clear();
            Session.Abandon();

            // Redirect back to the public homepage
            Response.Redirect("Default.aspx");
        }
    }
}