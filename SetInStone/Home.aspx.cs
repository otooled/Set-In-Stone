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
        
        
       // private SetInStoneEntities4  db = new SetInStoneEntities4();
        private SIS2 db = new SIS2();

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
        //protected override void OnInit(EventArgs e)
        //{
        //    base.OnInit(e);
        //    if(Session.)
        //}
        protected void Page_Load(object sender, EventArgs e)
        {
        //    protected void Button1_Click(object sender, EventArgs e)
        //{
        //  Label1.Text =  Guid.NewGuid().ToString("N").Substring(0, 6).ToUpper();
        //}
            
            if (!Page.IsPostBack)
            {
                
                
                //ddlStoneType.Attributes.Add("onchange", "stoneTexture();");

                //Populate menus on page load
                PopulateStoneMenu();
               
                PopulateProductMenu();
                

                //Forces the user to select a stone type
                if (ddlStoneType.SelectedIndex == 0) 
                {
                    //btnCalculate.Enabled = false;
                    btnCalculate.ToolTip = "Please choose a Product & Stone Type";
                }
                
                
            }

        }
        

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            
            float slabSurfaceCost = CustomerSlabDetails();
            float pyrSurfaceArea = PyramidSurface();
            float cutCost = CalculateStraightCuts();

            //float custSlabHeight = DetermineSlab();
            //float slabcost = DetermineLStoneSlabCost();

            ////Display final cost of stone work
            //lblCalculateAnswer.Text = (pyrSurfaceArea + slabSurfaceCost).ToString("c2");//"c2"
            lblCalculateAnswer.Text = cutCost.ToString();//"c2"
        }

        private float PyramidSurface()
        {
            //Measurements entered by the user through the slider control
            string sType = ddlStoneType.SelectedValue;
            float slabWidth = float.Parse(SlabWidth.Value);
            float slabHeight = float.Parse(SlabHeight.Value);
            float pyramidHeight = float.Parse(PryHeight.Value);
            float slabLength = float.Parse(SlabLength.Value);

            var surface = CalcClasses.Cost.PyramidCutCost(sType, slabWidth, slabHeight, pyramidHeight, slabLength);
            return surface;
        }

        private float CustomerSlabDetails()
        {
            //Measurements entered by the user through the slider control
            string sType = ddlStoneType.SelectedValue;
            float slabWidth = float.Parse(SlabWidth.Value);
            float slabHeight = float.Parse(SlabHeight.Value);
            //float pyramidHeight = float.Parse(PryHeight.Value);
            
            float slabLength = float.Parse(SlabLength.Value);

           var price = CalcClasses.Cost.CalcCost(sType, slabWidth, slabHeight, slabLength);
            return price;
        }

        private float CalculateStraightCuts()
        {
            string sType = ddlStoneType.SelectedValue;
            float slabWidth = float.Parse(SlabWidth.Value);
            float slabHeight = float.Parse(SlabHeight.Value);
            float slabLength = float.Parse(SlabLength.Value);

            var cutCost = CalcClasses.Cost.CalcStraightCuts(sType, slabWidth, slabHeight, slabLength);
            return cutCost;
        }


        
        
        

        private void PopulateStoneMenu()
        {
            var stone = from s in db.Stones select new { s.StoneType};
            ddlStoneType.DataSource = stone.ToList();
            //ddlStoneType.DataValueField = "CostPerSqMetre";
            ddlStoneType.DataTextField = "StoneType";
            ddlStoneType.DataBind();
            ddlStoneType.Items.Insert(0, "Select Stone Type");
        }
       
        private  void PopulateProductMenu()
        {
            //var p = from pdt in db. select new {pdt.ProductType};
            //ddlProductType.DataSource = p.ToList();
            //ddlProductType.DataValueField = "ProductType";
            //ddlProductType.DataTextField = "ProductType";
            //ddlProductType.DataBind();
            //ddlProductType.Items.Insert(0, "Select Product");

        }

        protected void ddlStoneType_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnCalculate.Enabled = true;
            btnCalculate.ToolTip = "Calculate";

            if (ddlStoneType.SelectedIndex == 1)
            {
                //stoneTextureHF.Value = "Textures/Granite.jpg";
                //lblCalculateAnswer.Text = "hello";
            }
        }

    }
}