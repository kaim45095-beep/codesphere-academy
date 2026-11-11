using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CodeSphereAcademy
{
    public partial class Register : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string today = DateTime.Now.ToString("yyyy-MM-dd");
                txtDOB.Attributes["max"] = today;
                rvDOB.MaximumValue = today;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // 1. Strict Server-Side Check for Terms and Conditions
            if (!chkTerms.Checked)
            {
                lblMessage.Text = "You must agree to the Terms and Conditions.";
                lblMessage.CssClass = "error-text";
                return; // Stop execution
            }

            if (Page.IsValid)
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        conn.Open();
                        int userExists = (int)checkCmd.ExecuteScalar();

                        if (userExists > 0)
                        {
                            lblMessage.Text = "Email is already registered. Please login or use a different email.";
                            lblMessage.CssClass = "error-text";
                            return;
                        }
                    }

                    string query = "INSERT INTO Users (FullName, Email, Password, Role, DateOfBirth) VALUES (@FullName, @Email, @Password, 'Learner', @DateOfBirth); SELECT SCOPE_IDENTITY();";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                        cmd.Parameters.AddWithValue("@DateOfBirth", txtDOB.Text);

                        try
                        {
                            int newUserId = Convert.ToInt32(cmd.ExecuteScalar());

                            Session["UserID"] = newUserId.ToString();
                            Session["FullName"] = txtFullName.Text.Trim();
                            Session["Role"] = "Learner";

                            Response.Redirect("LearnerDashboard.aspx");
                        }
                        catch (Exception ex)
                        {
                            lblMessage.Text = "Registration failed. Please try again.";
                            lblMessage.CssClass = "error-text";
                        }
                    }
                }
            }
        }
    }
}