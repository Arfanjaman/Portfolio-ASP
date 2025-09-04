<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Portfolio_try_1.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Portfolio</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Styles/Admin.css" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="admin-nav">
            <div class="nav-container">
                <div class="nav-brand">
                    <h2>Portfolio Admin</h2>
                </div>
                <div class="nav-user">
                    <span>Welcome, <asp:Label ID="lblUsername" runat="server"></asp:Label></span>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="admin-container">
            <aside class="admin-sidebar">
                <ul class="admin-menu">
                    <li><a href="AdminDashboard.aspx" class="active">Dashboard</a></li>
                    <li><a href="AdminProjects.aspx">Manage Projects</a></li>
                    <li><a href="AdminCredentials.aspx">Manage Credentials</a></li>
                    <li><a href="AdminSkills.aspx">Manage Skills</a></li>
                    <li><a href="AdminMessages.aspx">Contact Messages</a></li>
                    <li><a href="AdminQuery.aspx">Database Query</a></li>
                    <li><a href="Default.aspx" target="_blank">View Portfolio</a></li>
                </ul>
            </aside>

            <main class="admin-content">
                <div class="dashboard-header">
                    <h1>Dashboard Overview</h1>
                </div>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><img class="stat-icon" src="./Images/project.png" alt="Projects" /></div>
                        <div class="stat-info">
                            <h3><asp:Label ID="lblProjectsCount" runat="server">0</asp:Label></h3>
                            <p>Total Projects</p>
                        </div>
                        <a href="AdminProjects.aspx" class="stat-link">Manage</a>
                    </div>

                    <div class="stat-card">
                       <div class="stat-icon"><img class="stat-icon" src="./Images/credentials.png" alt="Credentials" /></div>
                        <div class="stat-info">
                            <h3><asp:Label ID="lblCredentialsCount" runat="server">0</asp:Label></h3>
                            <p>Credentials</p>
                        </div>
                        <a href="AdminCredentials.aspx" class="stat-link">Manage</a>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon"><img class="stat-icon" src="./Images/skills.png" alt="Skills" /></div>
                        <div class="stat-info">
                            <h3><asp:Label ID="lblSkillsCount" runat="server">0</asp:Label></h3>
                            <p>Skills</p>
                        </div>
                        <a href="AdminSkills.aspx" class="stat-link">Manage</a>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon"><img class="stat-icon" src="./Images/mail.png" alt="Messages" /></div>
                        <div class="stat-info">
                            <h3><asp:Label ID="lblMessagesCount" runat="server">0</asp:Label></h3>
                            <p>Contact Messages</p>
                        </div>
                        <a href="AdminMessages.aspx" class="stat-link">View</a>
                    </div>

                    <div class="stat-card">
                       <div class="stat-icon"><img class="stat-icon" src="./Images/query.png" alt="Database" /></div>
                        <div class="stat-info">
                            <h3>Query</h3>
                            <p>Database</p>
                        </div>
                        <a href="AdminQuery.aspx" class="stat-link">Execute</a>
                    </div>
                </div>

                <!-- New Messages Alert -->
                <div class="recent-activity">
                    <h2>Recent Activity</h2>
                    <div class="activity-item">
                        <strong>Unread Messages:</strong>
                        <asp:Label ID="lblUnreadMessagesCount" runat="server">0</asp:Label>
                        <a href="AdminMessages.aspx" class="btn btn-primary" style="margin-left: 10px;">View Messages</a>
                    </div>
                </div>

                <div class="recent-activity">
                    <h2>Quick Actions</h2>
                    <div class="action-buttons">
                        <a href="AdminProjects.aspx?action=add" class="btn btn-primary">Add New Project</a>
                        <a href="AdminCredentials.aspx?action=add" class="btn btn-primary">Add New Credential</a>
                        <a href="AdminSkills.aspx?action=add" class="btn btn-primary">Add New Skill</a>
                        <a href="AdminMessages.aspx" class="btn btn-secondary">View Contact Messages</a>
                        <a href="AdminQuery.aspx" class="btn btn-secondary">Run Custom Query</a>
                    </div>
                </div>

                <div class="info-section">
                    <h2>System Information</h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <strong>Last Login:</strong>
                            <asp:Label ID="lblLastLogin" runat="server"></asp:Label>
                        </div>
                        <div class="info-item">
                            <strong>Session Started:</strong>
                            <asp:Label ID="lblSessionStart" runat="server"></asp:Label>
                        </div>
                        <div class="info-item">
                            <strong>Database:</strong>
                            <asp:Label ID="lblDatabaseStatus" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </form>
</body>
</html>