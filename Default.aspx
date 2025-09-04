<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Portfolio_try_1._Default" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" type="text/css" href="~/Styles/Styles.css" />
    <script src="Scripts/Default.js"></script>
    <style>
        /* More Specific Education Cards Styles */
        body .education-cards {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 2rem;
        }

            body .education-cards .card {
                background-color: #728096;
                border-radius: 10px;
                padding: 20px;
                width: 250px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

                body .education-cards .card .institution-logo {
                    width: 80px;
                    height: 80px;
                    object-fit: contain;
                    margin-bottom: 10px;
                }

                body .education-cards .card h3 {
                    font-size: 1.25rem;
                    margin: 10px 0;
                    color: #333;
                }

                body .education-cards .card p {
                    font-size: 1rem;
                    color: #555;
                }

                    body .education-cards .card p strong {
                        color: #000;
                    }

                body .education-cards .card:hover {
                    background-color: #adbfdb;
                    cursor: pointer;
                    transition: background-color 0.3s ease;
                }

                /* CV Download Button Style */
        .cv-download {
            text-align: center;
            margin-top: 2rem;
        }

        .cv-download-button {
            background-color: #3498db;
            color: white;
            font-size: 1.1rem;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

            .cv-download-button:hover {
                background-color: #2980b9;
                cursor: pointer;
            }





        @media screen and (max-width: 768px) {
            .education-cards {
                flex-direction: column !important; 
                align-items: center !important; 
                gap: 1.5rem !important; 
            }

            .card {
                width: 90% !important; 
                max-width: 400px !important;
            }
        }


    </style>


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
                    Hello beautiful people!
                    <br />
                    I am <strong>MD.EFTAKAR JAMAN ARFAN </strong>also known as Eshan<br />
                    I am currently doing my Undergrad in Computer Science and Engineering at
         Khulna University of Engineering & Technology (KUET).<br />
                    I might not be the brightest when it comes to programming 
         but I am a quick learner.Once again welcome to my portfolio.   
                </p>
            </div>
            <div class="hero-image">
                <img src="Images/profile_pic.jpg" alt="Profile Image" id="profileImage">
            </div>
        </div>
    </main>

    <section class="education-cards">
        <div class="card">
            <img src="Images/kuet.png" alt="KUET Logo" class="institution-logo">
            <h3>Khulna University of Engineering & Technology</h3>
            <p><strong>Year:</strong> 2021 - Present (3rd Year)</p>
            <p><strong>CGPA:</strong>3.93 (4 Semesters)</p>
        </div>
        <div class="card">
            <img src="Images/drmc.png" alt="DRMC Logo" class="institution-logo">
            <h3>Dhaka Residential Model College</h3>
            <p><strong>Year:</strong> 2019 - 2021</p>
            <p><strong>Grade:</strong> A+ (HSC)</p>
        </div>
    </section>

     <!-- CV Download Section -->
    <section class="cv-download">
        <a href="~/Files/My_CV.pdf" download="MD_Eftakar_Jaman_Arfan_CV" class="cv-download-button">
            Download My CV
        </a>
    </section>



    <!-- Modal for enlarged image -->
    <div id="imageModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>


            <img id="modalImage" src="Images/profile_pic.jpg" alt="Enlarged Profile" />

        </div>
    </div>


</asp:Content>

