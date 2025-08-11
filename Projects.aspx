<%@ Page  Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="Portfolio_try_1.WebForm1" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Styles/Project.css" rel="stylesheet" />
    
    
    <script src="Scripts/Project.js"></script>
    
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="projects-section">
        <div class="projects-container">
            <h1>My Projects</h1>
            <p class="projects-intro">Here are some of the projects I've worked on</p>
            
            <div class="projects-grid">
                <asp:Repeater ID="rptProjects" runat="server">
                    <ItemTemplate>
                        <div class="project-card" data-aos="fade-up">
                            <div class="project-image">
                                <img src='<%# Eval("ImagePath") %>' alt='<%# Eval("Title") %>' />
                                <div class="project-overlay">
                                    <div class="project-icons">
                                        <span class="tech-stack"><%# Eval("TechStack") %></span>
                                    </div>
                                </div>
                            </div>
                            <div class="project-content">
                                <h3><%# Eval("Title") %></h3>
                                <p class="project-description"><%# Eval("Description") %></p>
                                <div class="project-footer">
                                    <div class="project-tags">
                                        <%# Eval("Tags") %>
                                    </div>
                                    <a class="github-btn" href='<%# Eval("GitHubURL") %>' target="_blank">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                            <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.43 9.79 8.2 11.38.6.11.82-.26.82-.57v-2.09c-3.33.72-4.04-1.61-4.04-1.61-.54-1.37-1.32-1.74-1.32-1.74-1.08-.74.08-.73.08-.73 1.2.08 1.83 1.24 1.83 1.24 1.07 1.83 2.8 1.3 3.49.99.11-.77.42-1.3.76-1.6C6.73 17.15 4.5 16.3 4.5 12.5c0-1.3.46-2.36 1.22-3.19-.12-.3-.53-1.51.11-3.15 0 0 1-.32 3.3 1.22A11.12 11.12 0 0 1 12 5.86c1.02 0 2.07.13 3.05.39 2.3-1.54 3.3-1.22 3.3-1.22.64 1.64.23 2.85.11 3.15.76.83 1.22 1.89 1.22 3.19 0 3.8-2.24 4.65-4.5 5.06.36.31.68.91.68 1.84v2.73c0 .31.22.68.82.57C20.57 21.79 24 17.31 24 12c0-6.63-5.37-12-12-12z"/>
                                        </svg>
                                        GitHub
                                    </a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </main>
</asp:Content>