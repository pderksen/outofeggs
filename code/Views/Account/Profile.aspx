<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
	<%= ConfigurationSettings.AppSettings["SiteName"] %> - Change Email Address
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server"></asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Change Email Address</h2>
</div>

<div class="grid_12">
    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <fieldset class="formCommon label100w">
            <p>
                <label for="email">Email address</label>
                <%= Html.TextBox("email", ViewData["email"], new { maxlength = 50} ) %>
                <%= Html.ValidationMessage("email", "*") %>
            </p>
            <p>
                <label></label>
                <button class="awesome" type="submit">Update email address</button>
                &nbsp;or&nbsp;
                <%= Html.ActionLink("Cancel", "Settings") %>
            </p>
        </fieldset>
    <% } %>
</div>

</asp:Content>
