using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CodeSphereAcademy
{
    public partial class Courses : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    btnTabMy.Visible = false;
                }
                else
                {
                    LoadMyCourses();
                }

                LoadAllCourses("", "All");
            }
        }

        protected void btnTabAll_Click(object sender, EventArgs e)
        {
            pnlAllCourses.Visible = true;
            pnlMyCourses.Visible = false;
            btnTabAll.CssClass = "tab-btn active";
            btnTabMy.CssClass = "tab-btn";
        }

        protected void btnTabMy_Click(object sender, EventArgs e)
        {
            pnlAllCourses.Visible = false;
            pnlMyCourses.Visible = true;
            btnTabAll.CssClass = "tab-btn";
            btnTabMy.CssClass = "tab-btn active";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadAllCourses(txtSearch.Text.Trim(), ddlCategory.SelectedValue);
        }

        private void LoadAllCourses(string searchTerm, string categoryFilter)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "";

                if (Session["UserID"] == null)
                {
                    query = @"
                        SELECT CourseID, Title, Description, 
                               0 AS IsEnrolled
                        FROM Courses 
                        WHERE Title LIKE @SearchTerm ";
                }
                else
                {
                    query = @"
                        SELECT c.CourseID, c.Title, c.Description, 
                               CASE WHEN e.EnrollmentID IS NOT NULL AND e.ExpiryDate > GETDATE() THEN 1 ELSE 0 END AS IsEnrolled
                        FROM Courses c
                        LEFT JOIN Enrollments e ON c.CourseID = e.CourseID AND e.UserID = @UserID
                        WHERE c.Title LIKE @SearchTerm ";
                }

                if (categoryFilter != "All")
                {
                    query += " AND (Title LIKE @Category OR Description LIKE @Category) ";
                }

                query += " ORDER BY DateAdded DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                    if (Session["UserID"] != null)
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                    }

                    if (categoryFilter != "All")
                    {
                        cmd.Parameters.AddWithValue("@Category", "%" + categoryFilter + "%");
                    }

                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            gvAllCourses.DataSource = reader;
                            gvAllCourses.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = "Error loading courses.";
                    }
                }
            }
        }

        private void LoadMyCourses()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT c.CourseID, c.Title, e.ExpiryDate
                    FROM Enrollments e
                    INNER JOIN Courses c ON e.CourseID = c.CourseID
                    WHERE e.UserID = @UserID AND e.ExpiryDate > GETDATE()
                    ORDER BY e.PurchaseDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());

                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            gvMyCourses.DataSource = reader;
                            gvMyCourses.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = "Error loading your courses.";
                    }
                }
            }
        }
    }
}