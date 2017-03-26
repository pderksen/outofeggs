<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<% if (!Request.IsAuthenticated) { %>

<div class="registerSmall">
    <h2>Haven't signed up yet?</h2>
    <h3>Start creating your own lists now.</h3>
    <%= Html.ActionLink("Sign up for Free", "Register", "Account", null, new { @id = "btnSignUp" }) %>    
</div>

<% } %>
