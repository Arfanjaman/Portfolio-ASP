<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Portfolio_try_1._Default" %>

 
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" type="text/css" href="~/Styles/Styles.css"/>
    <script src="Scripts/Default.js"></script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
         <main class="hero-section">
    <div class="hero-content">
      <div class="hero-text">
        <h1>Welcome to My Portfolio</h1>
        <div class="dynamic-text">
          <span class="typing-text"></span>
          <span class="cursor">|</span>
        </div>
        <p class="description">
          I am a passionate web developer and Computer Science Engineering undergraduate
           with a love for creating innovative digital solutions. 
          I specialize in modern web technologies and enjoy
           bringing creative ideas to life through code.
        </p>
      </div>
      <div class="hero-image">
         <img src="Images/profile_pic.jpg" alt="Profile Image" id="profileImage">
      </div>
    </div>
  </main>
  
  <!-- Modal for enlarged image -->
  <div id="imageModal" class="modal">
    <div class="modal-content">
      <span class="close">&times;</span>
      

      <img  id="modalImage" src="Images/profile_pic.jpg" alt="Enlarged Profile"/>

    </div>
  </div>

       
</asp:Content>

