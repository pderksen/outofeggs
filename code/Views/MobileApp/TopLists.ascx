<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<OutOfEggs.Models.List>>" %>

<div id="foobar">
    <div class="info">
        woohoo! iphone app lists!
    </div>
    
    <div>
        <% Html.RenderPartial("~/Views/List/UserLists.ascx"); %>
    </div>
</div>