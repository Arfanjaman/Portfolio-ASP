using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio_try_1
{
    public partial class AdminSkills : System.Web.UI.Page
    {
        private string ConnectionString => ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;
        private bool IsEditMode => ViewState["EditMode"] != null && (bool)ViewState["EditMode"];
        private string EditingSkillName => ViewState["EditingSkillName"]?.ToString();

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
                LoadSkills();
            }
        }

        private void LoadSkills()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"SELECT Skill_name, Skill_Type, Proficiency FROM Skills 
                                   ORDER BY Skill_Type, Proficiency DESC";
                    using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvSkills.DataSource = dt;
                        gvSkills.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading skills: {ex.Message}", "error");
            }
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ShowSkillForm(false);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadSkills();
            HideSkillForm();
            ShowMessage("Skills refreshed successfully!", "success");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }

        protected void gvSkills_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSkills.PageIndex = e.NewPageIndex;
            LoadSkills();
        }

        protected void gvSkills_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string skillName = e.CommandArgument.ToString();

            if (e.CommandName == "EditSkill")
            {
                LoadSkillForEdit(skillName);
            }
            else if (e.CommandName == "DeleteSkill")
            {
                DeleteSkill(skillName);
            }
        }

        private void LoadSkillForEdit(string skillName)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "SELECT * FROM Skills WHERE Skill_name = @SkillName";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SkillName", skillName);
                        con.Open();
                        
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtSkillName.Text = reader["Skill_name"].ToString();
                                ddlSkillType.SelectedValue = reader["Skill_Type"].ToString();
                                txtProficiency.Text = reader["Proficiency"].ToString();
                                
                                ShowSkillForm(true, skillName);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading skill for edit: {ex.Message}", "error");
            }
        }

        private void DeleteSkill(string skillName)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = "DELETE FROM Skills WHERE Skill_name = @SkillName";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SkillName", skillName);
                        con.Open();
                        
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ShowMessage($"Skill '{skillName}' deleted successfully!", "success");
                            LoadSkills();
                        }
                        else
                        {
                            ShowMessage("Skill not found or could not be deleted.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting skill: {ex.Message}", "error");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                if (IsEditMode)
                {
                    UpdateSkill();
                }
                else
                {
                    AddSkill();
                }
            }
        }

        private bool ValidateForm()
        {
            if (string.IsNullOrWhiteSpace(txtSkillName.Text))
            {
                ShowMessage("Skill name is required.", "error");
                return false;
            }

            if (string.IsNullOrWhiteSpace(ddlSkillType.SelectedValue))
            {
                ShowMessage("Please select a skill type.", "error");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtProficiency.Text))
            {
                ShowMessage("Proficiency level is required.", "error");
                return false;
            }

            int proficiency;
            if (!int.TryParse(txtProficiency.Text, out proficiency) || proficiency < 1 || proficiency > 100)
            {
                ShowMessage("Proficiency must be a number between 1 and 100.", "error");
                return false;
            }

            return true;
        }

        private void AddSkill()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"INSERT INTO Skills (Skill_name, Skill_Type, Proficiency) 
                                   VALUES (@SkillName, @SkillType, @Proficiency)";
                    
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SkillName", txtSkillName.Text.Trim());
                        cmd.Parameters.AddWithValue("@SkillType", ddlSkillType.SelectedValue);
                        cmd.Parameters.AddWithValue("@Proficiency", int.Parse(txtProficiency.Text));
                        
                        con.Open();
                        cmd.ExecuteNonQuery();
                        
                        ShowMessage("Skill added successfully!", "success");
                        LoadSkills();
                        HideSkillForm();
                        ClearForm();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error adding skill: {ex.Message}", "error");
            }
        }

        private void UpdateSkill()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"UPDATE Skills SET 
                                   Skill_name = @NewSkillName, Skill_Type = @SkillType, Proficiency = @Proficiency 
                                   WHERE Skill_name = @OldSkillName";
                    
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@NewSkillName", txtSkillName.Text.Trim());
                        cmd.Parameters.AddWithValue("@SkillType", ddlSkillType.SelectedValue);
                        cmd.Parameters.AddWithValue("@Proficiency", int.Parse(txtProficiency.Text));
                        cmd.Parameters.AddWithValue("@OldSkillName", EditingSkillName);
                        
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        
                        if (rowsAffected > 0)
                        {
                            ShowMessage("Skill updated successfully!", "success");
                            LoadSkills();
                            HideSkillForm();
                            ClearForm();
                        }
                        else
                        {
                            ShowMessage("Skill not found or could not be updated.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error updating skill: {ex.Message}", "error");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            HideSkillForm();
            ClearForm();
        }

        private void ShowSkillForm(bool editMode, string editingSkillName = null)
        {
            pnlSkillForm.Visible = true;
            ViewState["EditMode"] = editMode;
            ViewState["EditingSkillName"] = editingSkillName;
            
            lblFormTitle.Text = editMode ? "Edit Skill" : "Add New Skill";
            btnSave.Text = editMode ? "Update Skill" : "Save Skill";
        }

        private void HideSkillForm()
        {
            pnlSkillForm.Visible = false;
            ViewState["EditMode"] = null;
            ViewState["EditingSkillName"] = null;
        }

        private void ClearForm()
        {
            txtSkillName.Text = "";
            ddlSkillType.SelectedIndex = 0;
            txtProficiency.Text = "";
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