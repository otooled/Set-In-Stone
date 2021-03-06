﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;
using System.Windows.Forms;

namespace SetInStone
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        //product option for session
        public Product prt = new Product();
 
       //database connection
        private SetStone db = new SetStone();

        protected void Dispose(bool disposing)
        {
            db.Dispose();
        }

        //Check user is logged in
        private void Page_PreInit(object sender, System.EventArgs e)
        {
            if ((Session["loginDetails"] == null))
            {
                Response.Redirect("Login.aspx");
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
       
            if (!Page.IsPostBack)
            {
                //The following commented out code will be used
                //editing a quote

                //if ((Session["EditMode"] != null) && true)
                //{
                //    if ((Session["quote"] != null))
                //    {
                //        Quote q = (Quote)Session["quote"];
                        
                //    }
                //}
                //else
                //{
                    //ddlStoneType.Attributes.Add("onchange", "stoneTexture();");
                //}
                //Populate stone menu

                PopulateStoneMenu();
            }

        }
        

        protected void btnCalculate_Click(object sender, EventArgs e)
        {

            //variables to hold cost and cutting calculation results
            float qauntity = float.Parse(txtQuantity.Text);
            float slabSurfaceCost = CustomerSlabDetails();
            float pyrSurfaceArea = PyramidSurface();
            float cutCost = CalculateStraightCuts();
            float total = (pyrSurfaceArea + slabSurfaceCost + cutCost);

            //Display final cost of stone work
            lblCalculateAnswer.Text = (total * qauntity).ToString("#.##");

        }

        private float PyramidSurface()
        {
            //Measurements entered by the user through the slider control
            int sType = Convert.ToInt32( ddlStoneType.SelectedValue);
            float slabWidth = float.Parse(SlabWidth.Value);
            float slabHeight = float.Parse(SlabHeight.Value);
            float pyramidHeight = float.Parse(PryHeight.Value);
            float slabLength = float.Parse(SlabLength.Value);

            //calculations performed cost class
            var surface = CalcClasses.Cost.PyramidCutCost(sType, slabWidth, slabHeight, pyramidHeight, slabLength);
            return surface;
        }

        private float CustomerSlabDetails()
        {
            //Measurements entered by the user through the slider control
            int sType = Convert.ToInt32(ddlStoneType.SelectedValue);
            float slabWidth = float.Parse(SlabWidth.Value);
            float slabHeight = float.Parse(SlabHeight.Value);
            float slabLength = float.Parse(SlabLength.Value);

            //calculations performed cost class
            var price = CalcClasses.Cost.CalcCost(sType, slabWidth, slabHeight, slabLength);
            return price;
        }

        private float CalculateStraightCuts()
        {
            //Measurements entered by the user through the slider control
            int sType = Convert.ToInt32(ddlStoneType.SelectedValue);
            float slabWidth = float.Parse(SlabWidth.Value);
            float slabHeight = float.Parse(SlabHeight.Value);
            float slabLength = float.Parse(SlabLength.Value);

            //calculations performed cost class
            var cutCost = CalcClasses.Cost.CalcStraightCuts(sType, slabWidth, slabHeight, slabLength);
            return cutCost;
        }
        

        private void PopulateStoneMenu()
        {
            var stone = from s in db.Stones select new { s.StoneType};
            var stonee = db.Stones.ToList();
            ddlStoneType.DataSource = stonee;//.ToList();
            ddlStoneType.DataValueField = "StoneId";
            ddlStoneType.DataTextField = "StoneType";
            ddlStoneType.DataBind();
            ddlStoneType.Items.Insert(0, "Select Stone Type");
        }
     

        protected void ddlStoneType_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnCalculate.Enabled = true;
            btnCalculate.ToolTip = "Calculate";

            //attempt at controlling Three.js texture with server side dropdown menu
            if (ddlStoneType.SelectedIndex == 1)
            {
                //stoneTextureHF.Value = "Textures/Granite.jpg";
                
            }
                     
        }

        //Save user inputs
        protected void btnSaveConfirm_Click(object sender, EventArgs e)
        {
            //generate a random alphanumeric string for Quote Reference
            string qRef = Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();

            //This is for editing a quote which is implemented yet
            if(Page.IsValid)
            {
                if ((Session["EditMode"] != null) && true)
                {
                    if ((Session["quote"] != null))
                    {
                        Quote q = (Quote)Session["quote"];
                        q.Product.Width = float.Parse(SlabWidth.Value);
                        q.Product.StoneId = Convert.ToInt32(ddlStoneType.SelectedValue);

                        q.Product.Height = float.Parse(SlabHeight.Value);
                        q.Product.Length = float.Parse(SlabLength.Value);
                        q.Product.PyrHeight = float.Parse(PryHeight.Value);
                        db.SaveChanges();
                    }
                }

                    //This adds product deminsions into session
                else
                {
                    
                    prt.Width = float.Parse(SlabWidth.Value);
                    prt.StoneId = Convert.ToInt32(ddlStoneType.SelectedValue);

                    prt.Height = float.Parse(SlabHeight.Value);
                    prt.Length = float.Parse(SlabLength.Value);
                    prt.PyrHeight = float.Parse(PryHeight.Value);
                    Session.Add("quoteRef",qRef);
                    Session.Add("quote", lblCalculateAnswer.Text);
                    Session.Add("product", prt);
                    
                    Response.Redirect("Quote.aspx");
                }
                
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("LandingPage.aspx");
        }

    }
}