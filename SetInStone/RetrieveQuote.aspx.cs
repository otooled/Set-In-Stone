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

        public Product pdct = new Product();

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
                var q = db.Quotes.Where(a => a.Quote_Ref == txtQuoteRef.Text.ToUpper()).FirstOrDefault();
                lblFirstName.Text = q.Customer.First_Name;
                lblSurname.Text = q.Customer.Surname;
                lblAddress.Text = q.Customer.Address;
                lblPhoneNo.Text = q.Customer.Phone.ToString();
                lblProduct.Text = q.Product.ProductOption.ProductOption1;
                lblStone.Text = db.Stones.Where(a => a.StoneId == q.Product.StoneId).FirstOrDefault().StoneType;
                //lblPrice.Text = String.Format("0.##", q.Price);
                lblPrice.Text = q.Price.ToString();

                if (q.Quote_Ref == txtQuoteRef.Text)
                {
                    btnEditQuote.Visible = true;
                    btnPlaceOrder.Visible = true;
                }
                

            }
            catch (Exception)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Quote Retrieval Error", "alert('This quote does not exist');", true);
                //Response.Write("Quote retrieval error","<script>alert('This Quote Ref does not exist.');</script>");
                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Quote retrieval error", "<script>alert('This Quote Ref does not exist.');</script>");
                
            }
            
        }

        protected void btnEditQuote_Click(object sender, EventArgs e)
        {
            try
            {
                var q = db.Quotes.Where(a => a.Quote_Ref == txtQuoteRef.Text.ToUpper()).FirstOrDefault();
            
                if(Page.IsValid)
                {
                    Session.Add("quote",q);
                    Session.Add("EditMode", true);
                    Response.Redirect("ProductPage.aspx");
                }
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}