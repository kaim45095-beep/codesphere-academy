using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CodeSphereAcademy
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Strict Authorization Check: Must be logged in AND have the 'Admin' role
            if (Session["UserID"] == null || Session["Role"].ToString() != "Admin")
            {
                // Unauthorized users are kicked to the login page
                Response.Redirect("Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    lblAdminName.Text = Session["FullName"].ToString();
                    LoadSystemStatistics();
                }
            }
        }

        private void LoadSystemStatistics()
        {
            string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // Query 1: Count total users
                    string userQuery = "SELECT COUNT(*) FROM Users";
                    using (SqlCommand cmdUsers = new SqlCommand(userQuery, conn))
                    {
                        int userCount = (int)cmdUsers.ExecuteScalar();
                        lblTotalUsers.Text = userCount.ToString();
                    }

                    // Query 2: Count total courses
                    string courseQuery = "SELECT COUNT(*) FROM Courses";
                    using (SqlCommand cmdCourses = new SqlCommand(courseQuery, conn))
                    {
                        int courseCount = (int)cmdCourses.ExecuteScalar();
                        lblTotalCourses.Text = courseCount.ToString();
                    }
                }
                catch (Exception ex)
                {
                    lblTotalUsers.Text = "Error";
                    lblTotalCourses.Text = "Error";
                }
            }
        }
    }
}