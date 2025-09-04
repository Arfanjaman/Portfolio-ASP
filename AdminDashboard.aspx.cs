using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Portfolio_try_1
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // authentication check
            if (Session["IsAdminLoggedIn"] == null || !(bool)Session["IsAdminLoggedIn"])
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            try
            {
                
                lblUsername.Text = Session["AdminUsername"]?.ToString() ?? "Admin";
                lblLastLogin.Text = DateTime.Now.ToString("MMM dd, yyyy hh:mm tt");
                lblSessionStart.Text = Session["LoginTime"]?.ToString() ?? DateTime.Now.ToString("MMM dd, yyyy hh:mm tt");

               
                LoadCounts();
                
                lblDatabaseStatus.Text = "Connected";
            }
            catch (Exception ex)
            {
                lblDatabaseStatus.Text = "Connection Error: " + ex.Message;
            }
        }
        //loading database counts
        private void LoadCounts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;
            
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                
                
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Projects", con))
                {
                    lblProjectsCount.Text = cmd.ExecuteScalar().ToString();
                }
                
                
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Credentials", con))
                {
                    lblCredentialsCount.Text = cmd.ExecuteScalar().ToString();
                }
                
              
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Skills", con))
                {
                    lblSkillsCount.Text = cmd.ExecuteScalar().ToString();
                }

                // Add contact messages count
                try
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages", con))
                    {
                        if (lblMessagesCount != null)
                            lblMessagesCount.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Unread messages count
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages WHERE IsRead = 0", con))
                    {
                        if (lblUnreadMessagesCount != null)
                            lblUnreadMessagesCount.Text = cmd.ExecuteScalar().ToString();
                    }
                }
                catch
                {
                    // ContactMessages table might not exist yet
                    if (lblMessagesCount != null) lblMessagesCount.Text = "0";
                    if (lblUnreadMessagesCount != null) lblUnreadMessagesCount.Text = "0";
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }
    }
}