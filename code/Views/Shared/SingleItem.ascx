<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.Item>" %>

<%@ Import Namespace="OutOfEggs.Models" %>

<li class="itemRow itemRowSortable" id="item_<%= Model.ItemId %>">
    <span class="itemName">
        <% if (Model.ItemName == "-") { %>
            _________________________
        <% } else { %>
            <%= Html.Encode(Model.ItemName) %>
        <% } %>
    </span>
</li>
