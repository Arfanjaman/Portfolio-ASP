<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminSkills.aspx.cs" Inherits="Portfolio_try_1.AdminSkills" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Skills - Admin Panel</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Styles/Admin.css" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="admin-nav">
            <div class="nav-container">
                <div class="nav-brand">
                    <h2>Manage Skills</h2>
                </div>
                <div class="nav-user">
                    <a href="AdminDashboard.aspx" class="btn btn-secondary">Dashboard</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="admin-container">
            <aside class="admin-sidebar">
                <ul class="admin-menu">
                    <li><a href="AdminDashboard.aspx">Dashboard</a></li>
                    <li><a href="AdminProjects.aspx">Manage Projects</a></li>
                    <li><a href="AdminCredentials.aspx">Manage Credentials</a></li>
                    <li><a href="AdminSkills.aspx" class="active">Manage Skills</a></li>
                    <li><a href="AdminQuery.aspx">Database Query</a></li>
                </ul>
            </aside>

            <main class="admin-content">
                <div class="dashboard-header">
                    <h1>Skills Management</h1>
                    <p>Add, edit, or delete your technical skills</p>
                </div>

                <div class="action-buttons" style="margin-bottom: 2rem;">
                    <asp:Button ID="btnAddNew" runat="server" Text="+ Add New Skill" CssClass="btn btn-primary" OnClick="btnAddNew_Click" />
                    <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-secondary" OnClick="btnRefresh_Click" />
                </div>

                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </asp:Panel>

                <div class="results-section">
                    <h2>All Skills</h2>
                    <asp:GridView ID="gvSkills" runat="server" CssClass="results-table" 
                        AutoGenerateColumns="false" AllowPaging="true" PageSize="15"
                        OnPageIndexChanging="gvSkills_PageIndexChanging"
                        OnRowCommand="gvSkills_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Skill_name" HeaderText="Skill Name" />
                            <asp:BoundField DataField="Skill_Type" HeaderText="Type" />
                            <asp:BoundField DataField="Proficiency" HeaderText="Proficiency %" />
                            <asp:TemplateField HeaderText="Proficiency Bar">
                                <ItemTemplate>
                                    <div style="background: rgba(255,255,255,0.2); border-radius: 10px; height: 20px; width: 100px; position: relative;">
                                        <div style='background: linear-gradient(90deg, #3498db, #2ecc71); height: 100%; border-radius: 10px; width: <%# Eval("Proficiency") %>%;'></div>
                                        <span style="position: absolute; top: 2px; left: 5px; font-size: 11px; color: white;"><%# Eval("Proficiency") %>%</span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                                        CommandName="EditSkill" CommandArgument='<%# Eval("Skill_name") %>'
                                        CssClass="btn btn-primary" style="margin-right: 5px;" />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                        CommandName="DeleteSkill" CommandArgument='<%# Eval("Skill_name") %>'
                                        CssClass="btn btn-logout" 
                                        OnClientClick="return confirm('Are you sure you want to delete this skill?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <EmptyDataTemplate>
                            <div style="text-align: center; padding: 2rem; color: #bdc3c7;">
                                No skills found. <a href="#" onclick="document.getElementById('<%= btnAddNew.ClientID %>').click(); return false;">Add your first skill</a>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>

                <!-- Add/Edit Skill Form -->
                <asp:Panel ID="pnlSkillForm" runat="server" Visible="false" CssClass="query-section" style="margin-top: 2rem;">
                    <h2><asp:Label ID="lblFormTitle" runat="server" Text="Add New Skill"></asp:Label></h2>
                    
                    <div class="form-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                        <div>
                            <label>Skill Name</label>
                            <asp:TextBox ID="txtSkillName" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </div>
                        <div>
                            <label>Skill Type</label>
                            <asp:DropDownList ID="ddlSkillType" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Type..." Value="" />
                                <asp:ListItem Text="Language" Value="Language" />
                                <asp:ListItem Text="Framework" Value="Framework" />
                                <asp:ListItem Text="Tool" Value="Tool" />
                                <asp:ListItem Text="Database" Value="Database" />
                                <asp:ListItem Text="Other" Value="Other" />
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div style="margin-bottom: 1rem;">
                        <label>Proficiency Level (1-100)</label>
                        <asp:TextBox ID="txtProficiency" runat="server" CssClass="form-control" TextMode="Number" 
                            min="1" max="100" placeholder="Enter proficiency percentage (1-100)"></asp:TextBox>
                        <small style="color: #95a5a6; font-size: 0.8rem;">Enter a number between 1 and 100 representing your proficiency level</small>
                    </div>

                    <div class="query-buttons">
                        <asp:Button ID="btnSave" runat="server" Text="Save Skill" CssClass="btn-execute" OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-clear" OnClick="btnCancel_Click" />
                    </div>
                </asp:Panel>
            </main>
        </div>

        <style>
            .form-control {
                width: 100%;
                padding: 0.5rem;
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 5px;
                background: rgba(255, 255, 255, 0.1);
                color: #ecf0f1;
                font-size: 0.9rem;
                box-sizing: border-box;
            }

            .form-control:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.3);
            }

            .form-grid label {
                display: block;
                margin-bottom: 0.25rem;
                color: #bdc3c7;
                font-weight: 500;
                font-size: 0.9rem;
            }

            .results-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
                background: rgba(255, 255, 255, 0.05);
                border-radius: 5px;
                overflow: hidden;
            }

            .results-table th,
            .results-table td {
                padding: 0.75rem;
                border: 1px solid rgba(255, 255, 255, 0.1);
                text-align: left;
                font-size: 0.9rem;
            }

            .results-table th {
                background: rgba(52, 152, 219, 0.3);
                font-weight: 600;
                color: #ecf0f1;
            }

            .pager {
                background: rgba(52, 152, 219, 0.2);
                padding: 0.5rem;
                text-align: center;
            }

            .pager a, .pager span {
                padding: 0.25rem 0.5rem;
                margin: 0 0.25rem;
                color: #3498db;
                text-decoration: none;
            }

            .pager span {
                background: rgba(52, 152, 219, 0.3);
                border-radius: 3px;
            }
        </style>
    </form>
</body>
</html>