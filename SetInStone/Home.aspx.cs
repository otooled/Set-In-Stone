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
        
        private SetInStoneEntities2  db = new SetInStoneEntities2();

        protected void Dispose(bool disposing)
        {
            db.Dispose();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
           
            
            if (!Page.IsPostBack)
            {
                //ddlStoneType.Attributes.Add("onchange", "stoneTexture();");

                //Populate menus on page load
                PopulateStoneMenu();
                PopulateSlabMenu();
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

            decimal slabHeight = Convert.ToDecimal(SlabHeight.Value);
            decimal pyramidHeight = Convert.ToDecimal(PryHeight.Value);

            decimal slabWidth = Convert.ToDecimal(SlabWidth.Value);
            decimal slabLength = Convert.ToDecimal(SlabLength.Value);

            decimal slabArea = slabWidth*slabLength;

            decimal heightTotal = (slabHeight + pyramidHeight);

            decimal slabCost = DetermineSlab(heightTotal);
            

            //decimal provionalSlabCost = (Convert.ToDecimal(ddlStoneType.SelectedValue)*
            //                    Convert.ToDecimal(ddlStoneSlab.SelectedValue)) * slabArea;



            //Pyramid surface area - formula A = lw+l.√(w2/2)²+h²+w.√(l/2)²+h²

            //step one of formula (L)(W)+(L)
            decimal fPart1 = slabArea + slabLength;

            //step two of formula (w2/2)²+h²+w - not getting the square root yet
            decimal fPart2 = (slabWidth/2)*(slabWidth/2) + (pyramidHeight*pyramidHeight) + slabWidth;

            //step three of formula (l/2)²+h² - not getting the square root yet

            decimal fPart3 = (slabLength/2)*(slabLength/2) + (pyramidHeight*pyramidHeight);

            //step four of formula - get square root of part 2 and part 3

            decimal sqrtOfPart2 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart2));
            decimal sqrtOfPart3 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart3));

            decimal surfaceAreaOfPyramid = fPart1*sqrtOfPart2*sqrtOfPart3;

            //method to calculate the cost of the cut, sending the surface of the area to 
            //the CalculatePyrimidAreaCutCost method
            //var dummyDecimal = CalculatePyrimidAreaCutCost(surfaceAreaOfPyramid);

            //lblCalculateAnswer.Text = dummyDecimal.ToString("#,##0.00");
            lblCalculateAnswer.Text = slabCost.ToString();

        }

        //private decimal CalculatePyrimidAreaCutCost(decimal surfaceArea)
        //{
        //    var costPerMetre = from c in db.Stone_Type
        //                       where c.StoneTypeID == Convert.ToByte(ddlStoneType.SelectedItem.Value)
        //                       select c.CutCost;

        //    return Convert.ToDecimal(costPerMetre)*surfaceArea;
        //    //decimal totalCutCost = 0;
        //    //if (ddlStoneType.SelectedIndex == 1)
        //    //{
        //    //    totalCutCost = ;
        //    //}
        //    //return totalCutCost;
        //}

        

        //Determines the slab height based on the slab deminsions
        private decimal DetermineSlab(decimal heightT)
        {
            //determine cost of the slab based on its depth and
            //stonetype granite selected by the user
            decimal slabCost =0;

            var findSlabCost =
                (from sc in db.Slabs
                 where sc.StoneId == ddlStoneType.SelectedIndex
                 select sc.Cost).ToList();

            //if (heightT < 2 && ddlStoneType.SelectedIndex == 1)
            //{
            //    slabCost = Convert.ToDecimal(findSlabCost.ToList());
            //}

            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 1) && (heightT < 3 && ddlStoneType.SelectedIndex == 1))
            {
                slabCost =  Convert.ToDecimal(findSlabCost);
            }

            //if (heightT > 3 && ddlStoneType.SelectedIndex == 1)
            //{
            //    slabCost
            //}

            ////determine cost of the slab based on its depth and
            ////stonetype limestone selected by the user
            //if (heightT < 2 && ddlStoneType.SelectedIndex == 2)
            //{
            //    slabCost
            //}
            //if ((heightT >= 2 && ddlStoneType.SelectedIndex == 2) && (heightT < 3 && ddlStoneType.SelectedIndex == 2))
            //{
            //   slabCost
            //}

            //if (heightT > 3 && ddlStoneType.SelectedIndex == 2)
            //{
            //    slabCost
            //}

            ////determine cost of the slab based on its depth and
            ////stonetype sandstone selected by the user
            //if (heightT < 2 && ddlStoneType.SelectedIndex == 3)
            //{
            //    slabCost
            //}
            //if ((heightT >= 2 && ddlStoneType.SelectedIndex == 3) && (heightT < 3 && ddlStoneType.SelectedIndex == 3))
            //{
            //    slabCost
            //}

            //if (heightT > 3 && ddlStoneType.SelectedIndex == 3)
            //{
            //    slabCost
            //}


             return slabCost;


        }

        private decimal CalculateCost(decimal stoneArea)
        {
            return stoneArea * (decimal)7.5;

            

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
            var stone = from s in db.Stone_Type select new { s.StoneType};
            ddlStoneType.DataSource = stone.ToList();
            //ddlStoneType.DataValueField = "CostPerSqMetre";
            ddlStoneType.DataTextField = "StoneType";
            ddlStoneType.DataBind();
            ddlStoneType.Items.Insert(0, "Select Stone Type");
        }
        private void PopulateSlabMenu()
        {
            //var slabsz = (from sz in db.Slab_Table
            //              select new { sz.SlabSize, sz.SlabCost }).ToList();
            //ddlStoneSlab.DataValueField = "SlabCost";
            //ddlStoneSlab.DataTextField = "SlabSize";
            //ddlStoneSlab.DataSource = slabsz;
            //ddlStoneSlab.DataBind();
            //ddlStoneSlab.Items.Insert(0, "--Select--");
        }
        private  void PopulateProductMenu()
        {
            var p = from pdt in db.Products select new {pdt.ProductType};
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

            if (ddlStoneType.SelectedIndex == 1)
            {
                //stoneTextureHF.Value = "Textures/Granite.jpg";
                //lblCalculateAnswer.Text = "hello";
            }
        }

    }
}