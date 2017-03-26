/// <reference path="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.1-vsdoc.js" />

/* Javascript for list page (edit & read-only modes) */

//Setup flash message (close & fade out)
function SetupFlashMsg()
{
    var fadeOutTime = 6000;
    var flashMsg = $(".flashMsg");

    //Set timer to fade out/close flash msg
    window.setTimeout(function() { flashMsg.fadeOut(); }, fadeOutTime);

    flashMsg.children(".closeBtn").click(function(event)
    {
        event.preventDefault();
        flashMsg.fadeOut();
    });
}

//Setup list copying post from link
function SetupListCopying()
{
    $("a#copyLink, a#copyLink2").click(function(event)
    {
        event.preventDefault();
        ShowPageModalDialog2("Copying list. Please wait...");
        $("#copyListForm").submit();
    });
}

//*** Doc Ready ***

$(document).ready(function()
{
    //Show new modal dialog with loading msg
    ShowPageModalDialog2("Loading list. Please wait...");

    SetupFlashMsg();
    SetupListCopying();

    var listId = $(".listContent").attr("id").replace(/list_/, "");

    //POST to bring back correct list content
    $(".listContent").load("/List/ColumnContent", { id: listId }, function()
    {
        //editable.js vs readonly.js have different OnListLoaded() function
        OnListLoaded();
    });
});
