<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div id="header" class="container_12">
    <h1 id="logo" class="grid_4">
        <%= Html.ActionLink("Out of Eggs", "Index", "Home", null, new { title = "Out of Eggs Home" }) %>
    </h1>
    <div class="grid_8">
        <div id="topNavContainer">
            <div id="topNavLeft">
                <%= Html.ActionLink("Contact Us", "Contact", "Home") %>
            </div>
            <div id="topNavUnderlay">
                <p>
                    <% if (Request.IsAuthenticated) { %>
                        <%= Html.ActionLink("Your Account", "Settings", "Account") %>&nbsp;&nbsp;|&nbsp;
                        <%= Html.ActionLink("Logout", "LogOut", "Account") %>
                    <% } else { %>
                        Have an account?
                        <%= Html.ActionLink("Login", "Login", "Account", null, new { @id = "loginLink" })%>
                    <% } %>
                </p>
            </div>
        </div>
        
        <div id="mainNavContainer">
            <% if (Request.IsAuthenticated) { %>
                <ul id="mainNavAuth">
                    <li id="mainNavYourLists"><%= Html.ActionLink("Your Lists", "Index", "List") %></li>
                    <li id="mainNavTopListsAuth"><%= Html.ActionLink("Recommended Lists", "Top", "List") %></li>
                </ul>
            <% } else { %>
                <ul id="mainNavNotAuth">
                    <li id="mainNavRegister"><%= Html.ActionLink("Sign up for Free", "Register", "Account") %></li>
                    <li id="mainNavTopListsNotAuth"><%= Html.ActionLink("Recommended Lists", "Top", "List") %></li>
                    <li id="mainNavTour"><%= Html.ActionLink("How it Works", "Tour", "Home") %></li>
                    <li id="mainNavBlog"><a href="<%= ConfigurationSettings.AppSettings["BlogUrl"] %>">Blog</a></li>
                </ul>
            <% } %>
        </div>
    </div>
    
    <div class="clear"></div>
</div>
