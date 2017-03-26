<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<%--Consolidate flash msg controls & html--%>

<% if ((ViewData["FlashMsg"] != null) && (ViewData["FlashMsg"].ToString().Trim() != "")) { %>

    <div style="text-align: center;">
        <span class="flashMsg">
            <%= Html.Encode(ViewData["FlashMsg"]) %>
            <a class="colorBtn smallBtn closeBtn" title="Close this message">X</a>
        </span>
    </div>
    
<% } %>
