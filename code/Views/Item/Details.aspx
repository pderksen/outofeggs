<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" 
    Inherits="System.Web.Mvc.ViewPage<OutOfEggs.Models.Item>" %>

<%--Page used for debugging--%>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Item ID: <%= Model.ItemId %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container_12">
    <div class="grid_3 listColumn">
        <h5>Section ID: <%= Model.SectionId %> / Item ID: <%= Model.ItemId %></h5>
        
        <div class="itemBox">
            <ul class="itemList">
                <% Html.RenderPartial("SingleItem"); %>
            </ul>
        </div>
    </div>
</div>

</asp:Content>

