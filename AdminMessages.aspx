<%@ Page Title="Admin - Contact Messages" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminMessages.aspx.cs" Inherits="Portfolio_try_1.AdminMessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }

        .admin-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        .admin-controls {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 8px 16px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary { background-color: #007bff; color: white; }
        .btn-success { background-color: #28a745; color: white; }
        .btn-danger { background-color: #dc3545; color: white; }
        .btn-warning { background-color: #ffc107; color: black; }

        .btn:hover { opacity: 0.8; }

        .messages-grid {
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .message-item {
            border-bottom: 1px solid #eee;
            padding: 15px;
            cursor: pointer;
        }

        .message-item:hover { background-color: #f8f9fa; }
        .message-item.unread { background-color: #fff3cd; }

        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .message-email {
            font-weight: bold;
            color: black;
        }

        .message-date {
            color: #6c757d;
            font-size: 0.9em;
        }

        .message-preview {
            
            color: #495057;
            margin-bottom: 10px;
        }

        .message-actions {
            display: flex;
            gap: 10px;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }

        .stats-panel {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-box {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            flex: 1;
        }

        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #007bff;
        }

        .stat-label {
            color: #6c757d;
            margin-top: 5px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: burlywood;
            margin: 5% auto;
            padding: 20px;
            border: none;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            color:black;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover { color: black; }

        @media (max-width: 768px) {
            .admin-controls {
                flex-direction: column;
                align-items: stretch;
            }
            
            .stats-panel {
                flex-direction: column;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-container">
        <div class="admin-header">
            <h1>Contact Messages Management</h1>
            <p>View and manage contact form submissions</p>
        </div>

        <!-- Message Panel -->
        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Statistics Panel -->
        <div class="stats-panel">
            <div class="stat-box">
                <div class="stat-number">
                    <asp:Label ID="lblTotalMessages" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Total Messages</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">
                    <asp:Label ID="lblUnreadMessages" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Unread Messages</div>
            </div>
            <div class="stat-box">
                <div class="stat-number">
                    <asp:Label ID="lblTodayMessages" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Today's Messages</div>
            </div>
        </div>

        <!-- Admin Controls -->
        <div class="admin-controls">
            <div>
                <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-primary" OnClick="btnRefresh_Click" />
                <asp:Button ID="btnMarkAllRead" runat="server" Text="Mark All Read" CssClass="btn btn-success" OnClick="btnMarkAllRead_Click" />
                <asp:Button ID="btnDeleteOld" runat="server" Text="Delete Old (30+ days)" CssClass="btn btn-warning" OnClick="btnDeleteOld_Click" 
                           OnClientClick="return confirm('Are you sure you want to delete messages older than 30 days?');" />
            </div>
            <div>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-danger" OnClick="btnLogout_Click" />
            </div>
        </div>

        <!-- Messages Grid -->
        <div class="messages-grid">
            <asp:Repeater ID="rptMessages" runat="server" OnItemCommand="rptMessages_ItemCommand">
                <ItemTemplate>
                    <div class="message-item <%# (bool)Eval("IsRead") ? "" : "unread" %>">
                        <div class="message-header">
                            <div class="message-email"><%# Eval("Email") %></div>
                            <div class="message-date"><%# Convert.ToDateTime(Eval("SubmittedDate")).ToString("MMM dd, yyyy hh:mm tt") %></div>
                        </div>
                        <div class="message-preview">
                            <%# Eval("Message").ToString().Length > 100 ? Eval("Message").ToString().Substring(0, 100) + "..." : Eval("Message") %>
                        </div>
                        <div class="message-actions">
                            <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-primary" 
                                       CommandName="ViewMessage" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnMarkRead" runat="server" Text='<%# (bool)Eval("IsRead") ? "Mark Unread" : "Mark Read" %>' 
                                       CssClass="btn btn-success" CommandName="ToggleRead" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" 
                                       CommandName="DeleteMessage" CommandArgument='<%# Eval("Id") %>' 
                                       OnClientClick="return confirm('Are you sure you want to delete this message?');" />
                            <a href="mailto:<%# Eval("Email") %>" class="btn btn-warning">Reply</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- No Messages Panel -->
        <asp:Panel ID="pnlNoMessages" runat="server" Visible="false" CssClass="text-center" style="padding: 40px;">
            <h3>No contact messages found</h3>
            <p>When visitors submit the contact form, their messages will appear here.</p>
        </asp:Panel>
    </div>

    <!-- Message Detail Modal -->
    <div id="messageModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
           
            <div id="messageDetails"></div>
        </div>
    </div>

    <script type="text/javascript">
        // Modal functionality
        var modal = document.getElementById("messageModal");
        var span = document.getElementsByClassName("close")[0];

        span.onclick = function() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function showMessageDetails(id, email, message, date, isRead) {
            var details = `
                <p><strong>From:</strong> ${email}</p>
                <p><strong>Date:</strong> ${date}</p>
                <p><strong>Status:</strong> ${isRead ? 'Read' : 'Unread'}</p>
                <p><strong>Message:</strong></p>
                <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px; white-space: pre-wrap;">${message}</div>
                <div style="margin-top: 20px;">
                    <a href="mailto:${email}" class="btn btn-primary">Reply via Email</a>
                </div>
            `;
            
            document.getElementById("messageDetails").innerHTML = details;
            modal.style.display = "block";
        }
    </script>
</asp:Content>