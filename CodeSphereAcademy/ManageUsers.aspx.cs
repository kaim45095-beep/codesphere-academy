using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace CodeSphereAcademy
{
    public partial class ManageUsers : System.Web.UI.Page
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
                LoadUsersGrid("");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadUsersGrid(txtSearchEmail.Text.Trim());
        }

        private void LoadUsersGrid(string searchEmail)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT UserID, FullName, Email, Role, DateOfBirth FROM Users WHERE Email LIKE @Email ORDER BY Role, FullName";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", "%" + searchEmail + "%");

                    try
                    {
                        conn.Open();
                        gvUsers.DataSource = cmd.ExecuteReader();
                        gvUsers.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "Error loading users.";
                        lblStatus.CssClass = "status-msg error";
                    }
                }
            }
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            LoadUsersGrid(txtSearchEmail.Text.Trim()); // Maintain search filter while editing
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            LoadUsersGrid(txtSearchEmail.Text.Trim());
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int selectedUserID = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvUsers.Rows[e.RowIndex];

            string updatedName = ((TextBox)row.Cells[1].Controls[0]).Text.Trim();
            string updatedEmail = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();
            TextBox txtEditDOB = (TextBox)row.FindControl("txtEditDOB");

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE Users SET FullName = @FullName, Email = @Email, DateOfBirth = @DateOfBirth WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", updatedName);
                    cmd.Parameters.AddWithValue("@Email", updatedEmail);
                    cmd.Parameters.AddWithValue("@UserID", selectedUserID);

                    if (string.IsNullOrEmpty(txtEditDOB.Text))
                    {
                        cmd.Parameters.AddWithValue("@DateOfBirth", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@DateOfBirth", txtEditDOB.Text);
                    }

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        lblStatus.Text = "User details updated successfully.";
                        lblStatus.CssClass = "status-msg success";
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "Error updating user details. Email might already be in use.";
                        lblStatus.CssClass = "status-msg error";
                    }
                }
            }

            gvUsers.EditIndex = -1;
            LoadUsersGrid(txtSearchEmail.Text.Trim());
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int selectedUserID = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            if (selectedUserID.ToString() == Session["UserID"].ToString())
            {
                lblStatus.Text = "Action denied: You cannot delete your own active session account.";
                lblStatus.CssClass = "status-msg error";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string deleteEnrollmentsQuery = "DELETE FROM Enrollments WHERE UserID = @UserID";
                string deleteUserQuery = "DELETE FROM Users WHERE UserID = @UserID";

                try
                {
                    conn.Open();
                    using (SqlCommand cmd1 = new SqlCommand(deleteEnrollmentsQuery, conn))
                    {
                        cmd1.Parameters.AddWithValue("@UserID", selectedUserID);
                        cmd1.ExecuteNonQuery();
                    }

                    using (SqlCommand cmd2 = new SqlCommand(deleteUserQuery, conn))
                    {
                        cmd2.Parameters.AddWithValue("@UserID", selectedUserID);
                        cmd2.ExecuteNonQuery();
                    }

                    lblStatus.Text = "User removed successfully.";
                    lblStatus.CssClass = "status-msg success";
                    LoadUsersGrid(txtSearchEmail.Text.Trim());
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "Error removing user.";
                    lblStatus.CssClass = "status-msg error";
                }
            }
        }
    }
}