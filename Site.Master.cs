using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Portfolio_try_1
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get current page name
            string currentPage = System.IO.Path.GetFileName(Request.Url.LocalPath);
            
            // Add active class to current page link (if you want to do it server-side)
            // This is optional - you can also handle it with JavaScript
        }
    }
}