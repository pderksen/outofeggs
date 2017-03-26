<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ConfigurationSettings.AppSettings["SiteName"] %> - Forgot Password
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/forgotPassword.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Forgot Password</h2>
</div>

<div class="grid_12">
    <% Html.RenderPartial("FlashMsg"); %>
    
    <p>
        Forgot your password? Enter your email address for Out of Eggs and a message will be sent to you
        with a new password.
    </p>        
    
    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <fieldset class="formCommon label100w">
            <p>
                <label for="email">Email address</label>
                <%= Html.TextBox("email", null, new { maxlength = 50 })%>
                <%= Html.ValidationMessage("email", "*") %>
            </p>
            <p>
                <label></label>
                <button class="awesome" type="submit">Send new password</button>
                &nbsp;or&nbsp;
                <%= Html.ActionLink("Cancel", "Login") %>
            </p> 
        </fieldset>
    <% } %>
</div>

</asp:Content>
