<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title><%= ConfigurationSettings.AppSettings["SiteName"] %></title>
    <meta name="viewport" content="user-scalable=no, width=device-width" />
    
    <link href="<%= Url.Content("~/css/960/reset.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/960/text.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/mobile_iPhone.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    
    <% if (false) { //Use for CSS Intellisense to work %>
        <link href="~/css/mobile_iPhone.css" rel="stylesheet" type="text/css" />
    <% } %>
</head>
<body>

<div>
    <h1 id="logo" title="Out of Eggs">Out of Eggs</h1>

    <h2>Yep, we have an iPhone app!</h2>
    
    <ul>
        <li>Scroll through your lists the cool iPhone way.</li>
        <li>Lists are downloaded in case your connection drops.</li>
        <li>Forget the printing and save a few trees!</li>
    </ul>
    
    <p><a href="" class="awesome">Get the App</a></p>
    
    <p>Currently just $1.99 from the App Store.</p>
    
    <p>Other links:</p>
    
    <ul>
        <li><%= Html.ActionLink("outofeggs.com", "Index", "Home") %></li>
        <li><a href="mailto:mobile.feedback@outofeggs.com">Feedback</a></li>
        <li><a href="<%= ConfigurationSettings.AppSettings["BlogUrl"] %>">Blog</a></li>
        <li><a href="http://m.twitter.com/outofeggs">Twitter</a></li>
        <li><a href="http://m.facebook.com/profile.php?id=165685324187&v=feed">Facebook</a></li>
    </ul>
</div>

<% Html.RenderPartial("GoogleTrackingCode"); %>    
    
</body>
</html>
