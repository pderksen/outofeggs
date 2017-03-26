/// <reference path="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.1-vsdoc.js" />

/* Base Javascript for all pages (except print) */

//BlockUI plugin modal dialogs
//Seems better to specify styles in javascript rather than a CSS class for compatibility.

//Message at top right. Variable for blocking editing. Absolute positioned. Times out.
function ShowPageModalDialog1(value, blockEditing)
{
    $.blockUI(
    {
        message: value,
        centerY: false,
        showOverlay: blockEditing,
        timeOut: 5000,
        css:
        {
            backgroundColor: "#cc0000",
            border: "none",
            color: "#ffffff",
            fontSize: "12px",
            fontWeight: "bold",
            padding: "2px 5px",
            top: "10px",
            left: "",
            right: "10px",
            width: "",
            "-webkit-border-radius": "4px",
            "-moz-border-radius": "4px",
            "border-radius": "6px"
        },
        overlayCSS:
        {
            opacity: 0.1
        }
    });
}

//Message centered. Blocks editing. Shows indicator icon. Stays up indefinitely.
function ShowPageModalDialog2(value)
{
    $.blockUI(
    {
        message: value,
        showOverlay: true,
        css:
        {
            backgroundColor: "#ffffff",
            border: "none",
            color: "#666666",
            fontSize: "18px",
            fontWeight: "bold",
            padding: "15px",
            "-webkit-border-radius": "6px",
            "-moz-border-radius": "6px",
            "border-radius": "6px"
        }
    });
}

//*** Doc Ready ***

$(document).ready(function()
{
    //Prevent ajax caching in IE
    $.ajaxSetup({ cache: false });

    //BlockUI global defaults
    $.blockUI.defaults.fadeOut = 800;
});
