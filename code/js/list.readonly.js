/// <reference path="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.1-vsdoc.js" />

/* Javascript for list page (when in read-only mode) */

//Run after list is loaded.
//Moved to function since loading by ajax now.
function OnListLoaded()
{
    //Disable renaming of list title
    $("a#listRenameLink").hide();

    //Add margin to top of list content
    $(".listContent").addClass("noSecAddRow");

    //Disable sorting/editing effect on section titles
    $(".secHeader").removeClass("secHeaderSortable");

    //Disable sorting effect on item rows
    $(".itemRow").removeClass("itemRowSortable");

    //Remove add items link if no items in a section
    $(".addItemText .secEdit").hide();

    //Set section name widths to auto since we don't need room for edit/delete links
    $(".secName").css("width", "auto");

    $.unblockUI();
}
