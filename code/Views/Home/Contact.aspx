<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Contact Us
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server"></asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>Contact Us</h2>
</div>

<div class="grid_6">
    <p>
        We&#39;re continually working to improve Out of Eggs
        and need your feedback. If you have any questions, problems, or suggestions, please let us know.
    </p>

    <% Html.RenderPartial("FlashMsg"); %>

    <%= Html.ValidationSummary() %>

    <% using (Html.BeginForm("Contact", "Home")) { %>
        <%= Html.AntiForgeryToken() %>
        <fieldset class="formCommon formNewLines">
            <p>
                <label for="name">Name</label>
                <%= Html.TextBox("name", null, new { maxlength = 50 })%>
                <%= Html.ValidationMessage("name", "*") %>
            </p>
            <p>
                <label for="email">Email</label>
                <%= Html.TextBox("email", null, new { maxlength = 50 })%>
                <%= Html.ValidationMessage("email", "*")%>
            </p>
            <p>
                <label for="message" class="textAreaLabel">Message</label>
                <%= Html.TextArea("message") %>
                <%= Html.ValidationMessage("message", "*")%>
            </p>
            <p>
                <label></label>
                <button class="awesome" type="submit">Send</button>
            </p>
        </fieldset>
    <% } %>
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
