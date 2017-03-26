<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Sign up
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/register.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Sign up for <%= ConfigurationSettings.AppSettings["SiteName"] %></h2>
</div>

<div class="grid_6">
    <p>
        Signing up is free and only takes a few seconds. Don't worry,
        we won't give out your email address.
    </p>

    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <fieldset class="formCommon label125w">
            <p>
                <label for="username">Username</label>
                <%= Html.TextBox("username") %>
                <%= Html.ValidationMessage("username", "*") %>
            </p>
            <p>
                <label for="email">Email address</label>
                <%= Html.TextBox("email") %>
                <%= Html.ValidationMessage("email", "*")%>
            </p>
            <p>
                <label for="password">Password</label>
                <%= Html.Password("password") %>
                <%= Html.ValidationMessage("password", "*")%>
            </p>
            <p>
                <label for="confirmPassword">Confirm password</label>
                <%= Html.Password("confirmPassword") %>
                <%= Html.ValidationMessage("confirmPassword", "*")%>
            </p>
            <p>
                <label></label>
                <button class="awesome" type="submit">Sign up and start creating lists</button>
            </p>
            <p>
                <label></label>
                Already signed up? <%= Html.ActionLink("Login here", "Login") %>
            </p>                
        </fieldset>
    <% } %>
</div>

<div class="grid_6">
    
</div>

</asp:Content>
