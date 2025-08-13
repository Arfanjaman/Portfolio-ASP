using System;
using System.Net.Mail;
using System.Web.UI;

namespace Portfolio_try_1
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string feedback = txtFeedback.Text.Trim();

            
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(email); 
                mail.To.Add("soraeshan6@gmail.com"); 
                mail.Subject = "Contact Form Feedback";
                mail.Body = $"Email: {email}\n\nMessage:\n{feedback}";

                SmtpClient smtp = new SmtpClient("pro.turbo-smtp.com"); 
                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential("soraeshan6@gmail.com", "1mHYsMgN");
                smtp.EnableSsl = true;
                smtp.Send(mail);

                Response.Write("<script>alert('Thank you for your feedback!');</script>");
                txtEmail.Text = "";
                txtFeedback.Text = "";
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error: {ex.Message}');</script>");
            }
        }
    }
}
