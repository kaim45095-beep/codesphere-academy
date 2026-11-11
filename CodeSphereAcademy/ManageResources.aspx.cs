using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace CodeSphereAcademy
{
    public partial class ManageResources : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadCoursesGrid("");
            }
        }

        protected void btnSearchCourse_Click(object sender, EventArgs e)
        {
            LoadCoursesGrid(txtSearchCourse.Text.Trim());
        }

        private void LoadCoursesGrid(string searchTerm)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT CourseID, Title, Description, DateAdded FROM Courses WHERE Title LIKE @Title ORDER BY DateAdded DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", "%" + searchTerm + "%");
                    try
                    {
                        conn.Open();
                        gvAdminCourses.DataSource = cmd.ExecuteReader();
                        gvAdminCourses.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "Error loading courses.";
                        lblStatus.CssClass = "status-msg error";
                    }
                }
            }
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "INSERT INTO Courses (Title, Description, DateAdded) VALUES (@Title, @Description, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            txtTitle.Text = string.Empty;
                            txtDescription.Text = string.Empty;
                            lblStatus.Text = "Course added successfully!";
                            lblStatus.CssClass = "status-msg success";

                            LoadCoursesGrid(txtSearchCourse.Text.Trim());
                        }
                        catch (Exception ex)
                        {
                            lblStatus.Text = "Error adding course. Please try again.";
                            lblStatus.CssClass = "status-msg error";
                        }
                    }
                }
            }
        }

        protected void gvAdminCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseID = Convert.ToInt32(gvAdminCourses.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // First delete related enrollments to prevent foreign key errors
                string deleteEnrollments = "DELETE FROM Enrollments WHERE CourseID = @CourseID";
                string deleteCourse = "DELETE FROM Courses WHERE CourseID = @CourseID";

                try
                {
                    conn.Open();
                    using (SqlCommand cmd1 = new SqlCommand(deleteEnrollments, conn))
                    {
                        cmd1.Parameters.AddWithValue("@CourseID", courseID);
                        cmd1.ExecuteNonQuery();
                    }

                    using (SqlCommand cmd2 = new SqlCommand(deleteCourse, conn))
                    {
                        cmd2.Parameters.AddWithValue("@CourseID", courseID);
                        cmd2.ExecuteNonQuery();
                    }

                    lblStatus.Text = "Course deleted successfully.";
                    lblStatus.CssClass = "status-msg success";

                    LoadCoursesGrid(txtSearchCourse.Text.Trim());
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "Error deleting course.";
                    lblStatus.CssClass = "status-msg error";
                }
            }
        }
    }
}