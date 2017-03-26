using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Security.Principal;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI;

using OutOfEggs.Attributes;
using OutOfEggs.Helpers;

namespace OutOfEggs.Controllers
{

    public class AccountController : Controller
    {

        // This constructor is used by the MVC framework to instantiate the controller using
        // the default forms authentication and membership providers.

        public AccountController()
            : this(null, null)
        {
        }

        // This constructor is not used by the MVC framework but is instead provided for ease
        // of unit testing this type. See the comments at the end of this file for more
        // information.
        public AccountController(IFormsAuthentication formsAuth, IMembershipService service)
        {
            FormsAuth = formsAuth ?? new FormsAuthenticationService();
            MembershipService = service ?? new AccountMembershipService();
        }

        public IFormsAuthentication FormsAuth
        {
            get;
            private set;
        }

        public IMembershipService MembershipService
        {
            get;
            private set;
        }

        public ActionResult Login()
        {
            ViewData["FlashMsg"] = UIHelper.GetFlashMsg();

            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1054:UriParametersShouldNotBeStrings",
            Justification = "Needs to take same parameter type as Controller.Redirect()")]
        public ActionResult Login(string userName, string password, bool rememberMe, string returnUrl)
        {
            if (!ValidateLogin(userName, password))
            {
                return View();
            }

            FormsAuth.SignIn(userName, rememberMe);

            if (!String.IsNullOrEmpty(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        public ActionResult LogOut()
        {
            FormsAuth.SignOut();

            return RedirectToAction("Index", "Home");
        }

        public ActionResult Register()
        {
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        public ActionResult Register(string userName, string email, string password, string confirmPassword)
        {
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            if (ValidateRegistration(userName, email, password, confirmPassword))
            {
                // Attempt to register the user
                MembershipCreateStatus createStatus = MembershipService.CreateUser(userName, password, email);

                if (createStatus == MembershipCreateStatus.Success)
                {
                    string subject =
                        "Welcome to " + ConfigurationSettings.AppSettings["SiteName"];
                    string body =
                        "Dear " + userName + ",\n\n" +
                        "Thanks for joining " + ConfigurationSettings.AppSettings["SiteName"] +
                        ", the simplest way to create and print grocery lists.\n\n" +
                        "We hope you find this service easy to use and time saving. " +
                        "For any questions email us at support@outofeggs.com.\n\n" +
                        "Thanks,\n" +
                        "Phil Derksen\n" +
                        "Founder\n" +
                        ConfigurationSettings.AppSettings["BaseUrl"] + "\n";

                    try
                    {
                        //Send email to user
                        EmailHelper.SendSupportEmail(email, subject, body, false);

                        //Send email to admin
                        //EmailHelper.SendEmail(
                        //    "phil@outofeggs.com",
                        //    "OOE - New User Registration",
                        //    "Username: " + userName + "\n" +
                        //    "Email: " + email,
                        //    false);
                    }
                    catch
                    {
                        //TODO log error
                        //TODO show msg to user? probably not since we're just registering
                    }

                    /* OLD: Don't login, but start at login screen
                    UIHelper.SetFlashMsg("Your account has been created. Log in to get started.");
                    
                    //Redirect so flash msg shows up
                    return RedirectToAction("Login");
                    */

                    //Login and navigate to lists
                    UIHelper.SetFlashMsg("Your account has been created.");
                    FormsAuth.SignIn(userName, true);

                    //Redirect so flash msg shows up
                    return RedirectToAction("Index", "List");
                }
                else
                {
                    ModelState.AddModelError("_FORM", ErrorCodeToString(createStatus));
                }
            }

            // If we got this far, something failed. Redisplay form
            return View();
        }

        [Authorize]
        public ActionResult ChangePassword()
        {
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1031:DoNotCatchGeneralExceptionTypes",
            Justification = "Exceptions result in password not being changed.")]
        public ActionResult ChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            if (!ValidateChangePassword(currentPassword, newPassword, confirmPassword))
            {
                return View();
            }

            try
            {
                if (MembershipService.ChangePassword(User.Identity.Name, currentPassword, newPassword))
                {
                    ViewData["FlashMsg"] = "Your password has been updated.";
                    return View("Settings");
                }
                else
                {
                    ModelState.AddModelError("_FORM", "The current password is incorrect or the new password is invalid.");
                    return View();
                }
            }
            catch
            {
                ModelState.AddModelError("_FORM", "The current password is incorrect or the new password is invalid.");
                return View();
            }
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.User.Identity is WindowsIdentity)
            {
                throw new InvalidOperationException("Windows authentication is not supported.");
            }
        }

        //*** NEW ***
        [Authorize]
        public ActionResult Settings()
        {
            return View();
        }

        [Authorize]
        public ActionResult Profile()
        {
            MembershipUser currentUser = Membership.GetUser();
            ViewData["email"] = currentUser.Email;
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [Authorize]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        public ActionResult Profile(string email)
        {
            if (!ValidateProfile(email))
            {
                return View();
            }

            MembershipUser currentUser = Membership.GetUser();
            currentUser.Email = email;
            Membership.UpdateUser(currentUser);

            ViewData["FlashMsg"] = "Your email address has been updated.";
            return View("Settings");
        }

        public ActionResult ForgotPassword()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [IsPostedFromThisSite]
        [ValidateAntiForgeryToken]
        public ActionResult ForgotPassword(string email)
        {
            if (!ValidateForgotPassword(email))
            {
                return View();
            }

            string username = Membership.GetUserNameByEmail(email);
            MembershipUser user = Membership.GetUser(username);

            string newPassword = user.ResetPassword();
            string subject = 
                "Your new password for " + ConfigurationSettings.AppSettings["SiteName"];
            string body =
                "Your password has been reset.\n\n" +
                "Your username is: " + user.UserName + "\n" +
                "Your new password is: " + newPassword + "\n\n" +
                "Please log in to Out of Eggs using the following link, " +
                "then change your password to something more memorable.\n\n" +
                ConfigurationSettings.AppSettings["BaseUrl"]  + Url.Action("ChangePassword", "Account") + "\n\n" +
                "Out of Eggs Support\n";

            try
            {
                EmailHelper.SendSupportEmail(email, subject, body, false);

                UIHelper.SetFlashMsg("Check your inbox. A new password has been sent to your email address.");

                //Don't login, but start at login screen
                //Redirect so flash msg shows up
                return RedirectToAction("Login");
            }
            catch (Exception ex)
            {
                //TODO log error
                //ex.Message

                //Show error message to user
                ModelState.AddModelError("smtp",
                    "There was an error while attempting to send you an email. Please try again or contact " +
                    "support at support@outofeggs.com.");
                return View();
            }
        }

        #region Validation Methods (generated by asp.net mvc project)

        private bool ValidateChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            if (String.IsNullOrEmpty(currentPassword) || String.IsNullOrEmpty(newPassword) || String.IsNullOrEmpty(confirmPassword))
            {
                ModelState.AddModelError("_FORM", "Please complete all form fields.");
            }
            else
            {
                if (newPassword == null || newPassword.Length < MembershipService.MinPasswordLength)
                {
                    ModelState.AddModelError("newPassword",
                        String.Format(CultureInfo.CurrentCulture,
                             "Please enter a new password of {0} or more characters.",
                             MembershipService.MinPasswordLength));
                }

                if (!String.Equals(newPassword, confirmPassword, StringComparison.Ordinal))
                {
                    ModelState.AddModelError("_FORM", "The new password and confirmation password do not match.");
                }
            }

            return ModelState.IsValid;
        }

        private bool ValidateLogin(string userName, string password)
        {
            if (String.IsNullOrEmpty(userName) || String.IsNullOrEmpty(password))
            {
                ModelState.AddModelError("_FORM", "Please enter a username and password.");
            }
            else if (!MembershipService.ValidateUser(userName, password))
            {
                ModelState.AddModelError("_FORM", "The username or password provided is incorrect.");
            }

            return ModelState.IsValid;
        }

        private bool ValidateRegistration(string userName, string email, string password, string confirmPassword)
        {
            if (String.IsNullOrEmpty(userName))
            {
                ModelState.AddModelError("username", "Please enter a username.");
            }

            if (String.IsNullOrEmpty(email))
            {
                ModelState.AddModelError("email", "Please enter an email address.");
            }
            else if (!EmailHelper.ValidateEmail(email))
            {
                ModelState.AddModelError("email", "Please enter a valid email address.");
            }

            if (password == null || password.Length < MembershipService.MinPasswordLength)
            {
                ModelState.AddModelError("password",
                    String.Format(CultureInfo.CurrentCulture,
                         "Please enter a password of {0} or more characters.",
                         MembershipService.MinPasswordLength));
            }

            if (!String.Equals(password, confirmPassword, StringComparison.Ordinal))
            {
                ModelState.AddModelError("_FORM", "The new password and confirmation password do not match.");
            }

            return ModelState.IsValid;
        }

        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://msdn.microsoft.com/en-us/library/system.web.security.membershipcreatestatus.aspx for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Username already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A username for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion

        #region Validation Methods (custom)

        private const string regExEmail = @"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";

        private bool ValidateProfile(string email)
        {
            if (!EmailHelper.ValidateEmail(email))
            {
                ModelState.AddModelError("email", "Please enter a valid email address.");
            }

            return ModelState.IsValid;
        }

        private bool ValidateForgotPassword(string email)
        {
            if (!EmailHelper.ValidateEmail(email))
            {
                ModelState.AddModelError("email", "Please enter a valid email address.");
            }
            else if (Membership.FindUsersByEmail(email).Count == 0)
            {
                ModelState.AddModelError("email", "Sorry, we could not find that email address in our records.");
            }

            return ModelState.IsValid;
        }
        #endregion
    }

