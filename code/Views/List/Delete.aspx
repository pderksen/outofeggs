<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage<OutOfEggs.Models.List>" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Delete List
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/list.delete.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Delete List</h2>
</div>

<div class="grid_12">
    <p>
        Are you <strong>absolutely</strong> sure you want to delete the list
        <strong>"<%= Html.Encode(Model.ListName) %>"</strong>?
    </p>
    <p class="statusMsg">
        This will be permanent.
    </p>
    <% using (Html.BeginForm("Delete", "List")) { %>
        <fieldset>
            <%= Html.AntiForgeryToken() %>
            <p>
                <button id="confirmBtn" class="awesome" type="submit">Yes, delete this list</button>
            </p>
        </fieldset>
    <% } %>  
    <p>
        <%= Html.ActionLink("No, just take me back", "Details", "List", new { id = Model.ListId }, null) %>
    </p>
</div>        

</asp:Content>
