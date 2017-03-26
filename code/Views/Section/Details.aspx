<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" 
    Inherits="System.Web.Mvc.ViewPage<OutOfEggs.Models.Section>" %>

<%--Page used for debugging--%>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Section ID: <%= Model.SectionId %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container_12">
    <div class="grid_3 listColumn">
        <h5>List ID: <%= Model.ListId %> / Section ID: <%= Model.SectionId %></h5>
        
        <% Html.RenderPartial("SingleSectionPrint"); %>
    </div>
</div>

</asp:Content>
