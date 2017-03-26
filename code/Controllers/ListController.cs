using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Web.Security;

using OutOfEggs.Attributes;
using OutOfEggs.Helpers;
using OutOfEggs.Models;

namespace OutOfEggs.Controllers
{
    public class ListController : Controller
    {
        private ListRepository listRepo = new ListRepository();
        private SectionRepository secRepo = new SectionRepository();

        private const string NewListName = "Untitled List";

        //Return partial view using Html.RenderAction (from MVC Futures - Microsoft.Web.Mvc.dll)
        public ActionResult SingleListSummary(long id)
        {
            List singleList = listRepo.GetById(id);

            //Get top X sections and format to string
            List<Section> topSectionsCol = singleList.Sections.OrderBy(s => s.ColumnNum).ThenBy(s => s.SortOrder).Take(5).ToList();
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < topSectionsCol.Count(); i++)
            {
                //Prepend seperator after first item
                if (i != 0) { sb.Append(" | "); }

                sb.Append(topSectionsCol[i].SectionName);
            }

            ViewData["TopSectionsString"] = sb.ToString();

            return PartialView("SingleListSummary", singleList);
        }

        //
        // GET: /List/

        //"Your Lists"
        [Authorize]
        public ActionResult Index()
        {
            //Retrieve lists associated to the current user
            ListRepository listRepo = new ListRepository();
            IQueryable<List> lists = listRepo.GetByUserId(MembershipHelper.GetCurrentUserId());

            ViewData["FlashMsg"] = UIHelper.GetFlashMsg();

            //View still returns lists collection
            return View(lists);
        }

        //
        // GET: /List/Top

        //Same as index except returns the top lists for the use of copying
        //Currently these are specific to user "outofeggs"
        public ActionResult Top()
        {
            const string listUserName = "outofeggs";
            string listUserId = Membership.GetUser(listUserName).ProviderUserKey.ToString();

            ListRepository listRepo = new ListRepository();
            IQueryable<List> lists = listRepo.GetByUserId(listUserId);

            //View still returns lists collection
            return View(lists);
        }

        //
        // GET: /List/Details/5

        public ActionResult Details(long id)
        {
            //Don't allow page to be cached so hitting back button from other pages reloads this page
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            List singleList = listRepo.GetById(id);

            if (singleList.UserId == MembershipHelper.GetCurrentUserIdAsGuid())
            {
                ViewData["UserOwns"] = "true";
            }
            else
            {
                ViewData["UserOwns"] = "false";
            }

            //Display modal dialog to rename list if default name detected
            if (singleList.ListName == NewListName)
            {
                ViewData["ShowRenameListDialog"] = "true";
            }

            ViewData["FlashMsg"] = UIHelper.GetFlashMsg();

            return View(singleList);
        }

        //
        // POST: /List/ColumnContent/5
        
        //Currently using POST as that's how ID is passed in using jQuery's .load()
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ColumnContent(long id)
        {
            MiscUtils.SleepIfDevMode();

            List singleList = listRepo.GetById(id);
            return PartialView(singleList);
        }

        //
        // GET: /List/Print/5

        public ActionResult Print(long id)
        {
            List singleList = listRepo.GetById(id);
            return View(singleList);
        }

        //
        // GET: /List/Create

        [Authorize]
        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /List/Create

        //Section names passed in with carriage return separators
        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        public ActionResult Create(string listName, string sectionNames)
        {
            if (!ValidateListName(listName))
            {
                return View();
            }

            List list = new List();
            
            list.ListName = listName;
            list.UserId = new Guid(MembershipHelper.GetCurrentUserId());
            listRepo.Insert(list);
            listRepo.Save();

            //Split section list value into array separated by carriage returns
            string[] secNamesArray = sectionNames.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);

            if (secNamesArray.Length > 0)
            {
                secRepo.InsertMultipleSections(list.ListId, secNamesArray);
                secRepo.Save();
            }

            if (!MiscUtils.DevMode())
            {
                try
                {
                    //Send email to admin
                    EmailHelper.SendEmail("admin@outofeggs.com", "OOE Admin",
                        "phil@outofeggs.com", "OOE - New List Created",
                        "Username: " + User.Identity.Name + "\n" +
                        "List name: " + listName + "\n" +
                        "List URL: http://outofeggs.com/lists/" + list.ListId,
                        false, "admin@outofeggs.com", "eggs4all");
                }
                catch
                {
                }
            }

            UIHelper.SetFlashMsg("List created. You may now start editing this list.");

