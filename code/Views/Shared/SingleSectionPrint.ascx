<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.Section>" %>

<%@ Import Namespace="OutOfEggs.Models" %>

<h2><%= Html.Encode(Model.SectionName) %></h2>

<ul class="itemList">
    <% foreach (Item item in Model.Items.OrderBy(i => i.SortOrder)) { %>
        <li>
            <span class="bullet">&#9633;</span>

            <% if (item.ItemName == "-") { %>
                <div class="blankLine"></div>
            <% } else { %>
                <%= Html.Encode(item.ItemName) %>
            <% } %>            
        </li>
    <% } %>
</ul>
