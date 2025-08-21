using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Portfolio_try_1
{
    public partial class AdminQuery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated
            if (Session["IsAdminLoggedIn"] == null || !(bool)Session["IsAdminLoggedIn"])
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }
        }

        protected void btnExecute_Click(object sender, EventArgs e)
        {
            string query = txtQuery.Text.Trim();
            
            if (string.IsNullOrEmpty(query))
            {
                ShowMessage("Please enter a SQL query.", "error");
                return;
            }

            try
            {
                ExecuteQuery(query);
            }
            catch (Exception ex)
            {
                ShowMessage($"Error executing query: {ex.Message}", "error");
            }
        }

        private void ExecuteQuery(string query)
        {
            string connStr = ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;
            
            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    
                    // Determine if it's a SELECT query or modification query
                    string queryType = query.Trim().Substring(0, 6).ToUpper();
                    
                    if (queryType == "SELECT")
                    {
                        // Execute SELECT query
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            
                            if (dt.Rows.Count > 0)
                            {
                                gvResults.DataSource = dt;
                                gvResults.DataBind();
                                
                                lblRowCount.Text = $"Query returned {dt.Rows.Count} row(s).";
                                pnlResults.Visible = true;
                                ShowMessage("Query executed successfully!", "success");
                            }
                            else
                            {
                                pnlResults.Visible = false;
                                ShowMessage("Query executed successfully but returned no results.", "success");
                            }
                        }
                    }
                    else
                    {
                        // Execute INSERT, UPDATE, DELETE, etc.
                        int rowsAffected = cmd.ExecuteNonQuery();
                        pnlResults.Visible = false;
                        ShowMessage($"Query executed successfully! {rowsAffected} row(s) affected.", "success");
                    }
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtQuery.Text = "";
            pnlResults.Visible = false;
            pnlMessage.Visible = false;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("AdminLogin.aspx");
        }

        protected void gvResults_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvResults.PageIndex = e.NewPageIndex;
            
            // Re-execute the query to populate the new page
            if (!string.IsNullOrEmpty(txtQuery.Text.Trim()))
            {
                try
                {
                    ExecuteQuery(txtQuery.Text.Trim());
                }
                catch (Exception ex)
                {
                    ShowMessage($"Error loading page: {ex.Message}", "error");
                }
            }
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