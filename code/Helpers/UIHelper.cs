using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OutOfEggs.Helpers
{
    public static class UIHelper
    {
        private const string FlashMsgSessionVar = "FlashMsg";

        //Sets flash message to session variable
        public static void SetFlashMsg(string value)
        {
            HttpContext.Current.Session[FlashMsgSessionVar] = value;
        }

        //Retrieves then erases flash message from session
        public static string GetFlashMsg()
        {
            if (HttpContext.Current.Session[FlashMsgSessionVar] != null)
            {
                string flashMsg = HttpContext.Current.Session[FlashMsgSessionVar].ToString();
                HttpContext.Current.Session[FlashMsgSessionVar] = null;
                return flashMsg;
            }
            else
            {
                return "";
            }
        }
    }
}
