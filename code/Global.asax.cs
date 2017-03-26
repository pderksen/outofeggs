using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Elmah;

namespace OutOfEggs
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //Main URLs
            routes.MapRoute("about", "about", new { controller = "Home", action = "About" });
            routes.MapRoute("contact", "contact", new { controller = "Home", action = "Contact" });
            routes.MapRoute("login", "login", new { controller = "Account", action = "Login" });
            routes.MapRoute("logout", "logout", new { controller = "Account", action = "LogOut" });
            routes.MapRoute("privacy", "privacy", new { controller = "Home", action = "Privacy" });
            routes.MapRoute("register", "register", new { controller = "Account", action = "Register" });
            routes.MapRoute("terms", "terms", new { controller = "Home", action = "Terms" });
            routes.MapRoute("tour", "tour", new { controller = "Home", action = "Tour" });

            //List URLs
            routes.MapRoute("user lists", "lists", new { controller = "List", action = "Index" });
            routes.MapRoute("new list", "lists/new", new { controller = "List", action = "Create" });
            routes.MapRoute("top lists", "lists/top", new { controller = "List", action = "Top" });

            //Map generic list to a readable url (no id # in it)
            routes.MapRoute("generic list", "lists/basic", new { controller = "List", action = "Details",
                id = ConfigurationSettings.AppSettings["GenericListId"] });

            //http://outofeggs.com/1234 - Shortest url possible. Use this?
            //routes.MapRoute("list by id (no folders)", "{id}", new { controller = "List", action = "Details", id = @"\d+" });

            //http://outofeggs.com/lists/1234 - Not as short but fall back to this url if above becomes ambiguous
            routes.MapRoute("list by id (1 folder)", "lists/{id}", new { controller = "List", action = "Details" });
            
            routes.MapRoute("delete list", "delete/{id}", new { controller = "List", action = "Delete" });
            routes.MapRoute("print list", "print/{id}", new { controller = "List", action = "Print" });
            routes.MapRoute("copy list", "copy/{id}", new { controller = "List", action = "Copy" });

            //Mobile URLs
            //Just iPhone for now
            routes.MapRoute("mobile web - iphone", "iphone", new { controller = "MobileWeb", action = "iPhone" });

            //Default route (original)
            routes.MapRoute(
                "Default",                                              // Route name
                "{controller}/{action}/{id}",                           // URL with parameters
                new { controller = "Home", action = "Index", id = "" }  // Parameter defaults
            );
        }

        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);
        }

        //Filter out 404 errors
        protected void ErrorLog_Filtering(object sender, ExceptionFilterEventArgs e)
        {
            FilterError404(e);
        }

        protected void ErrorMail_Filtering(object sender, ExceptionFilterEventArgs e)
        {
            FilterError404(e);
        }

        //Dimiss 404 errors for ELMAH
        private void FilterError404(ExceptionFilterEventArgs e)
        {
            if (e.Exception.GetBaseException() is HttpException)
            {
                HttpException ex = (HttpException)e.Exception.GetBaseException();

                if (ex.GetHttpCode() == 404)
                {
                    e.Dismiss();
                }
            }
        }
    }
}