using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net.Mail;

namespace OutOfEggs
{
    public partial class TestEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //SendThroughGmail();
            SendThroughHoster();

        }

        private void SendThroughHoster()
        {
            MailMessage mailMsg = new MailMessage();
            mailMsg.From = new MailAddress("support@outofeggs.com");
            mailMsg.To.Add("pderksen@gmail.com");
            mailMsg.Subject = "test subject h";
            mailMsg.Body = "test body h";
            mailMsg.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.EnableSsl = false;
            smtp.Send(mailMsg);
        }

        private void SendThroughGmail()
        {
            MailMessage mailMsg = new MailMessage();
            mailMsg.From = new MailAddress("outofeggs@gmail.com");
            mailMsg.To.Add("pderksen@gmail.com");
            mailMsg.Subject = "test subject g";
            mailMsg.Body = "test body g";
            mailMsg.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.EnableSsl = true;
            smtp.Send(mailMsg);
        }
    }
}
