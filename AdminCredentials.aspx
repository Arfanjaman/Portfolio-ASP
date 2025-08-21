<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminCredentials.aspx.cs" Inherits="Portfolio_try_1.AdminCredentials" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Credentials - Admin Panel</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Styles/Admin.css" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="admin-nav">
            <div class="nav-container">
                <div class="nav-brand">
                    <h2>Manage Credentials</h2>
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
                    <li><a href="AdminCredentials.aspx" class="active">Manage Credentials</a></li>
                    <li><a href="AdminSkills.aspx">Manage Skills</a></li>
                    <li><a href="AdminQuery.aspx">Database Query</a></li>
                </ul>
            </aside>

            <main class="admin-content">
                <div class="dashboard-header">
                    <h1>Credentials Management</h1>
                    <p>Add, edit, or delete credentials and certifications</p>
                </div>

                <div class="action-buttons" style="margin-bottom: 2rem;">
                    <asp:Button ID="btnAddNew" runat="server" Text="+ Add New Credential" CssClass="btn btn-primary" OnClick="btnAddNew_Click" />
                    <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-secondary" OnClick="btnRefresh_Click" />
                </div>

                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </asp:Panel>

                <div class="results-section">
                    <h2>All Credentials</h2>
                    <asp:GridView ID="gvCredentials" runat="server" CssClass="results-table" 
                        AutoGenerateColumns="false" AllowPaging="true" PageSize="10"
                        OnPageIndexChanging="gvCredentials_PageIndexChanging"
                        OnRowCommand="gvCredentials_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Platform" HeaderText="Platform" />
                            <asp:BoundField DataField="IssueDate" HeaderText="Issue Date" DataFormatString="{0:MMM yyyy}" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                            <asp:BoundField DataField="VerificationLink" HeaderText="Verification Link" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                                        CommandName="EditCredential" CommandArgument='<%# Eval("Name") %>'
                                        CssClass="btn btn-primary" style="margin-right: 5px;" />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                        CommandName="DeleteCredential" CommandArgument='<%# Eval("Name") %>'
                                        CssClass="btn btn-logout" 
                                        OnClientClick="return confirm('Are you sure you want to delete this credential?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pager" />
                        <EmptyDataTemplate>
                            <div style="text-align: center; padding: 2rem; color: #bdc3c7;">
                                No credentials found. <a href="#" onclick="document.getElementById('<%= btnAddNew.ClientID %>').click(); return false;">Add your first credential</a>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>

                <!-- Add/Edit Credential Form -->
                <asp:Panel ID="pnlCredentialForm" runat="server" Visible="false" CssClass="query-section" style="margin-top: 2rem;">
                    <h2><asp:Label ID="lblFormTitle" runat="server" Text="Add New Credential"></asp:Label></h2>
                    
                    <div class="form-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                        <div>
                            <label>Credential Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="255"></asp:TextBox>
                        </div>
                        <div>
                            <label>Platform</label>
                            <asp:TextBox ID="txtPlatform" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                        <div>
                            <label>Issue Date</label>
                            <asp:TextBox ID="txtIssueDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div>
                            <label>Image Path</label>
                            <asp:TextBox ID="txtImagePath" runat="server" CssClass="form-control" MaxLength="500" placeholder="e.g., images/certificate1.jpg"></asp:TextBox>
                        </div>
                    </div>

                    <div style="margin-bottom: 1rem;">
                        <label>Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div style="margin-bottom: 1rem;">
                        <label>Verification Link</label>
                        <asp:TextBox ID="txtVerificationLink" runat="server" CssClass="form-control" MaxLength="500" placeholder="https://..."></asp:TextBox>
                    </div>

                    <div class="query-buttons">
                        <asp:Button ID="btnSave" runat="server" Text="Save Credential" CssClass="btn-execute" OnClick="btnSave_Click" />
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