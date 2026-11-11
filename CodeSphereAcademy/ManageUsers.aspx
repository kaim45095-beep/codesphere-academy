<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="CodeSphereAcademy.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/admin.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-container">
        <h2>Manage Registered Users</h2>
        <asp:Label ID="lblStatus" runat="server" CssClass="status-msg" EnableViewState="false"></asp:Label>

        <!-- Search Bar -->
        <div class="search-bar">
            <asp:TextBox ID="txtSearchEmail" runat="server" CssClass="search-input" Placeholder="Search by exact or partial email..."></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="admin-grid" 
            GridLines="None" DataKeyNames="UserID" 
            OnRowDeleting="gvUsers_RowDeleting" 
            OnRowEditing="gvUsers_RowEditing" 
            OnRowCancelingEdit="gvUsers_RowCancelingEdit" 
            OnRowUpdating="gvUsers_RowUpdating" 
            EmptyDataText="No users found matching that email.">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" ItemStyle-Width="5%" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" ItemStyle-Width="20%" ControlStyle-CssClass="grid-input" />
                <asp:BoundField DataField="Email" HeaderText="Email Address" ItemStyle-Width="25%" ControlStyle-CssClass="grid-input" />
                <asp:BoundField DataField="Role" HeaderText="Role" ReadOnly="True" ItemStyle-Width="10%" />
                
                <asp:TemplateField HeaderText="Date of Birth" ItemStyle-Width="20%">
                    <ItemTemplate>
                        <asp:Label ID="lblDOB" runat="server" Text='<%# Eval("DateOfBirth", "{0:MMM dd, yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditDOB" runat="server" Text='<%# Bind("DateOfBirth", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="grid-input"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                
                <asp:CommandField ShowEditButton="True" EditText="Edit" UpdateText="Save" CancelText="Cancel" ControlStyle-CssClass="btn-edit" ItemStyle-Width="10%" />
                <asp:CommandField ShowDeleteButton="True" DeleteText="Remove" ControlStyle-CssClass="btn-delete" ItemStyle-Width="10%" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>