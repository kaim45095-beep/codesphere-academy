using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CodeSphereAcademy
{
    public partial class CoursePortal : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Must be logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                string courseId = Request.QueryString["CourseID"];
                if (string.IsNullOrEmpty(courseId))
                {
                    Response.Redirect("Courses.aspx"); // Kick out if no CourseID provided
                }

                VerifyAccessAndLoadData(courseId);
            }
        }

        private void VerifyAccessAndLoadData(string courseId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // 2. SECURITY CHECK: Ensure user actually owns this course and it hasn't expired
                string securityQuery = @"
                    SELECT COUNT(*) 
                    FROM Enrollments 
                    WHERE UserID = @UserID AND CourseID = @CourseID AND ExpiryDate > GETDATE()";

                using (SqlCommand checkCmd = new SqlCommand(securityQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                    checkCmd.Parameters.AddWithValue("@CourseID", courseId);

                    conn.Open();
                    int hasAccess = (int)checkCmd.ExecuteScalar();

                    if (hasAccess == 0)
                    {
                        // User tried to hack the URL without buying the course. Kick them back.
                        Response.Redirect("Courses.aspx");
                    }
                }

                // 3. LOAD DATA: If security check passes, load the course title and description
                string courseQuery = "SELECT Title, Description FROM Courses WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(courseQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblCourseTitle.Text = reader["Title"].ToString();
                            lblCourseDesc.Text = reader["Description"].ToString();
                        }
                    }
                }
            }
        }
    }
}