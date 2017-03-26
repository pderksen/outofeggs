using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Text.RegularExpressions;

namespace OutOfEggs.Helpers
{
    public static class EmailHelper
    {
        public static void SendEmail(string mailFrom, string displayName, string mailTo, string subject, string body,
            bool isBodyHtml, string smtpUsername, string smtpPassword)
        {
            MailMessage mailMsg = new MailMessage();

            //TODO From email always gets set to SMTP account email.
            //Not sure why yet. Added ReplyTo for now.
            mailMsg.From = new MailAddress(mailFrom, displayName);
            mailMsg.ReplyTo = new MailAddress(mailFrom, displayName);
            mailMsg.To.Add(mailTo);
            mailMsg.Subject = subject;
            mailMsg.Body = body;
            mailMsg.IsBodyHtml = isBodyHtml;

            SmtpClient smtp = new SmtpClient();

            //Send SMTP credentials to override default to send from a different googl apps account
            if (smtpUsername != "")
                { smtp.Credentials = new NetworkCredential(smtpUsername, smtpPassword); }

            //Google needs SSL on
            smtp.EnableSsl = bool.Parse(ConfigurationSettings.AppSettings["MailSsl"]);

            smtp.Send(mailMsg);
        }

        //Calls SendEmail with from/ssl values from web.config already inserted
        public static void SendSupportEmail(string mailTo, string subject, string body, bool isBodyHtml)
        {
                SendEmail(ConfigurationSettings.AppSettings["SupportEmail"],
                    ConfigurationSettings.AppSettings["SupportEmailDisplayName"],
                    mailTo, subject, body, isBodyHtml,
                    "", "");
        }

        //Return true only if a valid email address
        public static bool ValidateEmail(string email)
        {
            const string regExEmail = @"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
            return Regex.IsMatch(email, regExEmail);
        }
    }
}
