using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Portfolio_try_1
{
    public partial class TestContact : System.Web.UI.Page
    {
        private string ConnectionString => ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CreateContactMessagesTable();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(message))
            {
                ShowMessage("Please fill in all fields.", "error");
                return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter a valid email address.", "error");
                return;
            }

            try
            {
                SaveContactMessage(email, message);
                ShowMessage("Thank you! Your message has been saved successfully. Check the admin panel to view it.", "success");
                
                // Clear form
                txtEmail.Text = "";
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                ShowMessage($"Error saving message: {ex.Message}", "error");
            }
        }

        private void CreateContactMessagesTable()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string createTableQuery = @"
                        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ContactMessages' AND xtype='U')
                        CREATE TABLE ContactMessages (
                            Id INT IDENTITY(1,1) PRIMARY KEY,
                            Email NVARCHAR(255) NOT NULL,
                            Message NVARCHAR(MAX) NOT NULL,
                            SubmittedDate DATETIME NOT NULL DEFAULT GETDATE(),
                            IsRead BIT NOT NULL DEFAULT 0,
                            AdminNotes NVARCHAR(MAX) NULL
                        )";

                    using (SqlCommand cmd = new SqlCommand(createTableQuery, con))
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error creating table: {ex.Message}", "error");
            }
        }

        private void SaveContactMessage(string email, string message)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string insertQuery = @"
                    INSERT INTO ContactMessages (Email, Message, SubmittedDate, IsRead) 
                    VALUES (@Email, @Message, @SubmittedDate, @IsRead)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Message", message);
                    cmd.Parameters.AddWithValue("@SubmittedDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@IsRead", false);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            pnlMessage.CssClass = type == "error" ? "message error" : "message success";
        }
    }
}