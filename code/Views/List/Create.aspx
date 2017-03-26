<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Create a new list
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/list.create.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Create a new list</h2>
</div>

<div class="grid_6">
    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <fieldset class="formCommon formNewLines formNewList">
            <p>
                <label for="listName">
                    Name your list
                    <span>&nbsp;(i.e. Trader Joe's, Save Mart, Costco)</span>
                </label>
                <%= Html.TextBox("listName", null, new { maxlength = 50 })%>
                <%= Html.ValidationMessage("listName", "*") %>
            </p>
            <p>
                <label for="sectionNames">
                    Categories for your list
                    <span>&nbsp;(i.e. Vegetables, Meat, Dairy, Beverages)</span>
                </label>
                <%= Html.TextArea("sectionNames") %>
            </p>
            <p>
                <button id="createList" class="awesome" type="submit">Create list and start adding items</button>
            </p>
        </fieldset>
    <% } %>
</div>

<div class="grid_6">
    <p>
        This will create a new list with the categories you enter below. Enter one category per line.
        Don't worry, you can add more later.
    </p>
    <p>
        When building your list, we recommend imagining yourself walking through your store.
        Take note of the sections or aisles in the order you get to them. If you build your list
        in the order that you shop, you'll finish your shopping quickly every time.
    </p>
</div>
    
</asp:Content>
