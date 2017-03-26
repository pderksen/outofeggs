<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.List>" %>

<%@ Import Namespace="OutOfEggs.Models" %>

<% for (int i = 1; i <= 4; i++) { %>
    <div class="grid_3 listColumn" id="col_<% =i %>">
        <% foreach (Section sec in Model.Sections.Where(s => s.ColumnNum == i).OrderBy(s => s.SortOrder)) { %>
            <% Html.RenderPartial("SingleSection", sec); %>
        <% } %>
    </div>
<% } %>
