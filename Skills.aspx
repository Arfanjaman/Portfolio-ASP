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
      
      <div class="skills-grid">
        <!-- Frontend Skills -->
        <div class="skill-category">
          <h2>Frontend Development</h2>
          <div class="skills-list">
            <div class="skill-item">
              <span class="skill-name">HTML5</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="90"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">CSS3</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="85"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">JavaScript</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="80"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">React</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="75"></div>
              </div>
            </div>
          </div>
        </div>

        <!-- Backend Skills -->
        <div class="skill-category">
          <h2>Backend Development</h2>
          <div class="skills-list">
            <div class="skill-item">
              <span class="skill-name">Node.js</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="70"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">Python</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="75"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">Java</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="65"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">SQL</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="70"></div>
              </div>
            </div>
          </div>
        </div>

        <!-- Tools & Others -->
        <div class="skill-category">
          <h2>Tools & Technologies</h2>
          <div class="skills-list">
            <div class="skill-item">
              <span class="skill-name">Git & GitHub</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="80"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">VS Code</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="90"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">Figma</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="60"></div>
              </div>
            </div>
            <div class="skill-item">
              <span class="skill-name">MongoDB</span>
              <div class="skill-bar">
                <div class="skill-progress" data-width="65"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
    </asp:Content>
