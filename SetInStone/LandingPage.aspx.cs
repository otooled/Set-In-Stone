using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetInStone
{
    public partial class LandingPage : System.Web.UI.Page
    {
        private SetStone db = new SetStone();

        protected void Dispose(bool disposing)
        {
            db.Dispose();
        }

        public Product prt = new Product();

        private void Page_PreInit(object sender, System.EventArgs e)
        {
            PopulateProductMenu();

            if ((Session["loginDetails"] == null))
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        private void PopulateProductMenu()
        {
            var p = from pdt in db.ProductOptions select new { pdt };
            var pp = db.ProductOptions;
            ddlProductType.DataSource = pp.ToList();
            ddlProductType.DataValueField = "ProductOptionID";
            ddlProductType.DataTextField = "ProductOption1";
            ddlProductType.DataBind();
            ddlProductType.Items.Insert(0, "Select Product");

        }
        //protected void btnCreateQuote_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("Home.aspx");
        //}

        protected void btnRetrieveQuote_Click(object sender, EventArgs e)
        {
            Response.Redirect("RetrieveQuote.aspx");
        }

        protected void ddlProductType_SelectedIndexChanged1(object sender, EventArgs e)
        {
            if (ddlProductType.SelectedIndex == 1)
            {
                Session.Add("productOptionID",ddlProductType.SelectedValue);
                Response.Redirect("Home.aspx");
                
            }
        }


    }
}