using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace OutOfEggs
{
    public static class MiscUtils
    {
        public static bool DevMode()
        {
            return (ConfigurationSettings.AppSettings["DevMode"] == "DEV");
        }

        //Simulate wait time in dev mode
        //Intended for AJAX calls
        public static void SleepIfDevMode(int milliseconds)
        {
            if (DevMode())
            { System.Threading.Thread.Sleep(milliseconds); }
        }

        //Default sleep time
        public static void SleepIfDevMode()
        {
            SleepIfDevMode(1000);
        }
    }
}
