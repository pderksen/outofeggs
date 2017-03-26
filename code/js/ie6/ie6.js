/* IE6 warning message inserted at top of page */
/* Assume IE6 already detected in HTML */

$(document).ready(function()
{
    //Add HTML directly after body tag
    $("<div/>").load("/js/ie6/ie6.html").prependTo("body");
});
