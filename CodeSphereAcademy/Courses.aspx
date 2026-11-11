<%@ Page Title="Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="CodeSphereAcademy.Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/courses.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="catalog-container">
        
        <div class="tab-menu">
            <asp:Button ID="btnTabAll" runat="server" Text="All Courses" CssClass="tab-btn active" OnClick="btnTabAll_Click" CausesValidation="false" />
            <asp:Button ID="btnTabMy" runat="server" Text="My Courses" CssClass="tab-btn" OnClick="btnTabMy_Click" CausesValidation="false" />
        </div>

        <asp:Label ID="lblError" runat="server" ForeColor="Red" EnableViewState="false"></asp:Label>

        <!-- PANEL 1: All Courses -->
        <asp:Panel ID="pnlAllCourses" runat="server">
            <div class="search-bar">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" Placeholder="Search all courses by title..."></asp:TextBox>
                
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="search-dropdown">
                    <asp:ListItem Text="All Topics" Value="All"></asp:ListItem>
                    <asp:ListItem Text="C#" Value="C#"></asp:ListItem>
                    <asp:ListItem Text="Python" Value="Python"></asp:ListItem>
                    <asp:ListItem Text="C++" Value="C++"></asp:ListItem>
                    <asp:ListItem Text="Java" Value="Java"></asp:ListItem>
                    <asp:ListItem Text="SQL" Value="SQL"></asp:ListItem>
                    <asp:ListItem Text="Web Development" Value="Web"></asp:ListItem>
                </asp:DropDownList>

                <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <asp:GridView ID="gvAllCourses" runat="server" AutoGenerateColumns="False" CssClass="course-grid" GridLines="None" ShowHeaderWhenEmpty="True" EmptyDataText="No courses found for this filter.">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Course Title" ItemStyle-Width="25%" />
                    <asp:BoundField DataField="Description" HeaderText="Description" ItemStyle-Width="40%" />
                    
                    <asp:TemplateField HeaderText="Price" ItemStyle-Width="10%">
                        <ItemTemplate>
                            <span style="font-weight: bold; color: #27ae60;">$49.99</span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="25%">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkBuy" runat="server" NavigateUrl='<%# "Transaction.aspx?CourseID=" + Eval("CourseID") %>' 
                                CssClass="btn-buy" Visible='<%# Convert.ToInt32(Eval("IsEnrolled")) == 0 %>'>Buy Now</asp:HyperLink>
                            
                            <asp:Label ID="lblOwned" runat="server" Text="✔ Owned" CssClass="badge-owned" 
                                Visible='<%# Convert.ToInt32(Eval("IsEnrolled")) == 1 %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>

        <!-- PANEL 2: My Courses -->
        <asp:Panel ID="pnlMyCourses" runat="server" Visible="false">
            <p style="margin-bottom: 20px; color: #7f8c8d;">Select a course to enter the learning portal.</p>
            
            <asp:GridView ID="gvMyCourses" runat="server" AutoGenerateColumns="False" CssClass="course-grid" GridLines="None" ShowHeaderWhenEmpty="True" EmptyDataText="You haven't purchased any courses yet.">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Course Title" ItemStyle-Width="50%" />
                    <asp:BoundField DataField="ExpiryDate" HeaderText="Access Valid Until" DataFormatString="{0:MMMM dd, yyyy}" ItemStyle-Width="30%" />
                    
                    <asp:TemplateField ItemStyle-Width="20%">
                        <ItemTemplate>
                            <a href='CoursePortal.aspx?CourseID=<%# Eval("CourseID") %>' class="btn-view">Enter Portal ➔</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>

    </div>
</asp:Content>