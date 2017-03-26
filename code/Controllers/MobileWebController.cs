//Mobile-browser pages

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Web.Security;

namespace OutOfEggs.Controllers
{
    public class MobileWebController : Controller
    {
        //TODO include ipad? or have them go to normal site?
        public ActionResult iPhone()
        {
            return View();
        }
    }
}
