<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Portfolio_try_1.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        
        .contact-container {
            width: 50%;
            margin: 50px auto;
            text-align: center;
            background-color: #f8f8f8;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

       
            .contact-container label {
                display: block;
                
                text-align: left;
                font-size: 16px;
                font-weight: bold;
                margin-top: 15px;
                margin-bottom: 5px;
            }

        
        .contact-container input[type="text"], 
        .contact-container textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            margin-bottom: 15px;
        }

        
        .contact-container textarea {
            height: 150px;
            resize: vertical;
        }

       
        .contact-container input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .contact-container input[type="submit"]:hover {
            background-color: #45a049;
        }
        h2{
             color: #333;
            margin-bottom: 20px;
        }
        
        .ltext {
            font-size: 16px;
            color: #333;
            margin-bottom: 10px;
        }
        @media (max-width: 760px) {
            .contact-container {
                width: 80%;
            
            }

        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contact-container">
        <h2>Contact Us</h2>

        <asp:Label ID="LabelEmail" runat="server" Text="Your Email" CssClass="ltext"></asp:Label>
        <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email" ></asp:TextBox>

        <asp:Label ID="LabelFeedback" runat="server" Text="Your Feedback / Comments" CssClass="ltext"></asp:Label>
        <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" placeholder="Type your message here"></asp:TextBox>

        <asp:Button ID="btnSubmit" runat="server" Text="Send" OnClick="btnSubmit_Click" />
    </div>
</asp:Content>
