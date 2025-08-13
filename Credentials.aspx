<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Credentials.aspx.cs" Inherits="Portfolio_try_1.Credentials" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <!--<link href="Styles/Credentials.css" rel="stylesheet" /> !-->
    
    <style>
        /* Credentials Page Specific Styles */
.credentials-section {
    padding: 4rem 2rem;
    max-width: 800px;
    margin: 0 auto;
    min-height: 80vh;
}

.credentials-container h1 {
    text-align: center;
    font-size: 3rem;
    color: #3498db;
    margin-bottom: 1rem;
}

.credentials-intro {
    text-align: center;
    font-size: 1.2rem;
    color: #bdc3c7;
    margin-bottom: 4rem;
}

.credentials-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    min-height: 50vh;
    gap: 40px;
}

.credential-card {
    background: linear-gradient(135deg, #34495e, #2c3e50);
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    transition: all 0.3s ease;
    max-width: 400px;
    width: 100%;
}

    .credential-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0,0,0,0.4);
    }

.credential-image {
    width: 100%;
    height: 200px;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.credential-card:hover .credential-image {
    transform: scale(1.02);
}

.credential-content {
    padding: 1.5rem;
}

.credential-name {
    color: #3498db;
    font-size: 1.4rem;
    font-weight: 600;
    margin-bottom: 0.8rem;
    line-height: 1.3;
}

.credential-platform {
    color: #95a5a6;
    font-size: 1rem;
    margin-bottom: 0.8rem;
    font-weight: 500;
}

.credential-description {
    color: #bdc3c7;
    font-size: 0.9rem;
    line-height: 1.5;
    margin: 0;
}

/* Responsive design */
@media (max-width: 768px) {
    .credentials-container h1 {
        font-size: 2rem;
    }

    .credential-card {
        max-width: 100%;
        margin: 0 1rem;
    }

    .credential-content {
        padding: 1.2rem;
    }

    .credential-name {
        font-size: 1.2rem;
    }
}

@media (max-width: 480px) {
    .credentials-section {
        padding: 2rem 1rem;
    }
}
.verify-btn {
    background-color: #0073e6;
    color: white;
    padding: 8px 15px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    display: inline-block;
    text-align: center;
    font-size: 0.9em;
    margin-top: 10px;
}

    .verify-btn:hover {
        background-color: #005bb5;
    }


    </style>
    
    <script src="Scripts/Credentials.js"></script>

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
        <main class="credentials-section">
            <div class="credentials-container">
                <h1>My Credentials</h1>
                <p class="credentials-intro">Certifications that showcase my expertise</p>

                <div class="credentials-grid">
                    <asp:Repeater ID="rptCredentials" runat="server" OnItemCommand="rptCredentials_ItemCommand">
                        <ItemTemplate>
                            <div class="credential-card">
                                <!-- Clickable image for lightbox -->
                               <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>'
                                    alt='<%# Eval("Name") %> Certificate'
                                    class="credential-image"
                                    style="cursor:pointer"
                                     />


                                <div class="credential-content">
                                    <h3 class="credential-name"><%# Eval("Name") %></h3>
                                    <p class="credential-platform">
                                        <%# Eval("Platform") %> • <%# Eval("IssueDate", "{0:MMMM yyyy}") %>
                                    </p>
                                    <p class="credential-description"><%# Eval("Description") %></p>
                                    <asp:Button runat="server"
                                                Text="Verify Certificate"
                                                CommandName="Verify"
                                                CommandArgument='<%# Eval("VerificationLink") %>'
                                                CssClass="verify-btn" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </main>
    

    <!-- Lightbox Modal -->
   

</asp:Content>
