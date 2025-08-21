using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio_try_1
{
    public partial class AdminCredentials : System.Web.UI.Page
    {
        private string ConnectionString => ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;
        private bool IsEditMode => ViewState["EditMode"] != null && (bool)ViewState["EditMode"];
        private string EditingName => ViewState["EditingName"]?.ToString();

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
                LoadCredentials();
            }
        }

        private void LoadCredentials()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "SELECT Name, Platform, IssueDate, Description, ImagePath, VerificationLink FROM Credentials ORDER BY IssueDate DESC";
                    using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvCredentials.DataSource = dt;
                        gvCredentials.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading credentials: {ex.Message}", "error");
            }
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ShowCredentialForm(false);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadCredentials();
            HideCredentialForm();
            ShowMessage("Credentials refreshed successfully!", "success");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }

        protected void gvCredentials_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCredentials.PageIndex = e.NewPageIndex;
            LoadCredentials();
        }

        protected void gvCredentials_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string name = e.CommandArgument.ToString();

            if (e.CommandName == "EditCredential")
            {
                LoadCredentialForEdit(name);
            }
            else if (e.CommandName == "DeleteCredential")
            {
                DeleteCredential(name);
            }
        }

        private void LoadCredentialForEdit(string name)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "SELECT * FROM Credentials WHERE Name = @Name";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        con.Open();
                        
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtName.Text = reader["Name"].ToString();
                                txtPlatform.Text = reader["Platform"].ToString();
                                
                                if (reader["IssueDate"] != DBNull.Value)
                                {
                                    DateTime issueDate = Convert.ToDateTime(reader["IssueDate"]);
                                    txtIssueDate.Text = issueDate.ToString("yyyy-MM-dd");
                                }
                                
                                txtDescription.Text = reader["Description"].ToString();
                                txtImagePath.Text = reader["ImagePath"].ToString();
                                txtVerificationLink.Text = reader["VerificationLink"].ToString();
                                
                                ShowCredentialForm(true, name);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading credential for edit: {ex.Message}", "error");
            }
        }

        private void DeleteCredential(string name)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "DELETE FROM Credentials WHERE Name = @Name";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        con.Open();
                        
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ShowMessage($"Credential '{name}' deleted successfully!", "success");
                            LoadCredentials();
                        }
                        else
                        {
                            ShowMessage("Credential not found or could not be deleted.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting credential: {ex.Message}", "error");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                if (IsEditMode)
                {
                    UpdateCredential();
                }
                else
                {
                    AddCredential();
                }
            }
        }

        private bool ValidateForm()
        {
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                ShowMessage("Credential name is required.", "error");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtPlatform.Text))
            {
                ShowMessage("Platform is required.", "error");
                return false;
            }

            return true;
        }

        private void AddCredential()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"INSERT INTO Credentials (Name, Platform, IssueDate, Description, ImagePath, VerificationLink) 
                                   VALUES (@Name, @Platform, @IssueDate, @Description, @ImagePath, @VerificationLink)";
                    
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Platform", txtPlatform.Text.Trim());
                        
                        if (!string.IsNullOrWhiteSpace(txtIssueDate.Text))
                        {
                            cmd.Parameters.AddWithValue("@IssueDate", DateTime.Parse(txtIssueDate.Text));
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@IssueDate", DBNull.Value);
                        }
                        
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@ImagePath", txtImagePath.Text.Trim());
                        cmd.Parameters.AddWithValue("@VerificationLink", txtVerificationLink.Text.Trim());
                        
                        con.Open();
                        cmd.ExecuteNonQuery();
                        
                        ShowMessage("Credential added successfully!", "success");
                        LoadCredentials();
                        HideCredentialForm();
                        ClearForm();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error adding credential: {ex.Message}", "error");
            }
        }

        private void UpdateCredential()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"UPDATE Credentials SET 
                                   Name = @NewName, Platform = @Platform, IssueDate = @IssueDate, 
                                   Description = @Description, ImagePath = @ImagePath, VerificationLink = @VerificationLink 
                                   WHERE Name = @OldName";
                    
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@NewName", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Platform", txtPlatform.Text.Trim());
                        
                        if (!string.IsNullOrWhiteSpace(txtIssueDate.Text))
                        {
                            cmd.Parameters.AddWithValue("@IssueDate", DateTime.Parse(txtIssueDate.Text));
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@IssueDate", DBNull.Value);
                        }
                        
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@ImagePath", txtImagePath.Text.Trim());
                        cmd.Parameters.AddWithValue("@VerificationLink", txtVerificationLink.Text.Trim());
                        cmd.Parameters.AddWithValue("@OldName", EditingName);
                        
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        
                        if (rowsAffected > 0)
                        {
                            ShowMessage("Credential updated successfully!", "success");
                            LoadCredentials();
                            HideCredentialForm();
                            ClearForm();
                        }
                        else
                        {
                            ShowMessage("Credential not found or could not be updated.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error updating credential: {ex.Message}", "error");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            HideCredentialForm();
            ClearForm();
        }

        private void ShowCredentialForm(bool editMode, string editingName = null)
        {
            pnlCredentialForm.Visible = true;
            ViewState["EditMode"] = editMode;
            ViewState["EditingName"] = editingName;
            
            lblFormTitle.Text = editMode ? "Edit Credential" : "Add New Credential";
            btnSave.Text = editMode ? "Update Credential" : "Save Credential";
        }

        private void HideCredentialForm()
        {
            pnlCredentialForm.Visible = false;
            ViewState["EditMode"] = null;
            ViewState["EditingName"] = null;
        }

        private void ClearForm()
        {
            txtName.Text = "";
            txtPlatform.Text = "";
            txtIssueDate.Text = "";
            txtDescription.Text = "";
            txtImagePath.Text = "";
            txtVerificationLink.Text = "";
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