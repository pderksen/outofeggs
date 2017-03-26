<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.List>" %>

<div id="secAddToList_<%= Model.ListId %>" class="container_12 secAddButtonsRow">
    <% for (int i = 1; i <= 4; i++) { %>
        <div class="grid_3">
            <a id="secAddToCol_<%= i %>" class="btnAddSection awesome" title="Add category to this column">
                <span class="addIcon">Add Category</span>
            </a>
        </div>
    <% } %>

    <div class="clear"></div>
</div>
