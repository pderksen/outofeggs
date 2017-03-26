using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OutOfEggs.Helpers
{
    public static class StringHelper
    {
        public static string Left(string value, int maxLength)
        {
            if (value.Length <= maxLength)
            { return value; }
            else
            { return value.Substring(0, maxLength); }
        }
    }
}
