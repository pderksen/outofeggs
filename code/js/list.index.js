$(document).ready(function()
{
    //Setup list copying
    $("a#copyListBasic").click(function(event)
    {
        event.preventDefault();
        ShowPageModalDialog2("Creating list. Please wait...");
        $("#copyListBasicForm").submit();
    });
});