            return RedirectToAction("Details", new { id = list.ListId });
        }

        //
        // POST: /List/EditName/5

        //Post via ajax to update list name
        //Currently uses jEditable plugin
        //Allow unsafe characters, but HtmlEncode before displaying
        //TODO validate input = false?
        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        [ValidateInput(true)]
        public ActionResult EditName(long id, string listName)
        {
            List list = listRepo.GetById(id);

            //Send email if renaming from original list name
            if ((list.ListName == NewListName) && !MiscUtils.DevMode())
            {
                try
                {
                    //Send email to admin
                    EmailHelper.SendEmail("admin@outofeggs.com", "OOE Admin",
                        "phil@outofeggs.com", "OOE - New List Copied",
                        "Username: " + User.Identity.Name + "\n" +
                        "List name: " + listName + "\n" +
                        "List URL: http://outofeggs.com/lists/" + list.ListId,
                        false, "admin@outofeggs.com", "eggs4all");
                }
                catch
                {
                }
            }

            //For now saving straight html (unencoded) to database
            //See http://www.asp.net/learn/mvc/tutorial-06-cs.aspx
            list.ListName = StringHelper.Left(listName, 50);
            //sec.SectionName = HttpUtility.HtmlEncode(sectionName);
            listRepo.Save();

            MiscUtils.SleepIfDevMode();

            //Return new name html encoded. Needed for display.
            //TODO final solution will be different
            return Content(HttpUtility.HtmlEncode(list.ListName));
        }

        //
        // Get: /List/Delete/5

        [Authorize]
        public ActionResult Delete(long id)
        {
            List myList = listRepo.GetById(id);
            return View(myList);
        }

        //
        // POST: /List/Delete/5

        //Confirm button parameter makes it so POST call signature is different than GET call
        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(long id, string confirmBtn)
        {
            List list = listRepo.GetById(id);

            listRepo.Delete(list);
            listRepo.Save();

            MiscUtils.SleepIfDevMode();

            UIHelper.SetFlashMsg("List deleted");

            return RedirectToAction("Index");
        }

        //Make an exact copy of a list for the current user
        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        public ActionResult Copy(long id)
        {
            //Create target list, copy list name and set user id
            List sourceList = listRepo.GetById(id);
            List targetList = new List();

            targetList.UserId = new Guid(MembershipHelper.GetCurrentUserId());
            targetList.ListName = NewListName;

            //Loop through all sections and add to target list
            foreach (Section sourceSec in sourceList.Sections)
            {
                Section targetSec = new Section();
                targetSec.SectionName = sourceSec.SectionName;
                targetSec.ColumnNum = sourceSec.ColumnNum;
                targetSec.SortOrder = sourceSec.SortOrder;

                //Loop through all items and add to target section
                foreach (Item sourceItem in sourceSec.Items)
                {
                    Item targetItem = new Item();
                    targetItem.ItemName = sourceItem.ItemName;
                    targetItem.SortOrder = sourceItem.SortOrder;

                    targetSec.Items.Add(targetItem);
                }

                targetList.Sections.Add(targetSec);
            }

            //Finally save the list (and all child records) and return the new id
            listRepo.Insert(targetList);
            listRepo.Save();

            MiscUtils.SleepIfDevMode();

            //Removed message since now modal dialog comes up to name list
            //UIHelper.SetFlashMsg("Copy complete. You may now start editing this list.");

            return RedirectToAction("Details", new { id = targetList.ListId });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        public ActionResult EmailToSelf(long id)
        {
            List list = listRepo.GetById(id);
            string subject = "List: " + list.ListName;

            //Loop through list to add sections and items in order
            string body = "";
            foreach (Section sec in list.Sections.OrderBy(s => s.ColumnNum).ThenBy(s => s.SortOrder))
            {
                body += "=== " + sec.SectionName + " ===\n\n";

                foreach (Item item in sec.Items.OrderBy(i => i.SortOrder))
                {
                    //Don't render blank lines (dashes)
                    if (item.ItemName != "-")
                    {
                        body += item.ItemName + "\n";
                    }
                }
                body += "\n";
            }

            body += "List created at outofeggs.com\n";

            MembershipUser user = Membership.GetUser();

            EmailHelper.SendEmail(
                "lists@outofeggs.com", "Out of Eggs",
                user.Email, subject, body, false,
                "lists@outofeggs.com", "eggs4all");

            //UIHelper.SetFlashMsg("List emailed to " + emailTo);
            MiscUtils.SleepIfDevMode();

            return Content("Success");
        }

        //
        // Private Methods

        private bool ValidateListName(string listName)
        {
            if (String.IsNullOrEmpty(listName))
            {
                ModelState.AddModelError("listName", "You must specify a List Name.");
            }

            return ModelState.IsValid;
        }
    }
}
