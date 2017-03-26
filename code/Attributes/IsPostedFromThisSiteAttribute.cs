using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OutOfEggs.Attributes
{
    //Make sure request is coming from this site
    public class IsPostedFromThisSiteAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext != null)
            {
                if (filterContext.HttpContext.Request.UrlReferrer == null)
                {
                    throw new System.Web.HttpException("Invalid submission");
                }
                if (filterContext.HttpContext.Request.UrlReferrer.Host != filterContext.HttpContext.Request.Url.Host)
                {
                    throw new System.Web.HttpException("This form wasn't submitted from this site!");
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}
