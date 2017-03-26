<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<OutOfEggs.Models.List>>" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Your Lists
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/list.index.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Your Lists</h2>
</div>

<div class="grid_12">
    <% Html.RenderPartial("FlashMsg"); %>
    
    <% if (Model.Count() > 0) { %>
        <% Html.RenderPartial("UserLists"); %>
    <% } %>
</div>    
    
<div class="clear"></div>
    
<div class="grid_12">
    <% if (Model.Count() > 0) { %>
        <h3>Need another list?</h3>
    <% } else { %>
        <h3>Ready to create your first list?</h3>
    <% } %>
</div>

<div class="clear"></div>
    
<div class="grid_3">
    <h3><a id="copyListBasic" class="largeLink">Start with a basic list</a></h3>
    
    <p>
        This is the fastest way to get started. Use this to pre-fill your list with common grocery store
        categories and items. Then start tweaking.
    </p>
    
    <%-- Form post to fire off copy of generic list --%>
    <% using (Html.BeginForm("Copy", "List",
        new { id = ConfigurationSettings.AppSettings["GenericListId"] },
        FormMethod.Post, new { @id = "copyListBasicForm" })) { %>
        <%= Html.AntiForgeryToken() %>
    <% } %>    
</div>

<div class="grid_3">
    <h3><%= Html.ActionLink("Copy one of our lists", "Top", "List", 
            null, new { @class = "largeLink" }) %></h3>
    <p>
        Browse through our recommended lists and copy one that best matches your store and the items you buy.
    </p>
</div>

<div class="grid_3">
    <h3><%= Html.ActionLink("Start with a blank list", "Create", "List",
            null, new { @class = "largeLink" }) %></h3>
    <p>
        Use this if you want to create a list from scratch, specifying all categories and items as you go.
    </p>
</div>

</asp:Content>
