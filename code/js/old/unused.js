//Setup drop-down navigation menu
function SetupDropDownNav() {
    //Initialize drop-down menu items
    $("a.dropDownLink").click(function() {
        $(".dropDownNav").toggle();
    });

    //Closes any open menus when mouse click occurs anywhere else on the page
    $(document).click(function(event) {
        var clickedTarget = $(event.target);

        if (!((clickedTarget.hasClass("dropDownLink")) || (clickedTarget.parent().hasClass("dropDownLink")))) {
            $(".dropDownNav").hide();
        }
    });
}

$(document).ready(function()
{
    //Initialize drop-down menu items
    $("#navTop a.more").click(function()
    {
        //console.log("showing");
        $(this).toggleClass("selected");
        $(this).siblings("ul").toggle();
    });

    //Closes any open menus when mouse click occurs anywhere else on the page
    $(document).click(function(event)
    {
        var clickedTarget = $(event.target);
        //console.log(clickedTarget);

        if (!((clickedTarget.hasClass("more")) || (clickedTarget.parent().hasClass("more"))))
        {
            //console.log("hiding");
            $("#navTop a.more").removeClass("selected")
                .siblings("ul").hide();
        }
    });

    //Close flash message on close button click
    $(".flashMsgClose a").click(function(event)
    {
        event.preventDefault();
        $(this).closest("#flashMsg").fadeOut("normal");
    });
});

//Checks for flash message value and display if exists
function DisplayFlashMsg()
{
    var flashMsg = $("#flashMsg");

    flashMsg.fadeIn(1000, function()
    {
        //Set timer to fade out/close flash msg
        var flashTimer = window.setTimeout(function()
        {
            flashMsg.fadeOut("normal");
        }, 4000);
    });
}
