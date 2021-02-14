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

    <h2>Credit card :&nbsp;
            <asp:Label ID="lbl_card" runat="server"></asp:Label>
        </h2>
    
    <div>Registration closes in <span id="time">05:00</span> minutes!</div>


    <script>function startTimer(duration, display) {
            var timer = duration, minutes, seconds;
            setInterval(function () {
                minutes = parseInt(timer / 60, 10);
                seconds = parseInt(timer % 60, 10);

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                display.textContent = minutes + ":" + seconds;

                if (--timer < 0) {
                    timer = duration;
                }
            }, 1000);
        }

        window.onload = function () {
            var fiveMinutes = 60 * 5,
                display = document.querySelector('#time');
            startTimer(fiveMinutes, display);
        };</script>
</asp:Content>
