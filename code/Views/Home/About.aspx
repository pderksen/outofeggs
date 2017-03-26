<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - About Us
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server"></asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>About Us</h2>
</div>

<div class="grid_6">
    <p>
        Out of Eggs provides you with a simple way to create and print grocery lists. 
        All lists are customizable to match the items you buy and the way you walk 
        through your store. They should help you cut your grocery shopping time 
        down significantly by keeping you from backtracking through aisles and 
        forgetting important items.
    </p>
    <p>
        The best way to understand Out of Eggs is to read about 
        <a href="http://blog.outofeggs.com/2009/10/27/introducing-out-of-eggs/">how it started</a>, then 
        take a tour to see <%= Html.ActionLink("how it works", "Tour") %>. 
    </p>
    
    <h3>About the Founder</h3>
    
    <p>
        <img class="lightBorder" src="../img/misc/phil-avatar.jpg" alt="Phil Derksen" /><br />
        Phil Derksen<br />
        <a href="mailto:phil@outofeggs.com">phil@outofeggs.com</a><br />
    </p>
    <p>
        I&#39;ve spent the last 13 years developing web applications for both small and 
        large companies such as <a href="http://www.bevmo.com">BevMo</a> and 
        <a href="http://www.pelco.com">Pelco</a>. You can find me on 
        <a href="http://twitter.com/philderksen">Twitter</a>, 
        <a href="http://www.linkedin.com/in/philderksen">LinkedIn</a>, 
        or my <a href="http://philderksen.com">development blog</a>.
    </p>
    
    <h3>Credits</h3>
    
    <p>
        Graphic design by <a href="http://www.hundred10.com">Hundred10</a>.
    </p>
</div>

<div class="grid_3">
    <% Html.RenderPartial("RecentTweets"); %>
</div>

<div class="grid_3">
    <% Html.RenderPartial("RecentBlogPosts"); %>
</div>

<div class="clear"></div>

<% Html.RenderPartial("SignUpFooter2"); %>

</asp:Content>
