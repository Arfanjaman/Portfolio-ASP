using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Portfolio_try_1
{
    public partial class Credentials : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCredentials();
            }
        }

        private void BindCredentials()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT Name, Platform, IssueDate, Description, ImagePath, VerificationLink FROM Credentials";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    rptCredentials.DataSource = dr;
                    rptCredentials.DataBind();
                }
            }
        }

        protected void rptCredentials_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Verify")
            {
                string verificationUrl = e.CommandArgument.ToString();

                // Open verification link in a new tab
                Response.Redirect(verificationUrl, false);
            }
        }
    }
}