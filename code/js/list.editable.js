/// <reference path="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.1-vsdoc.js" />

/* Javascript for list page (when in edit mode) */

//Utility functions

function HtmlEncode(value)
{
    return $('<div/>').text(value).html();
}

function HtmlDecode(value)
{
    return $('<div/>').html(value).text();
}

//Return indicator image with surrounding span tag and text
function IndicatorHtml(message)
{
    var imageTag = '<img src="../img/misc/indicator.gif" />';
    return '<span class="indicatorText">' + imageTag + ' ' + HtmlEncode(message) + '</span>';
}

//*** List functions ***

function InitListEditing()
{
    var listId = $(".listContent").attr("id").replace(/list_/, "");

    $("#listName span").editable("/List/EditName/" + listId,
    {
        id: "elementId",
        name: "listName",
        submit: '<a class="listSave awesome small">Save</a>',
        cancel: '<a class="listCancel">Cancel</a>',
        cssclass: "listEditCtrls",
        height: "none",
        width: "none", //set in css
        select: true,
        indicator: IndicatorHtml("Saving..."),
        data: function(value, settings) { return HtmlDecode(value); }, //HTML decode for input control
        onblur: "ignore", //keep editing open until cancel clicked
        event: "triggerEvent", //custom event so not to clash with built-in events
        callback: function(value, settings)
        {
            $("a#listRenameLink").show();
            //Also change <title> tag
            document.title = "Out of Eggs List: " + HtmlEncode(value);
        },
        onreset: function() {
            $("a#listRenameLink").show();
        }
    });

    //Init list rename action
    $("a#listRenameLink").click(function(event)
    {
        event.preventDefault();

        //Trigger custom event to fire inline edit
        //and set maxlength to 50
        $(this).siblings("span").trigger("triggerEvent")
            .find("input[name=listName]").attr("maxlength", "50");
        $(this).hide();
    });    
}

//*** Section functions ***

function InitSectionSorting()
{
    $(".listColumn").sortable(
    {
        connectWith: ".listColumn",
        cursor: "move",
        handle: ".secHeader",
        //TODO removed opacity because of behavior in IE (1.8rc3)
        //opacity: 0.9,
        cancel: ".secToolbar a",
        placeholder: "secBoxPlaceholder",

        start: function(event, ui)
        {
            $(ui.item).find(".secToolbar").hide();
            $(ui.item).find(".secHeader").unbind("mouseenter mouseleave");
        },

        //update event fires both for column leaving and receiving
        update: function(event, ui)
        {
            var currentCol = $(this);

            //Extract column num from current div id
            var colNum = currentCol.attr("id").replace(/col_/, "");

            //Only start update process if sections to process
            var serializedSections = currentCol.sortable("serialize");

            if (serializedSections != "")
            {
                //Shows "Saving..." but without blocking UI.
                ShowPageModalDialog1("Saving...", false);

                $.post("/Section/UpdateSortOrder",
                {
                    columnNum: colNum,
                    sectionIdQueryString: serializedSections
                },
                function(data)
                {
                    $.unblockUI();

                    //After section dragging re-enable toolbar.
                    //This was in deactivate event previously, but didn't need firing off that much.
                    currentCol.find(".secToolbar").show()
                        .removeClass("secToolbarHeaderHover");

                    currentCol.find(".secHeader").hover(
                        function() { $(this).children(".secToolbar").addClass("secToolbarHeaderHover"); },
                        function() { $(this).children(".secToolbar").removeClass("secToolbarHeaderHover"); }
                    );
                });
            }
        }
    });
}

