<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<script src="<%= Url.Content("~/js/plugins/jquery.twitter.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>
<script src="<%= Url.Content("~/js/recentTweets.js") %>?<%= ConfigurationSettings.AppSettings["AppVersion"] %>" type="text/javascript"></script>

<div class="postsAndTweetsBox">
    <h3 class="twitter">Twitter Updates</h3>

    <div id="recentTweets"></div>
    
    <a href="<%= ConfigurationSettings.AppSettings["TwitterUrl"] %>">Follow us on Twitter</a>
</div>
