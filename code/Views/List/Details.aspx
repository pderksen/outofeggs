<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OutOfEggs.Models.List>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%= ConfigurationSettings.AppSettings["SiteName"] %> List: <%= Html.Encode(Model.ListName) %></title>
    
    <link href="<%= Url.Content("~/css/960/reset.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/960/960.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/base.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/list.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    
    <% if (ConfigurationSettings.AppSettings["HideImages"] == "true") { %>
        <link href="<%= Url.Content("~/css/hideImages.css") %>" rel="stylesheet" type="text/css" />
    <% } %>    

    <script src="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/plugins/jquery.blockUI.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/plugins/jquery.cookie.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/plugins/jquery.form.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/plugins/jquery.jeditable.min.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/plugins/jquery.livequery.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/plugins/jquery.scrollTo.min.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/base.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/list.base.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    
    <% if (ViewData["UserOwns"] == "true") { %>
        <script src="<%= Url.Content("~/js/list.editable.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <% } else { %>
        <script src="<%= Url.Content("~/js/list.readonly.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <% } %>
</head>

<body>

<% Html.RenderPartial("MainHeader"); %>

<div class="clear"></div>

<% Html.RenderPartial("ListHeader"); %>

<div class="clear"></div>

<% if ((Request.IsAuthenticated) && (ViewData["UserOwns"] == "true")) { %>

    <% Html.RenderPartial("SectionAddButtons"); %>

    <div class="clear"></div>

<% } %>

<div id="list_<%= Model.ListId %>" class="container_12 listContent"></div>

<div class="clear"></div>

<% Html.RenderPartial("MainFooter"); %>

<div class="clear"></div>

<% Html.RenderPartial("UserVoiceFeedbackCode"); %>
<% Html.RenderPartial("GoogleTrackingCode"); %>
<% Html.RenderPartial("IE6upgrade"); %>

</body>
</html>
