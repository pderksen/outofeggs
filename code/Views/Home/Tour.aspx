<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Other.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="titleCon" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ConfigurationSettings.AppSettings["SiteName"] %> - Tour
</asp:Content>

<asp:Content ID="headCon" ContentPlaceHolderID="OtherHeadContent" runat="server"></asp:Content>

<asp:Content ID="cssCon" ContentPlaceHolderID="CssContent" runat="server"></asp:Content>

<asp:Content ID="jsCon" ContentPlaceHolderID="JSContent" runat="server">
    <script src="<%= Url.Content("~/js/plugins/jquery.tools.min.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
    <script src="<%= Url.Content("~/js/tour.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="mainCon" ContentPlaceHolderID="MainContent" runat="server">

<div id="contentHeader">
    <h2>How It Works</h2>
</div>

<div class="grid_12">
    <div id="tourNav">
        <a class="prevPage disabled awesome">&laquo; Previous</a>
        &nbsp;&nbsp;&nbsp;
        <a class="nextPage awesome">Next &raquo;</a>
    </div>
    
    <div id="tourPane">
        <div class="items">
            <div class="step">
                <div class="stepText">
                    <div class="stepHeader">
                        <span>Step 1</span>
                    </div>
                    <p>
                        Envision how you walk through your store. What aisles do you walk through and in 
                        what order? If you can&#39;t recall this from memory, note this down the next time you 
                        visit your store.
                    </p>
                </div>
                <div class="stepPic">
                    <img src="../img/misc/tour1.png" alt="screenshot" />
                </div>
            </div>
            
            <div class="step">
                <div class="stepText">
                    <div class="stepHeader">
                        <span>Step 2</span>
                    </div>
                    <p>
                        Browse through our <%= Html.ActionLink("recommended lists", "Top", "List") %> 
                        and copy one that best matches the items you buy. If you prefer you can create
                        a list from scratch instead.
                    </p>
                </div>
                <div class="stepPic">
                    <img src="../img/misc/tour2.png" alt="screenshot" />
                </div>
            </div>

            <div class="step">
                <div class="stepText">
                    <div class="stepHeader">
                        <span>Step 3</span>
                    </div>
                    <p>
                        For each category, click Edit to rename the category and modify, add or remove 
                        items. Simply enter items in the order you want them to appear.
                    </p>
                    <p>
                        Since you can&#39;t think of everything you&#39;ll need for every trip, we recommend 
                        adding 2 or 3 blank lines at the bottom of each category. Then you can write in items by hand 
                        on the printed lists. Enter in a single dash character (-) for each blank line 
                        you&#39;d like to appear.
                    </p>                    
                </div>
                <div class="stepPic">
                    <img src="../img/misc/tour3.png" alt="screenshot" />
                </div>
            </div>
            
            <div class="step">
                <div class="stepText">
                    <div class="stepHeader">
                        <span>Step 4</span>
                    </div>
                    <p>
                        You can drag and drop categories to another column and above or below any 
                        other categories. Most people are able to fit their entire list on one printed
                        page by using all four columns.
                    </p>
                </div>
                <div class="stepPic">
                    <img src="../img/misc/tour4.png" alt="screenshot" />
                </div>
            </div>
            
            <div class="step">
                <div class="stepText">
                    <div class="stepHeader">
                        <span>Step 5</span>
                    </div>
                    <p>
                        You can also drag items into other categories or to quickly reorder within a 
                        category.
                    </p>
                </div>
                <div class="stepPic">
                    <img src="../img/misc/tour5.png" alt="screenshot" />
                </div>
            </div>
                        
            <div class="step">
                <div class="stepText">
                    <div class="stepHeader">
                        <span>Step 6</span>
                    </div>
                    <p>
                        Print as many copies as you like. Out of Eggs is intended for you to create 
                        lists you can use without modifying for weeks or even months.
                    </p>
                    <p>
                        When you print a list, checkboxes appear next to each item. Use these to mark 
                        which items you need to pickup on your next trip. This way you can add all 
                        regular items to your list even if you don't need them every single time.
                    </p>                    
                </div>
                <div class="stepPic">
                    <img src="../img/misc/tour6.png" alt="screenshot" />
                </div>
            </div>
        </div>
    </div>
</div>

<div class="clear"></div>

<% Html.RenderPartial("SignUpFooter1"); %>

</asp:Content>    
