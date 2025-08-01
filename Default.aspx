<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Portfolio_try_1._Default" %>

 
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" type="text/css" href="~/Styles/default.css"/>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="home">
        <!-- HERO SECTION -->
        <section class="hero">
            <h1>Hello, I'm Eshan Jaman</h1>
            <p class="tagline">Aspiring Web Developer | HTML | CSS | JavaScript | ASP.NET</p>
            <p>
                <a href="Contact.aspx" class="btn">Contact Me</a>
            </p>
        </section>

        <!-- ABOUT ME SECTION -->
        <section class="about">
            <h2>About Me</h2>
            <p>
                I’m a Computer Science undergraduate passionate about web development. I enjoy turning ideas into functional websites using clean code and creative design. This portfolio showcases my projects and skills as I grow in my web development journey.
            </p>
        </section>

        <!-- PROJECTS SECTION -->
        <section class="projects">
            <h2>Featured Projects</h2>
            <div class="project-grid">
                <div class="project-card">
                    <h3>Personal Journal App</h3>
                    <p>A simple Android journal app built with Java and XML, allowing users to log and edit daily notes.</p>
                </div>
                <div class="project-card">
                    <h3>Student Portal UI</h3>
                    <p>HTML/CSS frontend mockup of a student portal. Includes responsive layout and interactive components.</p>
                </div>
                <div class="project-card">
                    <h3>YouTube Clone</h3>
                    <p>A basic YouTube layout replica using HTML, CSS Grid, and JavaScript for search interaction.</p>
                </div>
            </div>
        </section>
    </main>

</asp:Content>

