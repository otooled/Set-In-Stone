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
        
        private SetInStoneEntities4  db = new SetInStoneEntities4();

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

            decimal customerSlabArea = slabWidth*slabLength;

            decimal heightTotal = (slabHeight + pyramidHeight);

            decimal slabCost = DetermineSlab(heightTotal);

            decimal stockSlabWidth = DetermineStockSlabWidth(heightTotal);

            decimal stockSlabHeight = DetermineStockSlabLength(heightTotal);

            decimal stockSlabArea = stockSlabWidth*stockSlabHeight;

            decimal customerSlabCost = (customerSlabArea/stockSlabArea)*slabCost;
            

            //decimal provionalSlabCost = (Convert.ToDecimal(ddlStoneType.SelectedValue)*
            //                    Convert.ToDecimal(ddlStoneSlab.SelectedValue)) * slabArea;



            //Pyramid surface area - formula A = lw+l.√(w2/2)²+h²+w.√(l/2)²+h²

            //step one of formula (L)(W)+(L)
            decimal fPart1 = customerSlabArea + slabLength;

            //step two of formula (w/2)²+h²+w - not getting the square root yet
            decimal fPart2 = (slabWidth / 2) * (slabWidth / 2) + (pyramidHeight * pyramidHeight) + slabWidth;

            //step three of formula (l/2)²+h² - not getting the square root yet

            decimal fPart3 = (slabLength/2)*(slabLength/2) + (pyramidHeight*pyramidHeight);

            //step four of formula - get square root of part 2 and part 3

            decimal sqrtOfPart2 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart2));
            decimal sqrtOfPart3 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart3));

            decimal surfaceAreaOfPyramid = fPart1*sqrtOfPart2*sqrtOfPart3;

            decimal costOfPyrCut = DeterminePyramidCutCost(surfaceAreaOfPyramid);

            //method to calculate the cost of the cut, sending the surface of the area to 
            //the CalculatePyrimidAreaCutCost method
            //var dummyDecimal = CalculatePyrimidAreaCutCost(surfaceAreaOfPyramid);

            //lblCalculateAnswer.Text = dummyDecimal.ToString("#,##0.00");
            lblCalculateAnswer.Text = surfaceAreaOfPyramid.ToString();

        }

        private decimal DeterminePyramidCutCost(decimal pyrArea)
        {
            decimal pyrCutCost = 0;

            var cutCalcCost =
                (from cc in db.Slabs

                 where cc.StoneId == ddlStoneType.SelectedIndex
                 select cc.CutCostPerSqMtr).ToList();

            //var slabLength =
            //   (from sl in db.Slabs
            //    where sl.StoneId == ddlStoneType.SelectedIndex
            //    select sl.Length).ToList();

            if (ddlStoneType.SelectedIndex == 1)
            {
                pyrCutCost = (Decimal)cutCalcCost.FirstOrDefault();
            }

            else if (ddlStoneType.SelectedIndex == 2)
            {
                pyrCutCost = (Decimal)cutCalcCost.ElementAt(1);
            }

            else if (ddlStoneType.SelectedIndex == 3)
            {
                pyrCutCost = (Decimal)cutCalcCost.ElementAt(2);
            }

            return pyrCutCost * pyrArea;
        }

        private decimal DetermineStockSlabLength(decimal heightT)
        {
            //determine cost of the slab based on its depth and
            //stonetype granite selected by the user
            decimal stockSlabLength = 0;

            var slabLength =
                (from sl in db.Slabs
                 where sl.StoneId == ddlStoneType.SelectedIndex
                 select sl.Length).ToList();

            if (heightT < 2 && ddlStoneType.SelectedIndex == 1)
            {
                stockSlabLength = (Decimal)slabLength.FirstOrDefault();
            }

            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 1) && (heightT < 3 && ddlStoneType.SelectedIndex == 1))
            {
                stockSlabLength = (Decimal)slabLength.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 1)
            {
                stockSlabLength = (Decimal)slabLength.ElementAt(2);
            }

            ////determine cost of the slab based on its depth and
            ////stonetype limestone selected by the user
            if (heightT < 2 && ddlStoneType.SelectedIndex == 2)
            {
                stockSlabLength = (Decimal)slabLength.FirstOrDefault();
            }
            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 2) && (heightT < 3 && ddlStoneType.SelectedIndex == 2))
            {
                stockSlabLength = (Decimal)slabLength.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 2)
            {
                stockSlabLength = (Decimal)slabLength.ElementAt(2);
            }

            ////determine cost of the slab based on its depth and
            ////stonetype sandstone selected by the user
            if (heightT < 2 && ddlStoneType.SelectedIndex == 3)
            {
                stockSlabLength = (Decimal)slabLength.FirstOrDefault();
            }
            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 3) && (heightT < 3 && ddlStoneType.SelectedIndex == 3))
            {
                stockSlabLength = (Decimal)slabLength.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 3)
            {
                stockSlabLength = (Decimal)slabLength.ElementAt(2);
            }

            return stockSlabLength;
        }

        private decimal DetermineStockSlabWidth(decimal heightT)
        {
            //determine cost of the slab based on its depth and
            //stonetype granite selected by the user
            decimal stockSlabWidth = 0;

            var slabWidth  =
                (from sw in db.Slabs
                 where sw.StoneId == ddlStoneType.SelectedIndex
                 
                 select sw.Width).ToList();

            if (heightT < 2 && ddlStoneType.SelectedIndex == 1)
            {
                stockSlabWidth = (Decimal) slabWidth.FirstOrDefault();
            }

            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 1) && (heightT < 3 && ddlStoneType.SelectedIndex == 1))
            {
                stockSlabWidth = (Decimal)slabWidth.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 1)
            {
                stockSlabWidth = (Decimal)slabWidth.ElementAt(2);
            }

            ////determine cost of the slab based on its depth and
            ////stonetype limestone selected by the user
            if (heightT < 2 && ddlStoneType.SelectedIndex == 2)
            {
                stockSlabWidth = (Decimal)slabWidth.FirstOrDefault();
            }
            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 2) && (heightT < 3 && ddlStoneType.SelectedIndex == 2))
            {
                stockSlabWidth = (Decimal)slabWidth.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 2)
            {
                stockSlabWidth = (Decimal)slabWidth.ElementAt(2);
            }

            ////determine cost of the slab based on its depth and
            ////stonetype sandstone selected by the user
            if (heightT < 2 && ddlStoneType.SelectedIndex == 3)
            {
                stockSlabWidth = (Decimal)slabWidth.FirstOrDefault();
            }
            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 3) && (heightT < 3 && ddlStoneType.SelectedIndex == 3))
            {
                stockSlabWidth = (Decimal)slabWidth.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 3)
            {
                stockSlabWidth = (Decimal)slabWidth.ElementAt(2);
            }

            return stockSlabWidth;
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
            decimal slabCost = 0;

            var findSlabCost =
                (from sc in db.Slabs
                 where sc.StoneId == ddlStoneType.SelectedIndex
                 
                 select sc.Cost).ToList();

            if (heightT < 2 && ddlStoneType.SelectedIndex == 1)
            {
                slabCost = (Decimal) findSlabCost.FirstOrDefault();
            }

            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 1) && (heightT < 3 && ddlStoneType.SelectedIndex == 1))
            {
                slabCost = (Decimal) findSlabCost.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 1)
            {
                slabCost = (Decimal)findSlabCost.ElementAt(2);
            }

            ////determine cost of the slab based on its depth and
            ////stonetype limestone selected by the user
            if (heightT < 2 && ddlStoneType.SelectedIndex == 2)
            {
                slabCost = (Decimal)findSlabCost.FirstOrDefault();
            }
            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 2) && (heightT < 3 && ddlStoneType.SelectedIndex == 2))
            {
                slabCost = (Decimal)findSlabCost.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 2)
            {
                slabCost = (Decimal)findSlabCost.ElementAt(2);
            }

            ////determine cost of the slab based on its depth and
            ////stonetype sandstone selected by the user
            if (heightT < 2 && ddlStoneType.SelectedIndex == 3)
            {
                 slabCost = (Decimal) findSlabCost.FirstOrDefault();
            }
            if ((heightT >= 2 && ddlStoneType.SelectedIndex == 3) && (heightT < 3 && ddlStoneType.SelectedIndex == 3))
            {
                slabCost = (Decimal)findSlabCost.ElementAt(1);
            }

            if (heightT > 3 && ddlStoneType.SelectedIndex == 3)
            {
                slabCost = (Decimal)findSlabCost.ElementAt(2);
            }

             return slabCost;

        }

        private decimal CalculateCost(decimal stoneArea)
        {
            return stoneArea * (decimal)7.5;

            

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