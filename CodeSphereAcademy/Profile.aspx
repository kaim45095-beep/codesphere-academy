<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="CodeSphereAcademy.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/user.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="profile-container">
        <h2>Update My Profile</h2>
        <asp:Label ID="lblStatus" runat="server" EnableViewState="false"></asp:Label>

        <div class="form-group">
            <label>Email Address (Cannot be changed)</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Date of Birth (Cannot be changed)</label>
            <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Name cannot be empty." CssClass="error-text" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label>New Password (Leave blank to keep current password)</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Confirm New Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." CssClass="error-text" Display="Dynamic"></asp:CompareValidator>
        </div>

        <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn-submit" OnClick="btnUpdate_Click" />
    </div>

    <div class="profile-container" style="margin-top: 20px;">
        <h2>My Active Courses</h2>
        <asp:GridView ID="gvMyCourses" runat="server" AutoGenerateColumns="False" CssClass="course-grid" GridLines="None" EmptyDataText="You haven't purchased any courses yet.">
            <Columns>
                <asp:BoundField DataField="Title" HeaderText="Course" ItemStyle-Width="50%" />
                <asp:BoundField DataField="PurchaseDate" HeaderText="Purchased" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-Width="25%" />
                <asp:BoundField DataField="ExpiryDate" HeaderText="Expires" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-Width="25%" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>