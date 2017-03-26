<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<% if (!Request.IsAuthenticated) { %>

<div class="grid_12 signUpFooter">
    <span>
        Ready to get started?
        <%= Html.ActionLink("Sign up for free", "Register", "Account") %>
    </span>
</div>

<% } %>
