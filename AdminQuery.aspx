<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminQuery.aspx.cs" Inherits="Portfolio_try_1.AdminQuery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Database Query - Admin Panel</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Styles/Admin.css" />
    <style>
        .query-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .query-section {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .query-textarea {
            width: 100%;
            min-height: 150px;
            font-family: 'Consolas', 'Monaco', monospace;
            font-size: 14px;
            padding: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 5px;
            background: rgba(0, 0, 0, 0.3);
            color: #ecf0f1;
            resize: vertical;
        }

        .query-buttons {
            margin-top: 1rem;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-execute {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-clear {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .quick-queries {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .quick-query-btn {
            background: rgba(52, 152, 219, 0.2);
            border: 1px solid #3498db;
            color: #3498db;
            padding: 0.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .quick-query-btn:hover {
            background: rgba(52, 152, 219, 0.4);
        }

        .results-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .results-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .results-table th,
        .results-table td {
            padding: 0.75rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: left;
        }

        .results-table th {
            background: rgba(52, 152, 219, 0.3);
            font-weight: 600;
        }

        .error-message {
            background: rgba(231, 76, 60, 0.2);
            border: 1px solid #e74c3c;
            color: #ff6b6b;
            padding: 1rem;
            border-radius: 5px;
            margin-top: 1rem;
        }

        .success-message {
            background: rgba(46, 204, 113, 0.2);
            border: 1px solid #2ecc71;
            color: #2ecc71;
            padding: 1rem;
            border-radius: 5px;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="admin-nav">
            <div class="nav-container">
                <div class="nav-brand">
                    <h2>Database Query Tool</h2>
                </div>
                <div class="nav-user">
                    <a href="AdminDashboard.aspx" class="btn btn-secondary">? Back to Dashboard</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="query-container">
            <div class="query-section">
                <h2>SQL Query Executor</h2>
                <p>Execute SQL queries on your portfolio database. Be careful with UPDATE and DELETE operations!</p>

                <div class="quick-queries">
                    <button type="button" class="quick-query-btn" onclick="setQuery('SELECT * FROM Projects')">View All Projects</button>
                    <button type="button" class="quick-query-btn" onclick="setQuery('SELECT * FROM Credentials')">View All Credentials</button>
                    <button type="button" class="quick-query-btn" onclick="setQuery('SELECT * FROM Skills')">View All Skills</button>
                    <button type="button" class="quick-query-btn" onclick="setQuery('SELECT COUNT(*) as Total FROM Projects')">Count Projects</button>
                    <button type="button" class="quick-query-btn" onclick="setQuery('SELECT Skill_Type, COUNT(*) as Count FROM Skills GROUP BY Skill_Type')">Skills by Type</button>
                    <button type="button" class="quick-query-btn" onclick="setQuery('SELECT Platform, COUNT(*) as Count FROM Credentials GROUP BY Platform')">Credentials by Platform</button>
                </div>

                <asp:TextBox ID="txtQuery" runat="server" TextMode="MultiLine" CssClass="query-textarea" 
                    placeholder="Enter your SQL query here...&#13;&#10;Example: SELECT * FROM Projects WHERE Title LIKE '%Web%'"></asp:TextBox>

                <div class="query-buttons">
                    <asp:Button ID="btnExecute" runat="server" Text="Execute Query" CssClass="btn-execute" OnClick="btnExecute_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-clear" OnClick="btnClear_Click" />
                </div>
            </div>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlResults" runat="server" CssClass="results-section" Visible="false">
                <h3>Query Results</h3>
                <asp:Label ID="lblRowCount" runat="server"></asp:Label>
                <asp:GridView ID="gvResults" runat="server" CssClass="results-table" 
                    AutoGenerateColumns="true" AllowPaging="true" PageSize="50" 
                    OnPageIndexChanging="gvResults_PageIndexChanging">
                    <PagerStyle CssClass="pager" />
                </asp:GridView>
            </asp:Panel>
        </div>

        <script>
            function setQuery(query) {
                document.getElementById('<%= txtQuery.ClientID %>').value = query;
            }
        </script>
    </form>
</body>
</html>