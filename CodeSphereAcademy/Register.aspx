<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CodeSphereAcademy.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/auth.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-container">
        <h2>Create an Account</h2>
        
        <asp:Label ID="lblMessage" runat="server" CssClass="success-text" EnableViewState="false"></asp:Label>

        <div class="form-group">
            <label>Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." CssClass="error-text" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label>Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="error-text" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$" ErrorMessage="Invalid email format." CssClass="error-text" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label>Date of Birth</label>
            <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="Date of Birth is required." CssClass="error-text" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvDOB" runat="server" ControlToValidate="txtDOB" Type="Date" MinimumValue="1900-01-01" 
                ErrorMessage="Date of Birth cannot be in the future." CssClass="error-text" Display="Dynamic"></asp:RangeValidator>
        </div>

        <div class="form-group">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="error-text" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,12}$" ErrorMessage="Password does not meet the requirements." CssClass="error-text" Display="Dynamic"></asp:RegularExpressionValidator>

            <div id="password-criteria">
                <p id="length" class="invalid">Between 8 and 12 characters</p>
                <p id="capital" class="invalid">At least 1 uppercase letter</p>
                <p id="letter" class="invalid">At least 1 lowercase letter</p>
                <p id="number" class="invalid">At least 1 number</p>
                <p id="symbol" class="invalid">At least 1 special character</p>
            </div>
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." CssClass="error-text" Display="Dynamic"></asp:CompareValidator>
        </div>

        <div class="terms-row">
            <asp:CheckBox ID="chkTerms" runat="server" />
            <label for="<%= chkTerms.ClientID %>">I agree to the <a href="Terms.aspx" target="_blank" style="color: #3498db;">Terms and Conditions</a></label>
        </div>
        <asp:CustomValidator ID="cvTerms" runat="server" ClientValidationFunction="ValidateTerms" 
            ErrorMessage="You must agree to the Terms and Conditions to register." CssClass="error-text" Display="Dynamic"></asp:CustomValidator>

        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-submit" OnClick="btnRegister_Click" />
        <a href="Login.aspx" class="login-link">Already registered? Go to Login page.</a>
    </div>

    <script type="text/javascript">
function ValidateTerms(sender, args) {
    var chkBox = document.getElementById('<%= chkTerms.ClientID %>');
            args.IsValid = chkBox.checked;
        }

        var pwdInput = document.getElementById('<%= txtPassword.ClientID %>');
        var length = document.getElementById("length");
        var capital = document.getElementById("capital");
        var letter = document.getElementById("letter");
        var number = document.getElementById("number");
        var symbol = document.getElementById("symbol");

        pwdInput.onkeyup = function () {
            var lowerCaseLetters = /[a-z]/g;
            if(pwdInput.value.match(lowerCaseLetters)) { letter.className = "valid"; } else { letter.className = "invalid"; }

            var upperCaseLetters = /[A-Z]/g;
            if(pwdInput.value.match(upperCaseLetters)) { capital.className = "valid"; } else { capital.className = "invalid"; }

            var numbers = /[0-9]/g;
            if(pwdInput.value.match(numbers)) { number.className = "valid"; } else { number.className = "invalid"; }

            var symbols = /[\W_]/g;
            if(pwdInput.value.match(symbols)) { symbol.className = "valid"; } else { symbol.className = "invalid"; }

            if(pwdInput.value.length >= 8 && pwdInput.value.length <= 12) { length.className = "valid"; } else { length.className = "invalid"; }
        }
    </script>
</asp:Content>