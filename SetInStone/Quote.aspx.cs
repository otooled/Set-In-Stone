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

       // public 
       // public string qte = "";
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
                    string quote = (string) Session["quote"];
                   // qte = quote;
                    lblDisplayQuote.Text = quote;
                }
                
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var customer = db.Customers.Where(a => a.First_Name ==txtFirstName.Text && a.Surname == txtSurname.Text).FirstOrDefault();
            if(customer == null)
            {
                Customer cust = new Customer{ First_Name = txtFirstName.Text, Surname = txtSurname.Text, Address = txtAddress.Text, Phone = Convert.ToInt32(txtPhoneNo.Text)};
                db.Customers.Add(cust);
                db.SaveChanges();
            }
            var customer2 = db.Customers.Where(a => a.First_Name == txtFirstName.Text && a.Surname == txtSurname.Text).FirstOrDefault();

            db.Products.Add(pt);
            db.SaveChanges();

            Quote qute = new Quote();
            qute.CustomerId = customer2.CustomerID;
            qute.Price = float.Parse(lblDisplayQuote.Text);

            qute.ProductId = pt.ProductID;
            db.Quotes.Add(qute);
            db.SaveChanges();

        }

        

        
    }
}