<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="AppSecurity.Register" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%: Page.Title %> - My ASP.NET Application</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>

    <webopt:bundlereference runat="server" path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    


     <script type ="text/javascript">
         function validate() { //Password validation
             var str = document.getElementById('<%=tbPassword.ClientID %>').value;

             if (str.length < 8) {
                 document.getElementById("lbl_PwdChecker").innerHTML = "Password Length Must be at least 8 Characters";
                 document.getElementById("lbl_PwdChecker").style.color = "Red";
                 return ("too_short");
             }

             else if (str.search(/[0-9]/) == -1) {
                 document.getElementById("lbl_PwdChecker").innerHTML = "Password require at least 1 number";
                 document.getElementById("lbl_PwdChecker").style.color = "Red";
                 return ("no_number");
             }
             else if (str.search(/[A-Z]/) == -1) {
                 document.getElementById("lbl_PwdChecker").innerHTML = "Password require at least 1 Upper case";
                 document.getElementById("lbl_PwdChecker").style.color = "Red";
                 return ("no_uppercase");
             }
             else if (str.search(/[a-z]/) == -1) {
                 document.getElementById("lbl_PwdChecker").innerHTML = "Password require at least 1 Lower case";
                 document.getElementById("lbl_PwdChecker").style.color = "Red";
                 return ("no_lowercase");
             }
             else if (str.search(/[^A-Za-z0-9]/) == -1) {
                 document.getElementById("lbl_PwdChecker").innerHTML = "Password require at least 1 Special symbol";
                 document.getElementById("lbl_PwdChecker").style.color = "Red";
                 return ("no_specialcase");
             }


             document.getElementById("lbl_PwdChecker").innerHTML = "Excellent!"
             document.getElementById("lbl_PwdChecker").style.color = "Blue";
         }

     </script>

       <script src="https://www.google.com/recaptcha/api.js?render=6LcMxkAaAAAAAPKm7fvpwEd84WneorB3IZ2Igm0k"></script>

</head>
<body>
    <form runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see https://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>

        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" runat="server" href="~/">Application name</a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a runat="server" href="~/">Home</a></li>
                        <li><a runat="server" href="~/Login">Login</a></li>
                        <li><a runat="server" href="~/Register">Register</a></li>

                    </ul>
                </div>
            </div>
        </div>
        <div class="container body-content">
             <h2>Registration</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Create a new account</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <!--First Name-->
         <div class="form-group">
            <asp:Label runat="server"   CssClass="col-md-2 control-label">First Name</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="tbFirst" CssClass="form-control"  />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="tbFirst"
                    CssClass="text-danger" ErrorMessage=" First name is required." />
            </div>

        </div>
          <!--Last Name-->
         <div class="form-group">
            <asp:Label runat="server"   CssClass="col-md-2 control-label">Last Name</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="tbLast" CssClass="form-control"/>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="tbLast"
                    CssClass="text-danger" ErrorMessage="Last name is required." />
            </div>
        </div>
          <!--Email-->
        <div class="form-group">
            <asp:Label runat="server"   CssClass="col-md-2 control-label">Email</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="The email field is required." />
            </div>
        </div> 

             <!--Credit Card-->
          <div class="form-group">
            <asp:Label runat="server"   CssClass="col-md-2 control-label">Credit Card</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="tbCredit" CssClass="form-control"  />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="tbCredit"
                    CssClass="text-danger" ErrorMessage="Credit card info is required." />
            </div>
        </div> 

        <!--Date of birth-->
         <div class="form-group">
            <asp:Label runat="server"   CssClass="col-md-2 control-label">Date of birth </asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="tbDate" CssClass="form-control" TextMode="Date" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="tbDate"
                    CssClass="text-danger" ErrorMessage="Credit card info is required." />
            </div>
        </div> 
        <!--Password-->
        <div class="form-group">
            <asp:Label runat="server"   CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="tbPassword" TextMode="Password" CssClass="form-control" onkeyup="javascript:validate()" />
                <asp:Label ID="lbl_PwdChecker" runat="server" Text="lbl_PwdChecker"></asp:Label>
                <br />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="tbPassword"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <!--Comfirm password-->
        <div class="form-group">
            <asp:Label runat="server"   CssClass="col-md-2 control-label">Confirm password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="tbPassword" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button ID="btnRegister" runat="server"   Text="Register" CssClass="btn btn-default" OnClick="btnRegister_Click" />
            </div>
        </div>
                <input type="hidden"id="g-recaptcha-response" name="g-recaptcha-response"/>
    </div>

         

 
            <hr />
            <footer>
                <p>&copy; <%: DateTime.Now.Year %> - My ASP.NET Application</p>
            </footer>
        </div>
         <script>
             grecaptcha.ready(function () {
                 grecaptcha.execute('6LcMxkAaAAAAAPKm7fvpwEd84WneorB3IZ2Igm0k', { action: 'Login' }).then(function (token) {
                     document.getElementById("g-recaptcha-response").value = token;
                 });
             });
         </script>
    </form>
</body>
</html>
