using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio_try_1
{
    public partial class AdminProjects : System.Web.UI.Page
    {
        private string ConnectionString => ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;
        private bool IsEditMode => ViewState["EditMode"] != null && (bool)ViewState["EditMode"];
        private string EditingTitle => ViewState["EditingTitle"]?.ToString();

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
                LoadProjects();
            }
        }
        //loading from database
        private void LoadProjects()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "SELECT Title, Description, ImagePath, TechStack, Tags, GitHubURL FROM Projects ORDER BY Title";
                    using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvProjects.DataSource = dt;
                        gvProjects.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading projects: {ex.Message}", "error");
            }
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ShowProjectForm(false);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadProjects();
            HideProjectForm();
            ShowMessage("Projects refreshed successfully!", "success");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }

        protected void gvProjects_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProjects.PageIndex = e.NewPageIndex;
            LoadProjects();
        }

        protected void gvProjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string title = e.CommandArgument.ToString();

            if (e.CommandName == "EditProject")
            {
                LoadProjectForEdit(title);
            }
            else if (e.CommandName == "DeleteProject")
            {
                DeleteProject(title);
            }
        }

        private void LoadProjectForEdit(string title)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "SELECT * FROM Projects WHERE Title = @Title";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        con.Open();
                        
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtTitle.Text = reader["Title"].ToString();
                                txtDescription.Text = reader["Description"].ToString();
                                txtImagePath.Text = reader["ImagePath"].ToString();
                                txtTechStack.Text = reader["TechStack"].ToString();
                                txtTags.Text = reader["Tags"].ToString();
                                txtGitHubURL.Text = reader["GitHubURL"].ToString();
                                
                                ShowProjectForm(true, title);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading project for edit: {ex.Message}", "error");
            }
        }

        private void DeleteProject(string title)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "DELETE FROM Projects WHERE Title = @Title";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        con.Open();
                        
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ShowMessage($"Project '{title}' deleted successfully!", "success");
                            LoadProjects();
                        }
                        else
                        {
                            ShowMessage("Project not found or could not be deleted.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting project: {ex.Message}", "error");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                if (IsEditMode)
                {
                    UpdateProject();
                }
                else
                {
                    AddProject();
                }
            }
        }
        //to validate the values of added project
        private bool ValidateForm()
        {
            if (string.IsNullOrWhiteSpace(txtTitle.Text))
            {
                ShowMessage("Title is required.", "error");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtDescription.Text))
            {
                ShowMessage("Description is required.", "error");
                return false;
            }

            return true;
        }

        private void AddProject()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"INSERT INTO Projects (Title, Description, ImagePath, TechStack, Tags, GitHubURL, AOSDelay) 
                                   VALUES (@Title, @Description, @ImagePath, @TechStack, @Tags, @GitHubURL, @AOSDelay)";
                    
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@ImagePath", txtImagePath.Text.Trim());
                        cmd.Parameters.AddWithValue("@TechStack", txtTechStack.Text.Trim());
                        cmd.Parameters.AddWithValue("@Tags", txtTags.Text.Trim());
                        cmd.Parameters.AddWithValue("@GitHubURL", txtGitHubURL.Text.Trim());
                        cmd.Parameters.AddWithValue("@AOSDelay", 0); 
                        
                        con.Open();
                        cmd.ExecuteNonQuery();
                        
                        ShowMessage("Project added successfully!", "success");
                        LoadProjects();
                        HideProjectForm();
                        ClearForm();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error adding project: {ex.Message}", "error");
            }
        }

        private void UpdateProject()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"UPDATE Projects SET 
                                   Title = @NewTitle, Description = @Description, ImagePath = @ImagePath, 
                                   TechStack = @TechStack, Tags = @Tags, GitHubURL = @GitHubURL 
                                   WHERE Title = @OldTitle";
                    
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@NewTitle", txtTitle.Text.Trim());
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@ImagePath", txtImagePath.Text.Trim());
                        cmd.Parameters.AddWithValue("@TechStack", txtTechStack.Text.Trim());
                        cmd.Parameters.AddWithValue("@Tags", txtTags.Text.Trim());
                        cmd.Parameters.AddWithValue("@GitHubURL", txtGitHubURL.Text.Trim());
                        cmd.Parameters.AddWithValue("@OldTitle", EditingTitle);
                        
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        
                        if (rowsAffected > 0)
                        {
                            ShowMessage("Project updated successfully!", "success");
                            LoadProjects();
                            HideProjectForm();
                            ClearForm();
                        }
                        else
                        {
                            ShowMessage("Project not found or could not be updated.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error updating project: {ex.Message}", "error");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            HideProjectForm();
            ClearForm();
        }

        private void ShowProjectForm(bool editMode, string editingTitle = null)
        {
            pnlProjectForm.Visible = true;
            ViewState["EditMode"] = editMode;
            ViewState["EditingTitle"] = editingTitle;
            
            lblFormTitle.Text = editMode ? "Edit Project" : "Add New Project";
            btnSave.Text = editMode ? "Update Project" : "Save Project";
        }

        private void HideProjectForm()
        {
            pnlProjectForm.Visible = false;
            ViewState["EditMode"] = null;
            ViewState["EditingTitle"] = null;
        }

        private void ClearForm()
        {
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtImagePath.Text = "";
            txtTechStack.Text = "";
            txtTags.Text = "";
            txtGitHubURL.Text = "";
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