<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<%--Consolidate flash msg controls & html--%>

<% if ((ViewData["FlashMsg"] != null) && (ViewData["FlashMsg"].ToString().Trim() != "")) { %>

    <span class="flashMsg"><%= Html.Encode(ViewData["FlashMsg"]) %></span>
    
<% } %>
