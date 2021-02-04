<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterTesting.aspx.cs" Inherits="AppSecurity.RegisterTesting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


 
   <div>
    <asp:Label ID="Label1" runat="server" Text="Password"></asp:Label>
    <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" onkeyup="validate()"></asp:TextBox>
     
                <br />
                <asp:Label ID="lb_PwdChecker" runat="server" Text="lb_PwdChecker"   ></asp:Label>

      </div>
     <script type="text/javascript">
         window.onload =function validate() {
             var str = document.getElementById('<%=tbPassword.ClientID %>').value;

             if (str.length < 8) {
                 document.getElementById("lb_PwdChecker").innerHTML = "Password Length Must be at least 8 Characters";
                 document.getElementById("lb_PwdChecker").style.color = "Red";
                 return ("too_short");

             }
         }
     </script>




</asp:Content>
