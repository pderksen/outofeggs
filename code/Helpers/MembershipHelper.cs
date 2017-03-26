using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace OutOfEggs.Helpers
{
    public static class MembershipHelper
    {
        public static string GetCurrentUserId()
        {
            //Get reference to current user and retrieve unique user id
            MembershipUser currentUser = Membership.GetUser();

            if (currentUser != null)
            { return currentUser.ProviderUserKey.ToString(); }
            else
            { return ""; }
        }

        public static Guid? GetCurrentUserIdAsGuid()
        {

            if (GetCurrentUserId() != "")
            { return new Guid(GetCurrentUserId()); }
            else
            { return null; }
        }
    }
}
