using System;
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
        
        private SetInStoneEntities1  db = new SetInStoneEntities1();

        protected void Dispose(bool disposing)
        {
            db.Dispose();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                //Populate menus on page load
                PopulateStoneMenu();
                PopulateSlabMenu();
                PopulateProductMenu();
                

                //Forces the user to select a stone type
                if (ddlStoneType.SelectedIndex == 0) 
                {
                    btnCalculate.Enabled = false;
                    btnCalculate.ToolTip = "Please choose a Product & Stone Type";
                }
                
            }

        }
        

        protected void btnCalculate_Click(object sender, EventArgs e)
        {

            decimal slabHeight = Convert.ToDecimal(SlabHeight.Value);
            decimal pryamidHeight = Convert.ToDecimal(PryHeight.Value);

            decimal slabWidth = Convert.ToDecimal(SlabWidth.Value);

            decimal heightTotal = (slabHeight + pryamidHeight);

            DetermineSlab(heightTotal);

            decimal provionalSlabCost;
            provionalSlabCost = Convert.ToDecimal(ddlStoneType.SelectedValue)*
                                Convert.ToDecimal(ddlStoneSlab.SelectedValue);
            lblCalculateAnswer.Text = provionalSlabCost.ToString();   

            ////Call the method that calculates the size of the slab
            //CalculateDeminsions();

            ////Call the method that determines the size of the slab
            //DetermineSlab(ddlStoneSlab.SelectedIndex);
            //decimal testArea = 50;
            //DetermineSlab(testArea);
            ////Call the method that calculates the provisional cost of the slab (not including the width)
            //CalculateStoneSlabCost(Convert.ToDecimal(lblTotalCost.Text));

            ////Call the method that calculates the total (includes the width)
            //CalculateTotal(Convert.ToDecimal(lblCalculateAnswer.Text));
            ////lblTotalCost.Text = "hello";
        }

        private void CalculateDeminsions()
        {
            //Get deminsion values from the client
            decimal slabHeight = Convert.ToDecimal(SlabHeight.Value);
            decimal pryamidHeight = Convert.ToDecimal(PryHeight.Value);
            decimal slabWidth = Convert.ToDecimal(SlabWidth.Value);

            decimal heightTotal = (slabHeight + pryamidHeight);
            decimal widthTotal = (slabWidth * slabWidth);
            
            //Send the height total to the Determine slab method so the slab thickness can be worked out
            DetermineSlab(heightTotal);

            //Sent the width total to the Calculate slab method so a correct price can be worked out
            CalculateStoneSlabCost(widthTotal);

        }

        //Determines the slab height based on the slab deminsions
        private decimal DetermineSlab(decimal heightT)
        {
            if (heightT < 2)
            
            {
                ddlStoneSlab.SelectedIndex = 1;
            }
            else if (heightT >= 2 && heightT < 3)
           
            {
                ddlStoneSlab.SelectedIndex = 2;
            }

            else
            {
                ddlStoneSlab.SelectedIndex = 3;
            }

            return heightT;
            //decimal stoneArea = (decimal)1.2 * (decimal)0.8;
            //decimal totalCost = CalculateCost(stoneArea);
        }

        private decimal CalculateCost(decimal stoneArea)
        {
            return stoneArea * (decimal)7.5;

            //get area
            
            
            //calc stone cost
            //overall slab cost divided by ....
            
            //calc 1st cut
            //calc 2nd cut

        }

        private void CalculateStoneSlabCost(decimal widTot)
        {
            decimal stoneType = Convert.ToDecimal(ddlStoneType.SelectedValue);
            decimal stoneSlab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);

            decimal provionalSlabCost = (stoneSlab*stoneType);

            decimal finalSlabCost = provionalSlabCost*widTot;

            CalculateTotal(finalSlabCost);
            lblTotalCost.Text = finalSlabCost.ToString();
            //lblCalculateAnswer.Text = finalSlabCost.ToString();
            
        }

        private void CalculateTotal(decimal fsc)
        {
            decimal slabCost;//, slabHeight;
            slabCost = fsc;
            //slabCost = Convert.ToDecimal(lblCalculateAnswer.Text);
           // slabHeight = totalHet;
            //slabHeight = Convert.ToDecimal(lblDisplyHeightTotal.Text);

            decimal totalCost = (slabCost);//+slabHeight
            lblCalculateAnswer.Text = totalCost.ToString();
            
        }
       

        private void PopulateStoneMenu()
        {
            var stone = from s in  db.Stone_Type select new { s.StoneType, s.CostPerSqMetre };
            ddlStoneType.DataSource = stone.ToList();
            ddlStoneType.DataValueField = "CostPerSqMetre";
            ddlStoneType.DataTextField = "StoneType";
            ddlStoneType.DataBind();
            ddlStoneType.Items.Insert(0, "Select Stone Type");
        }
        private void PopulateSlabMenu()
        {
            var slabsz = (from sz in db.Slab_Table
                          select new { sz.SlabSize, sz.SlabCost }).ToList();
            ddlStoneSlab.DataValueField = "SlabCost";
            ddlStoneSlab.DataTextField = "SlabSize";
            ddlStoneSlab.DataSource = slabsz;
            ddlStoneSlab.DataBind();
            ddlStoneSlab.Items.Insert(0, "--Select--");
        }
        private  void PopulateProductMenu()
        {
            var p = from pdt in db.Product_Table select new {pdt.ProductType};
            ddlProductType.DataSource = p.ToList();
            ddlProductType.DataValueField = "ProductType";
            ddlProductType.DataTextField = "ProductType";
            ddlProductType.DataBind();
            ddlProductType.Items.Insert(0, "Select Product");

        }

        protected void ddlStoneType_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnCalculate.Enabled = true;
            btnCalculate.ToolTip = "Calculate";
        }

    }
}