<%@ Page Title="Manage Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageResources.aspx.cs" Inherits="CodeSphereAcademy.ManageResources" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/admin.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Add New Course (INSERT) -->
    <div class="admin-container">
        <h2>Add New Course</h2>
        <asp:Label ID="lblStatus" runat="server" CssClass="status-msg" EnableViewState="false"></asp:Label>

        <div class="form-group">
            <label>Course Title</label>
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" 
                ErrorMessage="Title is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label>Course Description</label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" 
                ErrorMessage="Description is required." CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" CssClass="btn-submit" OnClick="btnAddCourse_Click" />
    </div>

    <!-- Manage Existing Courses (SELECT and DELETE) -->
    <div class="admin-container">
        <h2>Existing Courses</h2>
        
        <div class="search-bar">
            <asp:TextBox ID="txtSearchCourse" runat="server" CssClass="search-input" Placeholder="Search by course title..."></asp:TextBox>
            <asp:Button ID="btnSearchCourse" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearchCourse_Click" CausesValidation="false" />
        </div>

        <asp:GridView ID="gvAdminCourses" runat="server" AutoGenerateColumns="False" CssClass="admin-grid" 
            GridLines="None" DataKeyNames="CourseID" OnRowDeleting="gvAdminCourses_RowDeleting" EmptyDataText="No courses match your search.">
            <Columns>
                <asp:BoundField DataField="CourseID" HeaderText="ID" ItemStyle-Width="10%" />
                <asp:BoundField DataField="Title" HeaderText="Course Title" ItemStyle-Width="25%" />
                <asp:BoundField DataField="Description" HeaderText="Description" ItemStyle-Width="45%" />
                <asp:BoundField DataField="DateAdded" HeaderText="Date Added" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-Width="10%" />
                
                <asp:CommandField ShowDeleteButton="True" DeleteText="Delete" ControlStyle-CssClass="btn-delete" ItemStyle-Width="10%" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>