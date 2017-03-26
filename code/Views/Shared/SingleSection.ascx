<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.Section>" %>

<%@ Import Namespace="OutOfEggs.Models" %>

<div class="secBox" id="section_<%= Model.SectionId %>">
    <div class="secTopBorder"></div>
    
    <div class="secContent">

        <div class="secHeader secHeaderSortable">
            <h2 class="secName"><%= Html.Encode(Model.SectionName) %></h2>
            <div class="secToolbar">
                <a class="secEdit" title="Edit this category and it's items">Edit</a>
                <a class="secDelete" title="Delete this category">X</a>
            </div>
        </div>

        <div class="itemBox">
            <% if (Model.Items.Count > 0) { %>
                <ul class="itemList">
                    <% foreach (Item item in Model.Items.OrderBy(i => i.SortOrder)) { %>
                        <% Html.RenderPartial("SingleItem", item); %>
                    <% } %>
                </ul>
            <% } else { %>
                <span class="addItemText">
                    <a class="secEdit">Add some items</a>
                </span>
                <ul class="itemList"></ul>
            <% } %>
        </div>

        <div class="secFormBox">
            <% using (Html.BeginForm("EditNameAndItems", "Section", new { id = Model.SectionId })) { %>
                <fieldset>
                    <p>
                        <label for="sectionName">Category Name</label>
                        <%= Html.TextBox("sectionName", null, new { maxlength = 50 }) %>
                    </p>
                    <p>
                        <label for="itemNames">
                            Items (one per line)
                        </label>
                        <%= Html.TextArea("itemNames")%>
                    </p>
                    <div class="secEditButtonRow">
                        <button class="secSave awesome small" type="submit">Save</button>
                        &nbsp;or
                        <a class="secCancel">Cancel</a>
                    </div>
                </fieldset>
            <% } %>        
        </div>
        
    </div>
    
    <div class="secBottomBorder"></div>
</div>
