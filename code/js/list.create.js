$(document).ready(function()
{
    $("input#listName").focus();

    $("form").submit(function(event)
    {
        ShowPageModalDialog2("Creating list. Please wait...");
    });
});
