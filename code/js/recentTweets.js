$(document).ready(function()
{
    $("#recentTweets").getTwitter(
    {
        userName: "outofeggs",
        numTweets: 5,
        loaderText: "Loading tweets...",
        slideIn: false,
        showHeading: false,
        headingText: "Tweets",
        showProfileLink: false
    });
});
