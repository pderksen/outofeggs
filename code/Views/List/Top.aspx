<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<OutOfEggs.Models.List>>" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Recommended Lists
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server"></asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Recommended Lists</h2>
</div>

<div class="grid_12">
    <p>
        Browse through our recommended lists. Find one that best matches your store and the items you buy,
        then print as is or copy to your own lists to start tweaking.        
    </p>
    
    <% Html.RenderPartial("UserLists"); %>
</div>

<div class="clear"></div>

<% Html.RenderPartial("SignUpFooter2"); %>

</asp:Content>
