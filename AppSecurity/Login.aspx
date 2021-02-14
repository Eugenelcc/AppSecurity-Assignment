<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AppSecurity.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Login</h2>
    <!--ERROR PANEL-->
                            <asp:Panel ID="PanelErrorResult" Visible="false" runat="server" CssClass="alert alert-dismissable alert-danger">
                            <button type="button" class="close" data-dismiss="alert">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <asp:Label ID="Lbl_err" runat="server"></asp:Label>
                            </asp:Panel>
                             <!--ERROR PANEL-->
   

    <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <h4>Use a local account to log in.</h4>
                    <hr />
 
                    <div class="form-group">
                        <asp:Label runat="server"  CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="tbEmail_login" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="tbEmail_login"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server"   CssClass="col-md-2 control-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="tbPassword_login" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="tbPassword_login" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button  ID="Btn_login"   runat="server"   Text="Log in" CssClass="btn btn-default" onClick="Btn_login_Click" />
                        </div>
                    </div>
                </div>
                <input type="hidden"id="g-recaptcha-response" name="g-recaptcha-response"/>
                <p>
                    <asp:HyperLink NavigateUrl="~/Register.aspx"   runat="server" ID="RegisterHyperLink" ViewStateMode="Enabled">Register as a new user</asp:HyperLink>
                </p>
                
            </section>
        </div>
 

         
    </div>
</asp:Content>