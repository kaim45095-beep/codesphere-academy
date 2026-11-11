<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="CodeSphereAcademy.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .about-container {
            background-color: #fff;
            padding: 50px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            text-align: center;
        }
        .about-container h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 36px;
        }
        .about-container p.lead-text {
            color: #7f8c8d;
            font-size: 18px;
            line-height: 1.6;
            max-width: 800px;
            margin: 0 auto 40px auto;
        }
        
        .team-section h3 {
            color: #2c3e50;
            margin-bottom: 25px;
            font-size: 24px;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 10px;
            display: inline-block;
        }
        
        .team-grid {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }
        .team-member {
            background: #f9f9f9;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 25px 15px;
            width: 220px;
            text-align: center;
            transition: transform 0.3s;
        }
        .team-member:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        .team-member h4 {
            color: #3498db;
            margin-bottom: 5px;
            font-size: 20px;
        }
        .team-member span {
            display: block;
            color: #95a5a6;
            font-size: 14px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="about-container">
        <h2>About CodeSphere Academy</h2>
        <p class="lead-text">
            CodeSphere Academy is a premier digital learning platform developed as a comprehensive solution for the CT050-3-2-WAPP Web Applications module. Our mission is to provide an interactive, scalable, and secure environment for students to master computer science and programming concepts through interactive courses and robust user management.
        </p>
        
        <div class="team-section">
            <h3>Meet Our Development Team</h3>
            <div class="team-grid">
                <div class="team-member">
                    <h4>Member 1</h4>
                    <span>Authentication & Admin</span>
                </div>
                <div class="team-member">
                    <h4>Member 2</h4>
                    <span>Registration & Security</span>
                </div>
                <div class="team-member">
                    <h4>Member 3</h4>
                    <span>Profile & Course Search</span>
                </div>
                <div class="team-member">
                    <h4>Member 4</h4>
                    <span>Resource Management</span>
                </div>
            </div>
        </div>
    </div>
</asp:Content>