function InitSectionEditing()
{
    //Init section/item Edit action
    $("a.secEdit").livequery("click", function(event)
    {
        event.preventDefault();
        var secBox = $(this).closest(".secBox");
        var sectionId = secBox.attr("id").replace(/section_/, "");

        //Hide read-only elements and show section/item edit form
        secBox.find(".secHeader").hide();
        secBox.find(".itemBox").hide();
        secBox.find(".secFormBox").show();

        //Add class to section content container to change background
        secBox.find(".secContent").addClass("secContentEditable");

        var itemsTextArea = secBox.find("textarea#itemNames");
        var secNameTextBox = secBox.find("input:text#sectionName");

        itemsTextArea.empty();

        ShowSectionElementDialog(secBox, "Loading...");

        $.get("/Item/GetItemsForTextArea", { sectionId: sectionId }, function(data)
        {
            secBox.unblock();

            //Populate textarea with items
            itemsTextArea.val(data);

            //Set focus and editing of section name if "New Category"
            if (secNameTextBox.val() == "New Category")
            {
                secNameTextBox.select();
            }
            else
            {
                //Set cursor to bottom of textarea
                itemsTextArea.focus();
            }

            //TODO Expand height of textbox to fit items using elastic plugin (like facebook updates)?
            //itemsTextArea.elastic();
        });
    });

    //Delete action
    $("a.secDelete").livequery("click", function(event)
    {
        event.preventDefault();
        if (confirm("Are you sure you want to delete this category and all it's items?"))
        {
            var secBox = $(this).closest(".secBox");
            var sectionId = secBox.attr("id").replace(/section_/, "");

            ShowPageModalDialog1("Deleting category...", false);

            $.post("/Section/Delete", { id: sectionId }, function(data)
            {
                if (data == "Success")
                {
                    //Fade out section and remove from DOM (important!)
                    secBox.fadeOut(function() { secBox.remove(); });
                }
                else
                {
                    //TODO handle error
                }

                $.unblockUI();
            });
        }
    });

    //Save action
    $(".secFormBox button.secSave").livequery("click", function(event)
    {
        event.preventDefault();
        var secBox = $(this).closest(".secBox");

        $(this).closest("form").ajaxSubmit(
        {
            beforeSubmit: function(formData, jqForm, options)
            {
                var form = jqForm[0];

                if (form.sectionName.value == "")
                {
                    //Just use javascript alert for validation for now
                    alert("Please enter a category name.");
                    return false;
                }
                else
                {
                    ShowSectionElementDialog(secBox, "Saving...");
                }
            },

            success: function(responseString)
            {
                //Insert new section html in same spot (from ajax response),
                //removing old html in the process
                secBox.replaceWith(responseString);
                secBox.find("form")[0].reset();
                secBox.unblock();
            },

            error: function(event)
            {
                secBox.find(".secEditButtonRow").html('<span class="statusMsg">Error saving section. Please reload the page.</span>');
                secBox.unblock();
            }
        });
    });

    //Cancel action
    $(".secFormBox a.secCancel").livequery("click", function(event)
    {
        event.preventDefault();
        var secBox = $(this).closest(".secBox");

        //Return to initial state
        secBox.find(".secContent").removeClass("secContentEditable");
        secBox.find(".secHeader").show();
        secBox.find(".itemBox").show();
        secBox.find(".secFormBox").hide();
        secBox.find("form")[0].reset();
    });

    //Discard changes if Escape key pressed
    $(".secFormBox form :input").livequery("keydown", function(event)
    {
        if (event.keyCode == 27)
        {
            event.preventDefault();
            $(this).closest("form").find("a.secCancel").trigger("click");
        }
    });

    //Show toolbar links
    $(".secToolbar").livequery(function()
    {
        $(this).show();
    });

    //Links should turn from grey to white when hovering over header
    //(then to boxed when hovering over link)
    $(".secHeader").livequery(function()
    {
        $(this).hover(
            function() { $(this).children(".secToolbar").addClass("secToolbarHeaderHover"); },
            function() { $(this).children(".secToolbar").removeClass("secToolbarHeaderHover"); }
        );
    });    
}

function InitSectionAdding()
{
    //Create new blank section at bottom of column and set to editable
    $("a.btnAddSection").click(function(event)
    {
        event.preventDefault();

        ShowPageModalDialog1("Adding category...", true);

        var colNum = $(this).attr("id").replace(/secAddToCol_/, "");
        var listId = $(this).closest(".secAddButtonsRow").attr("id").replace(/secAddToList_/, "");

        //Add section to database
        $.post("/Section/Create", { listId: listId, columnNum: colNum }, function(data)
        {
            var selectedCol = $("#col_" + colNum);

            selectedCol.append(data);
            $.unblockUI();
            
            //Scroll to last div in the column added to.
            //Offset a little so it doesn't scroll more than needed, but allows room when section edit is clicked.
            var newSecBox = selectedCol.children(".secBox:last");

            //TODO fade in
            $.scrollTo(newSecBox, 500, { offset: (200 - $(window).height()),
                //onAfter: function() { newSecBox.effect("highlight", null, 2000); }
                onAfter: function() { newSecBox.fadeIn(); }
            });
        });
    });
}

//*** Item functions ***

