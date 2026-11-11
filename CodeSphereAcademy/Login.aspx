<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CodeSphereAcademy.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Reusing the auth-container style we used for the register page -->
    <style>
        .auth-container {
            max-width: 400px;
            margin: 60px auto;
            padding: 30px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }
        .auth-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #2c3e50;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #2980b9;
        }
        .error-text {
            color: #e74c3c;
            font-size: 13px;
            display: block;
            margin-top: 5px;
            text-align: center;
            font-weight: bold;
        }
        .register-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-container">
        <h2>Account Login</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="error-text" EnableViewState="false"></asp:Label>

        <div class="form-group">
            <label>Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                ErrorMessage="Email is required." CssClass="error-text" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                ErrorMessage="Password is required." CssClass="error-text" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-submit" OnClick="btnLogin_Click" />
        
        <a href="Register.aspx" class="register-link">Don't have an account? Register here.</a>
    </div>
</asp:Content>