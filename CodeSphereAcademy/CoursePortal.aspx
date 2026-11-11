<%@ Page Title="Learning Portal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CoursePortal.aspx.cs" Inherits="CodeSphereAcademy.CoursePortal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/courses.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <a href="Courses.aspx" class="back-link">⬅ Back to My Courses</a>

    <div class="portal-header">
        <h2><asp:Label ID="lblCourseTitle" runat="server" Text="Loading Course..."></asp:Label></h2>
        <p style="color: #7f8c8d;"><asp:Label ID="lblCourseDesc" runat="server"></asp:Label></p>
    </div>

    <!-- FIRST HALF: Video Player -->
    <div class="video-container">
        <video controls>
            <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
            Your browser does not support HTML video.
        </video>
    </div>

    <!-- SECOND HALF: Documents and Materials -->
    <div class="materials-section">
        <h3>Course Materials & Documents</h3>
        <ul class="doc-list">
            <li><a href="#" onclick="alert('Downloading Syllabus...'); return false;">Course Syllabus (PDF)</a></li>
            <li><a href="#" onclick="alert('Downloading Lecture Slides...'); return false;">Chapter 1-5 Lecture Slides (PPTX)</a></li>
            <li><a href="#" onclick="alert('Downloading Source Code...'); return false;">Project Source Code Files (ZIP)</a></li>
            <li><a href="#" onclick="alert('Downloading Cheat Sheet...'); return false;">Quick Reference Cheat Sheet (PDF)</a></li>
        </ul>
    </div>
</asp:Content>