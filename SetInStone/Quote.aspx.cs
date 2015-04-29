using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetInStone
{
    public partial class Quote1 : System.Web.UI.Page
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

        public Product pt = new Product();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["product"] != null)
            {
                pt = (Product)Session["product"];

            }
            if(!IsPostBack)
            {
                if(Session["quote"] != null)
                {
                    //string prt = (string)Session["productOptionID"];
                    //lblDisplayProd.Text = prt;
                    string quoteRef = (string) Session["quoteRef"];
                    lblDisplayQuoteRef.Text = quoteRef;

                    string quote = (string) Session["quote"];
                    lblDisplayQuote.Text = quote;
                }
                if (Session["productID"] != null)
                {
                    
                    //string quote = (string)Session["quote"];

                    //lblDisplayQuote.Text = quote;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
           // var qRef = Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();

            var customer = db.Customers.Where(a => a.First_Name ==txtFirstName.Text && a.Surname == txtSurname.Text).FirstOrDefault();
            if(customer == null)
            {
                Customer cust = new Customer{ First_Name = txtFirstName.Text, Surname = txtSurname.Text, Address = txtAddress.Text, Phone = (txtPhoneNo.Text)};
                db.Customers.Add(cust);
                db.SaveChanges();
            }
            var customer2 = db.Customers.Where(a => a.First_Name == txtFirstName.Text && a.Surname == txtSurname.Text).FirstOrDefault();
            if (Session["productOptionID"] != null)
            {
                var id = (string)Session["productOptionID"];
                pt.ProductOptionID = Convert.ToInt32(id);
            }
            db.Products.Add(pt);
            db.SaveChanges();

            Quote qute = new Quote();
            qute.CustomerId = customer2.CustomerID;
            qute.Price = Convert.ToDecimal(lblDisplayQuote.Text);
            //qute.Price = float.Parse(lblDisplayQuote.Text);
            qute.Quote_Ref = lblDisplayQuoteRef.Text;
            //qute.Quote_Ref = qRef;

            qute.ProductId = pt.ProductID;
            db.Quotes.Add(qute);
            db.SaveChanges();

            Response.Write("<script LANGUAGE='JavaScript' >alert('Quote has been saved.');document.location='" + ResolveClientUrl("~/LandingPage.aspx") + "';</script>");

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("LandingPage.aspx");
        }

        //protected void btnCancel_Click(object sender, EventArgs e)
        //{
        //    
        //}

        

        
    }
}