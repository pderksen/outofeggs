<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<OutOfEggs.Models.List>>" %>

<%@ Import Namespace="Microsoft.Web.Mvc" %>

<ul class="userLists">
    <% foreach (var list in Model) { %>
        <li><% Html.RenderAction("SingleListSummary", "List", new { id = list.ListId }); %></li>
    <% } %>
</ul>
