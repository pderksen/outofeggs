using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

using OutOfEggs.Attributes;
using OutOfEggs.Models;

namespace OutOfEggs.Controllers
{
    public class ItemController : Controller
    {
        private ItemRepository itemRepo = new ItemRepository();

        //
        // GET: /Item/Details/5

        //Used for debugging
        [Authorize]
        public ActionResult Details(long id)
        {
            var viewData = itemRepo.GetById(id);
            return View(viewData);
        }

        //Return list of items for a section that are formatted for the textarea control
        [Authorize]
        public ActionResult GetItemsForTextArea(long sectionId)
        {
            IQueryable<Item> itemList = itemRepo.GetBySectionId(sectionId);
            string itemListFormatted = "";

            foreach (Item item in itemList)
            {
                //Add "\n" for line break
                //Don't need to htmlencode using jquery .val()
                itemListFormatted += (item.ItemName + "\n");
            }

            MiscUtils.SleepIfDevMode();

            return Content(itemListFormatted);
        }

        //
        // POST: /Item/UpdateSortOrder/3

        //Post via ajax to update sort order of items by section
        //Format for item ids should look like: "item[]=1&item[]=9&item[]=2"
        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        public ActionResult UpdateSortOrder(long sectionId, string itemIdQueryString)
        {
            string[] separator = new string[2] { "item[]=", "&" };
            string[] itemIdArray = itemIdQueryString.Split(separator, StringSplitOptions.RemoveEmptyEntries);

            itemRepo.UpdateSortOrder(sectionId, itemIdArray);
            itemRepo.Save();

            MiscUtils.SleepIfDevMode();

            return Content("Success");
        }
    }
}
