using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using OutOfEggs.Attributes;
using OutOfEggs.Helpers;
using OutOfEggs.Models;

namespace OutOfEggs.Controllers
{
    public class HomeController : Controller
    {
        //VaryByHeader="User-Agent" needed for mobile site variations
        //[OutputCache (Duration = 3600, VaryByParam="none", VaryByHeader="User-Agent")]
        public ActionResult Index()
        {
            //Go to iPhone page if detected
            //if (MobileUtils.IsMobile2())
            if (MobileUtils.IsIPhone_Touch())
            {
                //return RedirectToAction("Index", "Mobile");
                //return RedirectToAction("Webkit", "Mobile");
                return RedirectToAction("iPhone", "MobileWeb");
            }

            if (Request.IsAuthenticated)
            {
                //Authenticated user - go to my lists
                return RedirectToAction("Index", "List");
            }
            else
            {
                //Unauthenticated user
                //Hardcoding top lists on home page for now
                ListRepository listRepo = new ListRepository();

                ViewData["HomeList1"] = listRepo.GetById(long.Parse(ConfigurationSettings.AppSettings["HomeListId1"]));
                ViewData["HomeList2"] = listRepo.GetById(long.Parse(ConfigurationSettings.AppSettings["HomeListId2"]));
                ViewData["HomeList3"] = listRepo.GetById(long.Parse(ConfigurationSettings.AppSettings["HomeListId3"]));
                ViewData["HomeList4"] = listRepo.GetById(long.Parse(ConfigurationSettings.AppSettings["HomeListId4"]));

                return View();
            }
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            ViewData["FlashMsg"] = UIHelper.GetFlashMsg();
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        public ActionResult Contact(string name, string email, string message)
        {
            if (ValidateContactFormSubmit(name, email, message))
            {
                //Submit form
                EmailHelper.SendEmail(
                    email, name, "inquiry@outofeggs.com",
                    ConfigurationSettings.AppSettings["SiteName"] + " Inquiry",
                    message, false,
                    "comments@outofeggs.com", "eggs4all");

                UIHelper.SetFlashMsg("Message sent");
            }
            else
            {
                return View();
            }

            //Setting flash message and redirecting for now to clear form.
            return RedirectToAction("Contact");
        }

        public ActionResult Privacy()
        {
            return View();
        }

        public ActionResult Terms()
        {
            return View();
        }

        public ActionResult Tour()
        {
            return View();
        }

        #region Validation Methods

        private bool ValidateContactFormSubmit(string name, string email, string message)
        {
            if (String.IsNullOrEmpty(name) || String.IsNullOrEmpty(email) || String.IsNullOrEmpty(message))
            {
                ModelState.AddModelError("_FORM", "Please complete all form fields.");
            }
            else if (!EmailHelper.ValidateEmail(email))
            {
                ModelState.AddModelError("email", "Please enter a valid email address.");
            }

            return ModelState.IsValid;
        }

        #endregion
    }
}
