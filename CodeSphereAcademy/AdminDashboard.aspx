<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="CodeSphereAcademy.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-header {
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ecf0f1;
        }
        .dashboard-header h2 { color: #e74c3c; } /* Red tint to distinguish Admin area */
        
        .stats-container {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-box {
            flex: 1;
            background: #2c3e50;
            color: #fff;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-box h3 { font-size: 36px; margin-bottom: 5px; }
        .stat-box p { font-size: 14px; text-transform: uppercase; letter-spacing: 1px; }
        
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
        }
        .card h3 {
            color: #3498db;
            margin-bottom: 15px;
        }
        .card a {
            display: inline-block;
            padding: 10px 20px;
            background: #e74c3c;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
            margin-top: 15px;
        }
        .card a:hover { background: #c0392b; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-header">
        <h2>Administrator Panel</h2>
        <p>Welcome, <asp:Label ID="lblAdminName" runat="server"></asp:Label>. System overview and management tools.</p>
    </div>

    <!-- Dynamic Statistics from Database -->
    <div class="stats-container">
        <div class="stat-box">
            <h3><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></h3>
            <p>Registered Users</p>
        </div>
        <div class="stat-box">
            <h3><asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label></h3>
            <p>Active Courses</p>
        </div>
    </div>
    
    <!-- Management Links -->
    <div class="card-container">
        <div class="card">
            <h3>User Management</h3>
            <p>View, edit roles, or remove registered users from the system.</p>
            <a href="ManageUsers.aspx">Manage Users</a>
        </div>
        <div class="card">
            <h3>Course Management</h3>
            <p>Add new digital learning resources, update details, or delete courses.</p>
            <a href="ManageResources.aspx">Manage Courses</a>
        </div>
    </div>
</asp:Content>