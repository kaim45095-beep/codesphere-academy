<%@ Page Title="Terms & Conditions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Terms.aspx.cs" Inherits="CodeSphereAcademy.Terms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/user.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="terms-container">
        <h2>Terms & Conditions</h2>
        <p><em>Last updated: November 2026</em></p>

        <h3>1. Acceptance of Terms</h3>
        <p>By registering for an account at CodeSphere Academy, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of these terms, you must not use our platform.</p>

        <h3>2. Course Access and Usage</h3>
        <p>Upon purchasing a course, you are granted a 1-year non-transferable license to access the course materials. Sharing your account credentials, downloading videos illegally, or distributing our materials is strictly prohibited.</p>

        <h3>3. User Accounts</h3>
        <p>You must provide accurate and complete information during registration (including your legal Date of Birth). You are responsible for safeguarding your password and for all activities that occur under your account.</p>

        <h3>4. Refunds and Cancellations</h3>
        <p>All course purchases are final. Refunds will only be issued in cases of technical failure on our platform that permanently prevents access to the purchased content within the first 14 days of purchase.</p>
        
        <a href="#" onclick="smartGoBack(); return false;" style="display: inline-block; margin-top: 20px; color: #3498db; text-decoration: none; font-weight: bold;">⬅ Go Back</a>

        <script>
function smartGoBack() {
    if (window.history.length > 1 && document.referrer !== "") {
        window.history.back();
    } else {
        window.close();
    }
}
</script>
    </div>
</asp:Content>