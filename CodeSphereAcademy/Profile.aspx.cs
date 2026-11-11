using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CodeSphereAcademy
{
    public partial class Profile : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT FullName, Email, DateOfBirth FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());

                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtFullName.Text = reader["FullName"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                                if (reader["DateOfBirth"] != DBNull.Value)
                                {
                                    txtDOB.Text = Convert.ToDateTime(reader["DateOfBirth"]).ToString("yyyy-MM-dd");
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "Error loading profile data.";
                        lblStatus.CssClass = "error-text";
                    }
                }

                string courseQuery = @"SELECT c.Title, e.PurchaseDate, e.ExpiryDate 
                                       FROM Enrollments e 
                                       INNER JOIN Courses c ON e.CourseID = c.CourseID 
                                       WHERE e.UserID = @UserID AND e.ExpiryDate > GETDATE()";
                using (SqlCommand cmdCourses = new SqlCommand(courseQuery, conn))
                {
                    cmdCourses.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                    gvMyCourses.DataSource = cmdCourses.ExecuteReader();
                    gvMyCourses.DataBind();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "UPDATE Users SET FullName = @FullName";
                    if (!string.IsNullOrEmpty(txtPassword.Text))
                    {
                        query += ", Password = @Password";
                    }
                    query += " WHERE UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());

                        if (!string.IsNullOrEmpty(txtPassword.Text))
                        {
                            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                        }

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();

                            Session["FullName"] = txtFullName.Text.Trim();
                            lblStatus.Text = "Profile updated successfully!";
                            lblStatus.CssClass = "success-text";
                        }
                        catch (Exception ex)
                        {
                            lblStatus.Text = "An error occurred while updating.";
                            lblStatus.CssClass = "error-text";
                        }
                    }
                }
            }
        }
    }
}