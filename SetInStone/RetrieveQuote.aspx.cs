using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetInStone
{
    public partial class RetrieveQuote : System.Web.UI.Page
    {
        private SetStone db = new SetStone();

        protected void Dispose(bool disposing)
        {
            db.Dispose();
        }

        private void Page_PreInit(object sender, System.EventArgs e)
        {
            if ((Session["loginDetails"] == null))
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            btnEditQuote.Visible = false;
            btnPlaceOrder.Visible = false;

        }

        protected void btnRetrieveQuote_Click(object sender, EventArgs e)
        {
            
            try
            {
                var q = db.Quotes.Where(a => a.Quote_Ref == txtQuoteRef.Text).FirstOrDefault();
                lblFirstName.Text = q.Customer.First_Name;

                if (q.Quote_Ref != txtQuoteRef.Text)
                {
                    btnEditQuote.Visible = true;
                    btnPlaceOrder.Visible = true;
                }
                

            }
            catch (Exception)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Your Message');", true);
                //Response.Write("Quote retrieval error","<script>alert('This Quote Ref does not exist.');</script>");
                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Quote retrieval error", "<script>alert('This Quote Ref does not exist.');</script>");
                
            }
            
        }
    }
}