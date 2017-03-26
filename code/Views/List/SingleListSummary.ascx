<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.List>" %>

<%--Html.RenderAction (MVC Futures) method--%>

<%= Html.ActionLink(Model.ListName, "Details", "List", new { id = Model.ListId }, null) %>
<span> - <%= Html.Encode(ViewData["TopSectionsString"]) %> ...</span>
