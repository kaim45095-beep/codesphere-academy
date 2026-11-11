<%@ Page Title="Secure Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="CodeSphereAcademy.Transaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/user.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="checkout-container">
        <h2>Secure Checkout</h2>
        
        <asp:Panel ID="pnlCheckout" runat="server">
            <p style="font-size: 18px; margin-bottom: 20px;">
                You are purchasing: <strong><asp:Label ID="lblCourseName" runat="server"></asp:Label></strong>
            </p>
            <p style="margin-bottom: 30px; color: #7f8c8d;">This grants 1-year access to the course materials.</p>
            
            <div class="form-group">
                <label>Mock Credit Card Number</label>
                <input type="text" class="form-control" placeholder="XXXX-XXXX-XXXX-XXXX" />
            </div>
            
            <asp:Button ID="btnConfirmPayment" runat="server" Text="Confirm Payment ($49.99)" CssClass="payment-btn" OnClick="btnConfirmPayment_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-msg">
            <p>Payment Successful! ✨</p>
            <p style="font-size: 14px; color: #7f8c8d; margin-top: 10px;">The course has been added to your profile.</p>
            <a href="Profile.aspx" style="display: block; margin-top: 20px; color: #3498db;">Go to My Profile</a>
        </asp:Panel>
    </div>
</asp:Content>