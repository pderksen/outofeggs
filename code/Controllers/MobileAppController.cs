//Mobile app pages integrated with app using phonegap/jqtouch

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Web.Security;

using OutOfEggs.Models;

namespace OutOfEggs.Controllers
{
    public class MobileAppController : Controller
    {
        private ListRepository listRepo = new ListRepository();
        private SectionRepository secRepo = new SectionRepository();

        //Same data as /Lists/Top
        public ActionResult TopLists()
        {
            const string listUserName = "outofeggs";
            string listUserId = Membership.GetUser(listUserName).ProviderUserKey.ToString();

            ListRepository listRepo = new ListRepository();
            IQueryable<List> lists = listRepo.GetByUserId(listUserId);

            return PartialView(lists);
        }
    }
}
