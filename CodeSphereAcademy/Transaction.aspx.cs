using System;
using System.Data.SqlClient;
using System.Configuration;

namespace CodeSphereAcademy
{
    public partial class Transaction : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["CodeSphereConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Register.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["CourseID"] != null)
                {
                    LoadCourseDetails(Request.QueryString["CourseID"]);
                }
                else
                {
                    Response.Redirect("Courses.aspx");
                }
            }
        }

        private void LoadCourseDetails(string courseId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Title FROM Courses WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    try
                    {
                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            lblCourseName.Text = result.ToString();
                        }
                        else
                        {
                            Response.Redirect("Courses.aspx");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("Courses.aspx");
                    }
                }
            }
        }

        protected void btnConfirmPayment_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["CourseID"];
            string userId = Session["UserID"].ToString();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO Enrollments (UserID, CourseID, PurchaseDate, ExpiryDate) VALUES (@UserID, @CourseID, GETDATE(), DATEADD(year, 1, GETDATE()))";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        pnlCheckout.Visible = false;
                        pnlSuccess.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        // Handle error quietly or display a label message if required
                    }
                }
            }
        }
    }
}