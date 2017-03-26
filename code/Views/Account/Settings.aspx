<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ConfigurationSettings.AppSettings["SiteName"] %> - Account Settings
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server"></asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Account Settings</h2>
</div>

<div class="grid_12">
    <% Html.RenderPartial("FlashMsg"); %>

    <p>
        Username: <strong><%= Html.Encode(User.Identity.Name) %></strong>
    </p>
    
    <p>
        <%= Html.ActionLink("Change your email address", "Profile", "Account", null, new { @class = "largeLink" }) %>
    </p>
    
    <p>
        <%= Html.ActionLink("Change your password", "ChangePassword", "Account", null, new { @class = "largeLink" }) %>
    </p>
</div>

</asp:Content>
