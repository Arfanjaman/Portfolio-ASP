using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio_try_1
{
    public partial class AdminMessages : System.Web.UI.Page
    {
        private string ConnectionString => ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check authentication
            if (Session["IsAdminLoggedIn"] == null || !(bool)Session["IsAdminLoggedIn"])
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadMessages();
                LoadStatistics();
            }
        }

        private void LoadMessages()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"
                        SELECT Id, Email, Message, SubmittedDate, IsRead, AdminNotes 
                        FROM ContactMessages 
                        ORDER BY SubmittedDate DESC";

                    using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptMessages.DataSource = dt;
                            rptMessages.DataBind();
                            pnlNoMessages.Visible = false;
                        }
                        else
                        {
                            rptMessages.DataSource = null;
                            rptMessages.DataBind();
                            pnlNoMessages.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading messages: {ex.Message}", "error");
            }
        }

        private void LoadStatistics()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    con.Open();

                    // Total messages
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages", con))
                    {
                        lblTotalMessages.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Unread messages
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages WHERE IsRead = 0", con))
                    {
                        lblUnreadMessages.Text = cmd.ExecuteScalar().ToString();
                    }

                    // Today's messages
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM ContactMessages WHERE CAST(SubmittedDate AS DATE) = CAST(GETDATE() AS DATE)", con))
                    {
                        lblTodayMessages.Text = cmd.ExecuteScalar().ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading statistics: {ex.Message}", "error");
            }
        }

        protected void rptMessages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int messageId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "ViewMessage":
                    ViewMessage(messageId);
                    break;
                case "ToggleRead":
                    ToggleReadStatus(messageId);
                    break;
                case "DeleteMessage":
                    DeleteMessage(messageId);
                    break;
            }
        }

        private void ViewMessage(int messageId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "SELECT * FROM ContactMessages WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string email = reader["Email"].ToString();
                                string message = reader["Message"].ToString().Replace("'", "\\'").Replace("\n", "\\n").Replace("\r", "");
                                string date = Convert.ToDateTime(reader["SubmittedDate"]).ToString("MMM dd, yyyy hh:mm tt");
                                bool isRead = Convert.ToBoolean(reader["IsRead"]);

                                // Mark as read when viewed
                                if (!isRead)
                                {
                                    MarkAsRead(messageId);
                                }

                                // Show modal with JavaScript
                                string script = $"showMessageDetails({messageId}, '{email}', '{message}', '{date}', {isRead.ToString().ToLower()});";
                                ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);
                            }
                        }
                    }
                }

                LoadMessages();
                LoadStatistics();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error viewing message: {ex.Message}", "error");
            }
        }

        private void ToggleReadStatus(int messageId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    // First get current status
                    string getStatusQuery = "SELECT IsRead FROM ContactMessages WHERE Id = @Id";
                    bool currentStatus;

                    using (SqlCommand cmd = new SqlCommand(getStatusQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        con.Open();
                        currentStatus = Convert.ToBoolean(cmd.ExecuteScalar());
                    }

                    // Toggle the status
                    string updateQuery = "UPDATE ContactMessages SET IsRead = @IsRead WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        cmd.Parameters.AddWithValue("@IsRead", !currentStatus);
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadMessages();
                LoadStatistics();
                ShowMessage("Message status updated successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error updating message status: {ex.Message}", "error");
            }
        }

        private void DeleteMessage(int messageId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "DELETE FROM ContactMessages WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        con.Open();

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ShowMessage("Message deleted successfully!", "success");
                            LoadMessages();
                            LoadStatistics();
                        }
                        else
                        {
                            ShowMessage("Message not found or could not be deleted.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting message: {ex.Message}", "error");
            }
        }

        private void MarkAsRead(int messageId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "UPDATE ContactMessages SET IsRead = 1 WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error but don't show to user since this is automatic
                System.Diagnostics.Debug.WriteLine($"Error marking message as read: {ex.Message}");
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadMessages();
            LoadStatistics();
            ShowMessage("Messages refreshed successfully!", "success");
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "UPDATE ContactMessages SET IsRead = 1 WHERE IsRead = 0";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        ShowMessage($"Marked {rowsAffected} messages as read!", "success");
                    }
                }

                LoadMessages();
                LoadStatistics();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error marking all messages as read: {ex.Message}", "error");
            }
        }

        protected void btnDeleteOld_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "DELETE FROM ContactMessages WHERE SubmittedDate < DATEADD(day, -30, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        ShowMessage($"Deleted {rowsAffected} old messages!", "success");
                    }
                }

                LoadMessages();
                LoadStatistics();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting old messages: {ex.Message}", "error");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;

            if (type == "error")
            {
                pnlMessage.CssClass = "error-message";
            }
            else if (type == "success")
            {
                pnlMessage.CssClass = "success-message";
            }
        }
    }
}