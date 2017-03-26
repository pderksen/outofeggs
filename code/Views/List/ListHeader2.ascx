<!-- TODO remove -->

<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.List>" %>

<!-- For details page - list header -->

<!--

    <div class="grid_12">
        <% Html.RenderPartial("ListHeader2"); %>
        <% Html.RenderPartial("FlashMsgFade"); %>
        <% Html.RenderPartial("ListHelp"); %>
    </div>
    
-->

<table id="listHeader2">
    <tr>
        
    <% if (Request.IsAuthenticated) { %>
    
        <% if (ViewData["UserOwns"] == "true") { %>

        <td class="leftCol" style="width: 40%;">
            <div class="listTitle">
                <h1><span><%= Html.Encode(Model.ListName) %></span><a id="listRenameLink">Rename</a></h1>
            </div>
        </td>
        <td class="middleCol" style="width: 20%;">
            <div id="sectionAddLabel">
                Add category to column
            </div>
            
            <div id="sectionAddToList_<%= Model.ListId %>" class="sectionAddLinkBox">
                <a id="sectionAddToCol_1" class="colorBtn">1</a>
                <a id="sectionAddToCol_2" class="colorBtn">2</a>
                <a id="sectionAddToCol_3" class="colorBtn">3</a>
                <a id="sectionAddToCol_4" class="colorBtn">4</a>
            </div>
        </td>
        <td class="rightCol" style="width: 40%;">
            <div class="listHeader2Nav">
                <ul>
                    <li><%= Html.ActionLink("Print List", "Print", new { id = Model.ListId }, new { @class = "iconLink printLink" }) %></li>
                    <li><a id="listHelpLink" class="iconLink helpLink">Help</a></li>
                    <li>
                    
                        <select class="dropDownNav" id="list_<%= Model.ListId %>" name="dropDownNav">
                            <option value="">More Actions:</option>
                            <option value="copy">Copy this list</option>
                            <option value="email">Email list to yourself</option>
                            <!--
                            <option value="download">Download list as text</option>
                            -->
                            <option value="delete">Delete this list</option>
                        </select>
                    </li>
                </ul>               
                
            </div>
        </td>

        <% } else { %>

        <td class="leftCol" style="width: 33%;">
            <div class="listTitle">
                <h1><span><%= Html.Encode(Model.ListName) %></span></h1>
            </div>
        </td>
        <td class="middleCol" style="width: 34%;">
            <div class="attnMsg attnMsgRed">
                This list is currently in <strong>read-only</strong> mode.<br />
                <a id="copyList" class="bold">Copy this list</a> to start editing.
            </div>
        </td>
        <td class="rightCol" style="width: 33%;">
            <div class="listHeader2Nav">
                <ul>
                    <li><%= Html.ActionLink("Print List", "Print", new { id = Model.ListId }, new { @class = "iconLink printLink" }) %></li>
                </ul>
            </div>
        </td>

        <% } %>
        
        <!-- Form post to copy list -->
        <% using (Html.BeginForm("Copy", "List", new { id = Model.ListId }, FormMethod.Post, new { @id = "copyListForm" })) { %>
            <%= Html.AntiForgeryToken() %>
        <% } %>

        <!-- Form post to email list -->
        <% using (Html.BeginForm("EmailToSelf", "List", new { id = Model.ListId }, FormMethod.Post, new { @id = "emailListForm" })) { %>
            <%= Html.AntiForgeryToken() %>
        <% } %>

    <% } else { %>

        <td class="leftCol" style="width: 33%;">
            <div class="listTitle">
                <h1><span><%= Html.Encode(Model.ListName) %></span></h1>
            </div>
        </td>
        <td class="middleCol" style="width: 34%;">
            <div class="attnMsg">
                <%= Html.ActionLink("Log in", "Login", "Account",
                    new { ReturnUrl = Url.Action("Details", "List", new { id = Model.ListId }, null) }, null) %>
                    to copy this list and start editing.<br />
                
                Not a member yet? <%= Html.ActionLink("Sign up", "Register", "Account") %> for free!
            </div>
        </td>
        <td class="rightCol" style="width: 33%;">
            <div class="listHeader2Nav">
                <ul>
                    <li><%= Html.ActionLink("Print List", "Print", new { id = Model.ListId }, new { @class = "iconLink printLink" }) %></li>
                </ul>
            </div>
        </td>
        
    <% } %>

    </tr>
</table>