function InitItemSorting()
{
    $(".itemList").livequery(function()
    {
        $(this).sortable(
        {
            connectWith: ".itemList",
            containment: "document",
            cursor: "move",
            //TODO removed opacity because of behavior in IE (1.8rc3)
            //opacity: 0.9,
            placeholder: "itemRowPlaceholder",

            start: function(event, ui)
            {
                //Unbind hover effect
                $(ui.item).unbind("mouseenter mouseleave");
            },

            //update event fires both for item list leaving and receiving
            update: function(event, ui)
            {
                //Extract section id from parent section box
                var sectionId = $(this).closest(".secBox").attr("id").replace(/section_/, "");

                ShowPageModalDialog1("Saving...", false);

                $.post("/Item/UpdateSortOrder",
                {
                    sectionId: sectionId,
                    itemIdQueryString: $(this).sortable("serialize")
                },
                function(data)
                {
                    $.unblockUI();
                });
            }
        });
    });
}

//*** Misc functions ***

//Enable displaying of list help
function EnableListHelp()
{
    var listHelpBox = $("#listHelpBox");

    //Box is displayed by default
    //Hide if cookie value exists and is false
    if (($.cookie("ShowListHelp") == null) || ($.cookie("ShowListHelp") == "true"))
    {
        listHelpBox.show();
    }

    //Enable toggling with help link
    $("#listTitleBox a#helpLink").click(function(event)
    {
        event.preventDefault();
        listHelpBox.toggle("blind", function()
        {
            //Save visible status to cookie
            $.cookie("ShowListHelp", listHelpBox.is(":visible"), { expires: 365 });
        });
    });

    //Enable close button
    listHelpBox.find("a.closeBtn").click(function(event)
    {
        event.preventDefault();
        listHelpBox.hide("blind", function()
        {
            //Save visible status to cookie
            $.cookie("ShowListHelp", false, { expires: 365 });
        });
    });
}

function ShowSectionElementDialog(element, value)
{
    element.block(
    {
        message: value,
        showOverlay: true,
        css:
        {
            backgroundColor: "#ff6600",
            border: "none",
            color: "#ffffff",
            fontSize: "12px",
            fontWeight: "bold",
            padding: "2px 5px",
            "-moz-border-radius": "4px",
            "-webkit-border-radius": "4px",
            "border-radius": "4px"
        },
        overlayCSS:
        {
            opacity: 0.1,
            "-moz-border-radius": "4px",
            "-webkit-border-radius": "4px",
            "border-radius": "4px"
        }
    });
}

//Setup "more actions" drop-down
function SetupMoreActionsDropDown()
{
    $(".moreActionsDropDown").change(function()
    {
        var listId = $(this).attr("id").replace(/list_/, "");

        switch ($(this).val())
        {
            case "copy":
                ShowPageModalDialog2("Copying list. Please wait...");
                $("#copyListForm").submit();
                break;

            case "email":
                ShowPageModalDialog2("Emailing list. Please wait...");

                $.post("/List/EmailToSelf", { id: listId }, function(data)
                {
                    $.unblockUI();
                    alert("List emailed.");
                });
                break;

            case "delete":
                window.location = "/delete/" + listId;
                break;
        }

        //Change drop-down back to no selection
        $(this).val("");
    });
}

//Display modal dialog for naming list
function ShowRenameListDialog()
{
    $.blockUI(
    {
        message: $("#renameListDialog"),
        overlayCSS: { cursor: "default" }
    });

    $("#renameListDialog").find("input:text#listName").select();

    //Save action
    $("#renameListDialog").children("form").ajaxForm(
    {
        beforeSubmit: function(formData, jqForm, options)
        {
            var form = jqForm[0];

            if (form.listName.value == "")
            {
                //Just use javascript alert for validation for now
                alert("Please enter a list name.");
                return false;
            }
            else
            {
                //Change button to "Saving" and ajax indicator
                $(form).find(".buttonRow").html(IndicatorHtml("Saving..."));
            }
        },

        success: function(responseString)
        {
            //Change list title on page and in <title> tag
            $("#listName span").text(responseString);
            document.title = "Out of Eggs List: " + HtmlEncode(responseString);
            $.unblockUI();
        }
    });
}

//Run after list is loaded.
//Moved to function since loading by ajax now.
function OnListLoaded()
{
    InitListEditing();
    InitSectionSorting();
    InitSectionEditing();
    InitSectionAdding();
    InitItemSorting();

    EnableListHelp();
    SetupMoreActionsDropDown();
    
    //Check for new list name and show rename list dialog if needed
    if ($("#listName span").text() == "Untitled List") { ShowRenameListDialog(); } else { $.unblockUI(); }
}
