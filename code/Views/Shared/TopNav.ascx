<!-- TODO remove -->

<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div id="headerTopNav">

<% if (Request.IsAuthenticated) { %>
    
    <span class="first userName"><%= Html.Encode(Page.User.Identity.Name) %></span>
    <span><%= Html.ActionLink("Your Lists", "Index", "List") %></span>
    <span><%= Html.ActionLink("Recommended Lists", "Top", "List")%></span>
    <span><%= Html.ActionLink("Account", "Settings", "Account") %></span>
    <span><%= Html.ActionLink("Log out", "LogOut", "Account") %></span>
    
<% } else { %>

    <table>
        <tr>
            <td>
                Have an account?
            </td>
            <td>
                <%= Html.ActionLink("Log in", "Login", "Account", null, new { @class = "colorBtn smallBtn loginBtn" }) %>
            </td>
        </tr>
    </table>

<% } %>

</div>

<% if (!Request.IsAuthenticated) { %>
    <div id="headerTopNavLeft">
        <%= Html.ActionLink("Home", "Index", "Home") %> |
        <%= Html.ActionLink("About", "About", "Home") %> |
        <%= Html.ActionLink("Contact us", "Contact", "Home") %>
    </div>
<% } %>
