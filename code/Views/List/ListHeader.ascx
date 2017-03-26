<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OutOfEggs.Models.List>" %>

<div id="listTitleBox">
    <table>
        <tr>
            <td class="leftCol">
                <div id="listName">
                    <h2><span><%= Html.Encode(Model.ListName) %></span><a id="listRenameLink">Rename</a></h2>
                </div>
            </td>
            
            <% if (!Request.IsAuthenticated) { %>
            
                <td class="middleCol">
                    <p>
                        <%= Html.ActionLink("Login", "Login", "Account",
                            new { ReturnUrl = Url.Action("Details", "List", new { id = Model.ListId }, null) }, null) %>
                            to copy this list and start editing.<br />
                        
                        Not a member yet? <%= Html.ActionLink("Sign up", "Register", "Account") %> for free!
                    </p>
                </td>
            
            <% } else if (ViewData["UserOwns"] == "false") { %>

                <td class="middleCol">
                    <p>
                        This list is currently <strong>read-only</strong>.<br />
                        <a id="copyLink2">Copy this list</a> to start editing.
                    </p>
                </td>
            
            <% } %>
            
            <td class="rightCol">
                <ul>
                    <li><%= Html.ActionLink("Print List", "Print", new { id = Model.ListId }, new { @id = "printLink", @class = "iconLink" }) %></li>
                    
                    <% if (Request.IsAuthenticated) { %>
                        <% if (ViewData["UserOwns"] == "true") { %>
                        
                            <li><a id="helpLink" class="iconLink">Help</a></li>
                            <li>
                                <select id="list_<%= Model.ListId %>" class="moreActionsDropDown">
                                    <option value="">More Actions:</option>
                                    <option value="copy">Copy this list</option>
                                    <option value="email">Email list to yourself</option>
                                    <option value="delete">Delete this list</option>
                                </select>
                            </li>
                            
                        <% } else { %>
                        
                            <li><a id="copyLink" class="iconLink">Copy List</a></li>
                        
                        <% } %>
                    
                    <% } %>
                    
                </ul>
            </td>
        </tr>
    </table>
</div>

<%-- Form post to copy list --%>
<% using (Html.BeginForm("Copy", "List", new { id = Model.ListId }, FormMethod.Post, new { @id = "copyListForm" })) { %>
    <%= Html.AntiForgeryToken() %>
<% } %>

<% if ((Request.IsAuthenticated) && (ViewData["UserOwns"] == "true")) { %>

    <%-- Form post to email list --%>
    <% using (Html.BeginForm("EmailToSelf", "List", new { id = Model.ListId }, FormMethod.Post, new { @id = "emailListForm" })) { %>
        <%= Html.AntiForgeryToken()%>
    <% } %>

    <% Html.RenderPartial("ListHelp"); %>

    <div id="renameListDialog">
        <h3>What would you like to name this list?</h3>
        
        <%= Html.ValidationSummary()%>

        <% using (Html.BeginForm("EditName", "List", new { id = Model.ListId }))
           { %>
            <%= Html.AntiForgeryToken()%>
            <fieldset>
                <p>
                    <%= Html.TextBox("listName", null, new { maxlength = 50 })%>
                </p>
                <p class="buttonRow">
                    <button class="awesome" type="submit">Submit</button>
                </p>
            </fieldset>
        <% } %>
    </div>

<% } %>
