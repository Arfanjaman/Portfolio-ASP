<%@ Page Title="Skills" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Skills.aspx.cs" Inherits="Portfolio_try_1.Skills" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Styles/Skills.css" rel="stylesheet" />
    <script src="Scripts/Skills.js"></script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="skills-section">
        <div class="skills-container">
            <h1>My Skills</h1>
            <p class="skills-intro">Here are the technologies and tools I work with</p>
            
            <div class="skills-grid" id="skillsContainer" runat="server">
                <!-- Generated from C# file -->
            </div>
        </div>
    </main>
</asp:Content>