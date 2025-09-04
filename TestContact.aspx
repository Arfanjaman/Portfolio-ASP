<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestContact.aspx.cs" Inherits="Portfolio_try_1.TestContact" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Test Contact Form</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 600px; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        textarea { height: 100px; resize: vertical; }
        .btn { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #0056b3; }
        .message { padding: 10px; margin: 10px 0; border-radius: 4px; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Test Contact Form (Database Version)</h1>
            <p>This form saves messages to the database instead of sending emails.</p>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <div class="form-group">
                <label for="txtEmail">Email Address:</label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="your.email@example.com"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label for="txtMessage">Message:</label>
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" placeholder="Enter your message here..."></asp:TextBox>
            </div>
            
            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn" OnClick="btnSubmit_Click" />
            
            <hr style="margin: 30px 0;" />
            
            <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px;">
                <h3>How it works:</h3>
                <ol>
                    <li>Fill out the form above and click "Send Message"</li>
                    <li>Your message will be saved to the ContactMessages table in the database</li>
                    <li>Go to <a href="AdminLogin.aspx" target="_blank">Admin Login</a> (admin/portfolio123)</li>
                    <li>Navigate to "Contact Messages" to view all submissions</li>
                    <li>You can mark messages as read/unread, delete them, or reply via email</li>
                </ol>
            </div>
        </div>
    </form>
</body>
</html>