    // The FormsAuthentication type is sealed and contains static members, so it is difficult to
    // unit test code that calls its members. The interface and helper class below demonstrate
    // how to create an abstract wrapper around such a type in order to make the AccountController
    // code unit testable.

    public interface IFormsAuthentication
    {
        void SignIn(string userName, bool createPersistentCookie);
        void SignOut();
    }

    public class FormsAuthenticationService : IFormsAuthentication
    {
        public void SignIn(string userName, bool createPersistentCookie)
        {
            FormsAuthentication.SetAuthCookie(userName, createPersistentCookie);
        }
        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
    }

    public interface IMembershipService
    {
        int MinPasswordLength { get; }

        bool ValidateUser(string userName, string password);
        MembershipCreateStatus CreateUser(string userName, string password, string email);
        bool ChangePassword(string userName, string oldPassword, string newPassword);
        //bool UpdateProfile(string email);
    }

    public class AccountMembershipService : IMembershipService
    {
        private MembershipProvider _provider;

        public AccountMembershipService()
            : this(null)
        {
        }

        public AccountMembershipService(MembershipProvider provider)
        {
            _provider = provider ?? Membership.Provider;
        }

        public int MinPasswordLength
        {
            get
            {
                return _provider.MinRequiredPasswordLength;
            }
        }

        public bool ValidateUser(string userName, string password)
        {
            return _provider.ValidateUser(userName, password);
        }

        public MembershipCreateStatus CreateUser(string userName, string password, string email)
        {
            MembershipCreateStatus status;
            _provider.CreateUser(userName, password, email, null, null, true, null, out status);
            return status;
        }

        public bool ChangePassword(string userName, string oldPassword, string newPassword)
        {
            MembershipUser currentUser = _provider.GetUser(userName, true /* userIsOnline */);
            return currentUser.ChangePassword(oldPassword, newPassword);
        }
    }
}
