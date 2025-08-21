using System;
using System.Web;
using System.Web.UI;

namespace Portfolio_try_1
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // cheking if already logged in
            if (Session["IsAdminLoggedIn"] != null && (bool)Session["IsAdminLoggedIn"])
            {
                Response.Redirect("AdminDashboard.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            //name, password validation logic
            string adminUsername = "admin";
            string adminPassword = "portfolio123";

            if (username == adminUsername && password == adminPassword)
            {
               
                Session["IsAdminLoggedIn"] = true;
                Session["AdminUsername"] = username;
                Session["LoginTime"] = DateTime.Now;

             
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
               
                pnlError.Visible = true;
                lblError.Text = "Invalid username or password. Please try again.";
                
               
                txtPassword.Text = "";
            }
        }
    }
}