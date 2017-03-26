using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

using OutOfEggs.Attributes;
using OutOfEggs.Helpers;
using OutOfEggs.Models;

namespace OutOfEggs.Controllers
{
    public class SectionController : Controller
    {
        private SectionRepository secRepo = new SectionRepository();

        //
        // GET: /Section/Details/5

        //Used for debugging
        [Authorize]
        public ActionResult Details(long id)
        {
            var viewData = secRepo.GetById(id);
            return View(viewData);
        }

        // 
        // POST: /Section/Create

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        public ActionResult Create(long listId, int columnNum)
        {
            Section sec = new Section();

            sec.ListId = listId;
            sec.ColumnNum = columnNum;
            sec.SectionName = "New Category";
            sec.SortOrder = secRepo.GetNextSectionSortOrderValueByListIdColumnNum(listId, columnNum);
            secRepo.Insert(sec);
            secRepo.Save();

            MiscUtils.SleepIfDevMode();

            //Return partial view/user control, which contains html for the section
            return PartialView("SingleSection", sec);
        }

        //
        // POST: /Section/EditNameAndItems/5

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        [ValidateInput(false)]
        public ActionResult EditNameAndItems(long id, string sectionName, string itemNames)
        {
            Section sec = secRepo.GetById(id);

            //Change section name
            sec.SectionName = StringHelper.Left(sectionName, 50);

            //Delete all existing items in section
            secRepo.DeleteChildItems(sec);

            //Parse itemNames into an array
            string[] separator = new string[1] { "\n" };

            //In IE there are still \r parts that we have to strip out
            itemNames = itemNames.Replace("\r", "");

            string[] itemNameArray = itemNames.Split(separator, StringSplitOptions.RemoveEmptyEntries);

            //Add items in order
            InsertMultipleItems(sec, itemNameArray);
            secRepo.Save();

            MiscUtils.SleepIfDevMode();
            
            //Return partial view/user control, which contains html for the section
            return PartialView("SingleSection", sec);
        }

        //
        // POST: /Section/UpdateSortOrder/3

        //Post via ajax to update sort order of sections by column num
        //Format for section ids should look like: "section[]=1&section[]=9&section[]=2"
        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        public ActionResult UpdateSortOrder(int columnNum, string sectionIdQueryString)
        {
            string[] separator = new string[2] { "section[]=", "&" };
            string[] sectionIdArray = sectionIdQueryString.Split(separator, StringSplitOptions.RemoveEmptyEntries);

            //Don't hit database if no sections to update (column left empty).
            if (sectionIdArray.Length > 0)
            {
                secRepo.UpdateSortOrder(columnNum, sectionIdArray);
                secRepo.Save();

                MiscUtils.SleepIfDevMode();
            }

            return Content("Success");
        }

        //
        // POST: /Section/Delete/5

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        public ActionResult Delete(long id)
        {
            Section sec = secRepo.GetById(id);

            secRepo.Delete(sec);
            secRepo.Save();

            MiscUtils.SleepIfDevMode();

            return Content("Success");
        }

        #region Private Methods

        //Pass a string array of item names to insert for a section
        //Assume old items have already been cleared out and we're starting from sort order 1
        private void InsertMultipleItems(Section sec, string[] itemNames)
        {
            Item item;

            for (int i = 0; i < itemNames.Length; i++)
            {
                item = new Item();
                item.ItemName = StringHelper.Left(itemNames[i], 50);
                item.SortOrder = (i + 1);

                sec.Items.Add(item);
            }
        }

        #endregion
    }
}
