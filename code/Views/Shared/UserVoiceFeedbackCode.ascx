<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<% if (ConfigurationSettings.AppSettings["DevMode"] != "DEV") { %>

<script type="text/javascript">
  var uservoiceJsHost = ("https:" == document.location.protocol) ? "https://uservoice.com" : "http://cdn.uservoice.com";
  document.write(unescape("%3Cscript src='" + uservoiceJsHost + "/javascripts/widgets/tab.js' type='text/javascript'%3E%3C/script%3E"))
</script>
<script type="text/javascript">
UserVoice.Tab.show({ 
  /* required */
  key: 'outofeggs',
  host: 'outofeggs.uservoice.com', 
  forum: '1769', 
  /* optional */
  alignment: 'left',
  background_color: '#cd802a', 
  text_color: 'white',
  hover_color: '#50473e',
  lang: 'en'
})
</script>

<% } %>
