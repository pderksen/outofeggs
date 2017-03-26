<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="OutOfEggs.Models" %>
<%@ Import Namespace="Microsoft.Web.Mvc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        <% if (ConfigurationSettings.AppSettings["DevMode"] == "DEV") { %>
            <%= ConfigurationSettings.AppSettings["SiteName"] %>
        <% } else { %>
            <%= ConfigurationSettings.AppSettings["SiteName"] %> - The simplest way to create and print grocery lists
        <% } %>    
    </title>

    <meta name="description" content="The simplest way to create and print grocery lists" />
    <meta name="keywords" content="groceries, lists, create, print, shopping, store, supermarket, organize, arrange" />

    <link href="<%= Url.Content("~/css/960/reset.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/960/960.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/base.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/home.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    
    <% if (ConfigurationSettings.AppSettings["HideImages"] == "true") { %>
        <link href="<%= Url.Content("~/css/hideImages.css") %>" rel="stylesheet" type="text/css" />
    <% } %>

    <script src="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    
    <%--<script src="<%= Url.Content("~/js/home.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>--%>
</head>

<body>

<% Html.RenderPartial("MainHeader"); %>

<div class="clear"></div>

<div id="contentHome" class="container_12">
    <div id="homeSection1" class="grid_12">
        <div id="homeHeadline2">
            Organize your lists and get your shopping done in record time!
        </div>
        <%= Html.ActionLink("Sign up for Free", "Register", "Account", null, new { @id = "btnSignUp" }) %>
    </div>
    
    <div class="clear"></div>
    
    <div id="homeSection2" class="grid_12">
        <div id="homeSection2col1" class="grid_4 alpha">
            <div class="rowA">
                <h2>Copy a List</h2>
                <p>
                    Browse through our <%= Html.ActionLink("recommended lists", "Top", "List") %> and copy one
                    that best matches the items you buy. Or create a list from scratch.
                </p>
            </div>
            <div class="rowB">
                <h2>Add &amp; Arange</h2>
                <p>
                    Add categories and items to your list. Then arrange them to match how you walk
                    through your store.
                </p>
            </div>
            <div class="rowC">
                <h2>Print</h2>
                <p>
                    When your list is set print as many as you want. Return to Out of Eggs when you need
                    to change your list or create a new one.
                </p>
            </div>
        </div>
        <div id="homeSection2col2" class="grid_4">
            <div class="innerContainer">
                <h2>Raves</h2>
                <div class="quoteContainer">
                    <div class="quoteText">
                        Seriously, as a full-time working mother being able to make my list and head
                        out after work was simple and easy.
                        <div class="quoteAuthor">
                            ~ Amy from Fresno, CA
                        </div>
                    </div>
                </div>
                <div class="quoteContainer">
                    <div class="quoteText">
                        When meal planning and making a grocery list, Out of Eggs saves time and helps
                        keep me organized.
                        <div class="quoteAuthor">
                            ~ Helena from Clovis, CA
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="homeSection2col3" class="grid_4 omega">
            <div class="innerContainer">
                <h2>Hot Lists</h2>
                <p>
                    Here are some of our recent recommended lists. Find one that works for you, then print
                    as is or copy to your account and start tweaking.
                </p>
                <ul>
                    <li>&#187; <% Html.RenderAction("SingleListSummary", "List", new { id = long.Parse(ConfigurationSettings.AppSettings["HomeListId1"]) }); %></li>
                    <li>&#187; <% Html.RenderAction("SingleListSummary", "List", new { id = long.Parse(ConfigurationSettings.AppSettings["HomeListId2"]) }); %></li>
                    <li>&#187; <% Html.RenderAction("SingleListSummary", "List", new { id = long.Parse(ConfigurationSettings.AppSettings["HomeListId3"]) }); %></li>
                    <li>&#187; <% Html.RenderAction("SingleListSummary", "List", new { id = long.Parse(ConfigurationSettings.AppSettings["HomeListId4"]) }); %></li>
                    <li>&#187; <%= Html.ActionLink("More recommended lists...", "Top", "List") %></li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="clear"></div>
</div>

<div class="clear"></div>

<% Html.RenderPartial("MainFooter"); %>

<div class="clear"></div>

<% Html.RenderPartial("UserVoiceFeedbackCode"); %>
<% Html.RenderPartial("GoogleTrackingCode"); %>
<% Html.RenderPartial("IE6upgrade"); %>

</body>
</html>
