<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Login
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/login.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2><%= ConfigurationSettings.AppSettings["SiteName"] %> Login</h2>
</div>

<div class="grid_6">
    <% Html.RenderPartial("FlashMsg"); %>

    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <fieldset class="formCommon label75w">
            <p>
                <label for="username">Username</label>
                <%= Html.TextBox("username", null, new { maxlength = 50} ) %>
                <%= Html.ValidationMessage("username", "*") %>
            </p>
            <p>
                <label for="password">Password</label>
                <%= Html.Password("password", null, new { maxlength = 50} ) %>
                <%= Html.ValidationMessage("password", "*")%>
            </p>
            <p>
                <label></label>
                <%= Html.CheckBox("rememberMe", true) %>
                <label class="checkBoxLabel" for="rememberMe">Remember me</label>
            </p>
            <p>
                <label></label>
                <button class="awesome" type="submit">Login</button>
            </p>
            <p>
                <label></label>
                <%= Html.ActionLink("Forgot your username or password?", "ForgotPassword") %>
            </p>
        </fieldset>
    <% } %>
</div>

<div class="grid_6">
    <% Html.RenderPartial("SignUpSmall"); %>
</div>

</asp:Content>
