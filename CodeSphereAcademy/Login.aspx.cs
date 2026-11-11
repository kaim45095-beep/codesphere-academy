using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CodeSphereAcademy
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If a user is already logged in, redirect them away from the login page
            if (Session["UserID"] != null)
            {
                RedirectUserBasedOnRole(Session["Role"].ToString());
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    // Query to check if the user exists and retrieve their details
                    string query = "SELECT UserID, FullName, Role FROM Users WHERE Email = @Email AND Password = @Password";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    // Authentication successful! Create Session variables.
                                    Session["UserID"] = reader["UserID"].ToString();
                                    Session["FullName"] = reader["FullName"].ToString();
                                    Session["Role"] = reader["Role"].ToString();

                                    // Redirect based on authorization level
                                    RedirectUserBasedOnRole(Session["Role"].ToString());
                                }
                                else
                                {
                                    // Authentication failed
                                    lblError.Text = "Invalid email or password.";
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            lblError.Text = "A database error occurred. Please try again later.";
                            // In a real app, log the actual exception (ex.Message)
                        }
                    }
                }
            }
        }

        private void RedirectUserBasedOnRole(string role)
        {
            if (role == "Admin")
            {
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                Response.Redirect("LearnerDashboard.aspx");
            }
        }
    }
}