<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div id="footer" class="container_12">
    <div id="footerNavLeft" class="grid_6">
        <%= Html.ActionLink("Home", "Index", "Home") %>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
        <%= Html.ActionLink("About Us", "About", "Home") %>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
        <%= Html.ActionLink("Contact Us", "Contact", "Home") %>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="<%= ConfigurationSettings.AppSettings["FeedbackUrl"] %>">Feedback</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
        <%= Html.ActionLink("Tour", "Tour", "Home") %>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="<%= ConfigurationSettings.AppSettings["BlogUrl"] %>">Blog</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
    </div>
    <div id="footerNavRight" class="grid_6">
        <a class="hasIcon facebook" href="<%= ConfigurationSettings.AppSettings["FacebookUrl"] %>">Find us on Facebook</a>
        <a class="hasIcon twitter" href="<%= ConfigurationSettings.AppSettings["TwitterUrl"] %>">Follow us on Twitter</a>
    </div>
    
    <div class="clear"></div>
    
    <div id="footerBottom" class="grid_12">
        <div id="copyright">
            &copy; <%= DateTime.Today.Year.ToString() %> <%= ConfigurationSettings.AppSettings["SiteName"] %>.
            All rights reserved.&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
            <a href="mailto:phil@outofeggs.com">Email Us</a>
            &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
            <%= Html.ActionLink("Terms", "Terms", "Home") %>
            &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
            <%= Html.ActionLink("Privacy", "Privacy", "Home") %>
       </div>
    </div>
    
    <div class="clear"></div>
</div>
