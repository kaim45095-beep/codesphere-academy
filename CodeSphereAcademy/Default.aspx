<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CodeSphereAcademy.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Links exclusively to the external CSS file -->
    <link href="Styles/home.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="hero-section">
        <h2>Welcome to CodeSphere Academy</h2>
        <p>Your interactive platform for mastering computer science, programming, and IT skills through digital learning resources.</p>
        
        <a href="Courses.aspx" class="btn-start">Start Learning Today</a>
    </div>

    <div class="features-container">
        <div class="feature-box">
            <h3>Interactive Labs</h3>
            <p>Engage with virtual environments and real-time coding challenges.</p>
        </div>
        
        <div class="feature-box">
            <h3>Self-Assessments</h3>
            <p>Track your progress with dynamic quizzes and automated grading.</p>
        </div>
        
        <div class="feature-box">
            <h3>Community Discussions</h3>
            <p>Connect with peers and instructors in asynchronous forums.</p>
        </div>
    </div>

</asp:Content>