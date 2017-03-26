<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ConfigurationSettings.AppSettings["SiteName"] %> - Change Password
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/changePassword.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Change Password</h2>
</div>

<div class="grid_12">
    <p>
        Use the form below to change your password. 
        New passwords need to be at least <%=Html.Encode(ViewData["PasswordLength"])%> characters.
    </p>        
    
    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <fieldset class="formCommon">
            <p>
                <label for="currentPassword">Current password:</label>
                <%= Html.Password("currentPassword", null, new { maxlength = 50 })%>
                <%= Html.ValidationMessage("currentPassword", "*") %>
            </p>
            <p>
                <label for="newPassword">New password:</label>
                <%= Html.Password("newPassword", null, new { maxlength = 50 })%>
                <%= Html.ValidationMessage("newPassword", "*")%>
            </p>
            <p>
                <label for="confirmPassword">Confirm new password:</label>
                <%= Html.Password("confirmPassword", null, new { maxlength = 50 })%>
                <%= Html.ValidationMessage("confirmPassword", "*")%>
            </p>
            <p>
                <label></label>
                <button class="awesome" type="submit">Update password</button>
                &nbsp;or&nbsp;
                <%= Html.ActionLink("Cancel", "Settings") %>
            </p>                
        </fieldset>
    <% } %>
</div>

</asp:Content>
