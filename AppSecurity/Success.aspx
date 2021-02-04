<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="AppSecurity.Success" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>User Profile</h2>
        <h2>Full Name : <asp:Label ID="lbl_name" runat="server"></asp:Label>
        </h2>
        <h2>Email :&nbsp;
            <asp:Label ID="lbl_email" runat="server"></asp:Label>
        </h2>
      <h2>Date_Of_Birth :&nbsp;
            <asp:Label ID="lbl_dob" runat="server"></asp:Label>
        </h2>
    
</asp:Content>
