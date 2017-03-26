<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OutOfEggs.Models.List>" %>

<%@ Import Namespace="OutOfEggs.Models" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%= Html.Encode(Model.ListName) %> - from <%= ConfigurationSettings.AppSettings["SiteName"] %></title>
    
    <link href="<%= Url.Content("~/css/960/reset.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/fluid960/grid.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />

    <!--[if IE 7]>
        <link href="<%= Url.Content("~/css/fluid960/ie.css") %>" rel="stylesheet" type="text/css" />
    <![endif]-->
    <!--[if lt IE 7]>
        <link href="<%= Url.Content("~/css/fluid960/ie6.css") %>" rel="stylesheet" type="text/css" />
    <![endif]-->

    <link href="<%= Url.Content("~/css/print.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" rel="stylesheet" type="text/css" />
    <link href="<%= Url.Content("~/css/printExtras.css") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" media="print" rel="stylesheet" type="text/css" />

</head>

<body onload="window.print();">

<div class="container_12 fullWidth">

	<div id="printNavLinkBox" class="grid_12">
	    <a href="<%= Url.Action("Details", new { id = Model.ListId })%>">
	        &laquo; back to the list "<%= Html.Encode(Model.ListName) %>"
	    </a>
	</div>
	
	<div class="clear"></div>
	
    <% for (int i = 1; i <= 4; i++) { %>
        <div class="grid_3">
            <% foreach (Section sec in Model.Sections.Where(s => s.ColumnNum == i).OrderBy(s => s.SortOrder)) { %>
                <% Html.RenderPartial("SingleSectionPrint", sec); %>
            <% } %>
        </div>
    <% } %>
	
	<div class="clear"></div>
	
	<div id="printFooter" class="grid_12">
	    <img alt="Printed at outofeggs.com" src="../img/misc/logo-print.png" />
	</div>
	
	<div class="clear"></div>
	
	<div id="printNavLinkBox2" class="grid_12">
	    <a href="<%= Url.Action("Details", new { id = Model.ListId })%>">
	        &laquo; back to the list "<%= Html.Encode(Model.ListName) %>"
	    </a>
	</div>
		
</div>

<% Html.RenderPartial("GoogleTrackingCode"); %>

</body>
</html>
