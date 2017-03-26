/* iPhone app main Javascript */

//From jqTouch
var jQT = $.jQTouch({
    //TODO preload images, set status bar, etc. See examples.

});

//Test cross domain ajax call from phonegap'd iphone app to ajax html on server.
//Works in iPhone simulator using phonegap, but not running safari locally.
function Test1() {
    // Page animations end with AJAX callback event, example 1 (load remote HTML only first time)
    $('#ajaxCallback').bind('pageAnimationEnd', function(e, info) {

        // Make sure the data hasn't already been loaded (we'll set 'loaded' to true a couple lines further down)
        if (!$(this).data('loaded')) {
            // Append a placeholder in case the remote HTML takes its sweet time making it back
            // Then, overwrite the "Loading" placeholder text with the remote HTML
            $(this).append($('<div>Loading</div>').
                //load('ajax.html .info', function() {
                load('http://test.outofeggs.com/iPhone/ajax.html .info', function() {

                    // Set the 'loaded' var to true so we know not to reload
                    // the HTML next time the #callback div animation ends
                    $(this).parent().data('loaded', true);
                }));
        }
    });
}

function BindAjaxPages() {
    $("#topLists").bind("pageAnimationEnd", function(e, info) {
    
        //Make sure the data hasn't already been loaded (we'll set 'loaded' to true a couple lines further down)
        if (!$(this).data("loaded")) {
        
            //Append a placeholder in case the remote HTML takes its sweet time making it back
            //Then, overwrite the "Loading" placeholder text with the remote HTML
            //TODO better ajax animation            
            $(this).append($("<div>Loading</div>").
                //load("http://localhost:1253/MobileApp/TopLists", function() {
                //load("http://test.outofeggs.com/iPhone/ajax.html .info", function() {
                //load("http://test.outofeggs.com/MobileApp/TopLists .info", function() {
                //load("/MobileApp/TopLists .info", function() {
                load("/MobileApp/TopLists", function() {

                //Set the 'loaded' var to true so we know not to reload
                //the HTML next time the #callback div animation ends
                $(this).parent().data("loaded", true);
            }));
        }
    });    
}

$(document).ready(function() {
    Test1();
    BindAjaxPages();
});
