using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSecurity
{
    public partial class SiteMaster : MasterPage
    {
        static string email = null;
        public bool isAuthenticated;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Email"] !=null)
            {
                isAuthenticated = true;
            }
            else
            {
                isAuthenticated = false;
            }
        }
    }
}