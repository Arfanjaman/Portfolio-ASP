using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Portfolio_try_1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProjects();
            }
        }

        private void BindProjects()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PortfolioConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT Title, Description, ImagePath, TechStack, Tags AS Tags, GitHubURL,AOSDelay FROM Projects";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    rptProjects.DataSource = cmd.ExecuteReader();
                    rptProjects.DataBind();
                }
            }
        }
    }
}
