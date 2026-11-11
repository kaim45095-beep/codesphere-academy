<%@ Page Title="Learner Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LearnerDashboard.aspx.cs" Inherits="CodeSphereAcademy.LearnerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-header {
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ecf0f1;
        }
        .dashboard-header h2 {
            color: #2c3e50;
        }
        .card-container {
            display: flex;
            gap: 20px;
        }
        .card {
            flex: 1;
            background: #fff;
            padding: 25px;
            border: 1px solid #ddd;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card h3 {
            color: #3498db;
            margin-bottom: 15px;
            font-size: 22px;
        }
        .card p {
            color: #7f8c8d;
            margin-bottom: 20px;
            min-height: 45px;
        }
        .card a {
            display: inline-block;
            padding: 10px 20px;
            background: #2c3e50;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }
        .card a:hover {
            background: #1a252f;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-header">
        <h2>Welcome back, <asp:Label ID="lblUserName" runat="server" Text="Learner"></asp:Label>!</h2>
        <p>Select an option below to continue your learning journey.</p>
    </div>
    
    <div class="card-container">
        <div class="card">
            <h3>Explore Courses</h3>
            <p>Browse available digital learning resources, virtual labs, and assessments.</p>
            <a href="Courses.aspx">View Courses</a>
        </div>
        <div class="card">
            <h3>My Profile</h3>
            <p>Manage your account details, email, and update your password.</p>
            <a href="Profile.aspx">Edit Profile</a>
        </div>
    </div>
</asp:Content>