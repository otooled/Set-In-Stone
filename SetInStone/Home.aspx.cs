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
        
        
       // private SetInStoneEntities4  db = new SetInStoneEntities4();
        private SiSSetInStone2Entities2 db = new SiSSetInStone2Entities2();

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
            
            //float custSlabsurfaceArea = CustomerSlabDetails();
            float pyrSurfaceArea = PyrSurface();




            //float custSlabHeight = DetermineSlab();
            //float slabcost = DetermineLStoneSlabCost();


            ////Measurements entered by the user through the slider control
            //decimal slabHeight = Convert.ToDecimal(SlabHeight.Value);
            //decimal pyramidHeight = Convert.ToDecimal(PryHeight.Value);

            //decimal slabWidth = Convert.ToDecimal(SlabWidth.Value);
            //decimal slabLength = Convert.ToDecimal(SlabLength.Value);

            ////Area of the customer slab.  This will be used to determine   *
            ////cut costs for the slab and the pyramid   *
            //decimal customerSlabArea = slabWidth*slabLength;   *

            ////Total height of the customer slab
            //decimal heightTotal = (slabHeight + pyramidHeight);  *

            //decimal heightTotal = CustomerSlabDetails();  *

            ////Depending on the customers measurments, this method will determine   *
            ////which slab in stock is selected   *
            //decimal slabCost = DetermineSlab(heightTotal);   *

            ////Determine the size of the slab in stock for cost purposes
            //decimal stockSlabWidth = DetermineStockSlabWidth(heightTotal);

            //decimal stockSlabHeight = DetermineStockSlabLength(heightTotal);

            //decimal stockSlabArea = stockSlabWidth*stockSlabHeight;

            ////Calculate the cost of the customer slab excluding cut costs
            //decimal customerSlabCost = (customerSlabArea/stockSlabArea)*slabCost;
            
            ////Surface area of sides and underside of slab for cut costs
            ////The underside surface area will be taken from customerSlabArea

            //decimal sideCutCosts = DetermineSideCutCosts();

            ////Surface of slab sides width
            //decimal slabSidesWidth = ((slabHeight*slabWidth)*2) * sideCutCosts;

            ////Surface of slab sides width
            //decimal slabSidesLength = (slabHeight * slabLength) * 2 * sideCutCosts;

            //decimal slabUndersideCut = customerSlabArea*sideCutCosts;

            //decimal totalAreaCuts = slabSidesWidth + slabSidesLength + slabUndersideCut;
            ////Pyramid surface area - formula A = lw+l.√(w2/2)²+h²+w.√(l/2)²+h²

            ////step one of formula (L)(W)+(L)
            //decimal fPart1 = customerSlabArea + slabLength;

            ////step two of formula (w/2)²+h²+w - not getting the square root yet
            //decimal fPart2 = (slabWidth / 2) * (slabWidth / 2) + (pyramidHeight * pyramidHeight) + slabWidth;

            ////step three of formula (l/2)²+h² - not getting the square root yet

            //decimal fPart3 = (slabLength/2)*(slabLength/2) + (pyramidHeight*pyramidHeight);

            ////step four of formula - get square root of part 2 and part 3

            //decimal sqrtOfPart2 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart2));
            //decimal sqrtOfPart3 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart3));
            
            //decimal surfaceAreaOfPyramid = fPart1*sqrtOfPart2*sqrtOfPart3;

            ////method to calculate the cost of the cut, sending the surface of the area to 
            ////the CalculatePyrimidAreaCutCost method
            //decimal costOfPyrCut = DeterminePyramidCutCost(surfaceAreaOfPyramid);

            ////Total cost of stonework.  All charges included
            //decimal finalCost = customerSlabCost + totalAreaCuts + costOfPyrCut;
            

            ////Display final cost of stone work
            lblCalculateAnswer.Text = pyrSurfaceArea.ToString();//"c2"

        }

        private float PyrSurface()
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
            float totalCustGranCost = 0;
            float totalCustLimeCost = 0;
            float totalCustSandCost = 0;

            //Measurements entered by the user through the slider control
            string sType = ddlStoneType.SelectedValue;
            float slabWidth = float.Parse(SlabWidth.Value);
            float slabHeight = float.Parse(SlabHeight.Value);
            //float pyramidHeight = float.Parse(PryHeight.Value);
            
            float slabLength = float.Parse(SlabLength.Value);
            

            //CustomerSlab custSlab = new CustomerSlab(slabHeight, pyramidHeight, slabWidth, slabLength, slabStone);

            
            var price = CalcClasses.Cost.CalcCost(sType, slabWidth, slabHeight, slabLength);

            //Total height of customer slab which includes pyramid
            //float totalCustSlabHeight = custSlab.CalcTotalSlabHeight();
            // float surfaceArea = custSlab.CalcSurfaceArea();
            //Gets the cost of slab, depending on stone type and slab thickness
            //float custGranSlabCost = DetermineGraniteSlabCost(totalCustSlabHeight);
            //float custLimeSlabCost = DetermineLStoneSlabCost(totalCustSlabHeight);
            //float custSndSlabCost = DetermineSStoneSlabCost(totalCustSlabHeight);

            //if (custSlab.stoneType == "Granite")
            //{
            //    totalCustGranCost = custGranSlabCost*surfaceArea;
            //}

            //else if (custSlab.stoneType == "Limestone")
            //{
            //    totalCustLimeCost = custLimeSlabCost*surfaceArea;
            //}

            //else
            //{
            //    totalCustSandCost = custSndSlabCost*surfaceArea;
            //}

            //float sidesSurfaceArea = custSlab.CalcSlabSideArea();

            ////Area of the customer slab.  This will be used to determine
            ////cut costs for the slab and the pyramid
            ////decimal customerSlabArea = custSlab.sWidth*custSlab.sLength;// slabWidth* slabLength;

            return price;
        }


        private float DetermineGraniteSlabCost(float heightTotal)
        {
            //determine cost of the slab based on its depth and
            //granite is selected by the user
            float granSlabCost = 0;

            var findSlabCost =
                (from sc in db.Slabs
                 where sc.StoneId == 1

                 select sc.Cost).ToList();

            if (heightTotal < 2)
            {
                granSlabCost = (float)findSlabCost.FirstOrDefault();
            }

            else if (heightTotal >= 2 && heightTotal < 3)
            {
                granSlabCost = (float)findSlabCost.ElementAt(1);
            }

            else
            {
                granSlabCost = (float)findSlabCost.ElementAt(2);
            }

            return granSlabCost;
        }

        private float DetermineLStoneSlabCost(float heightTotal)
        {
            //determine cost of the slab based on its depth and
            //stonetype limestone is selected by the user
            float lStoneSlabCost = 0;

            var findSlabCost =
                (from sc in db.Slabs
                 where sc.StoneId == 2

                 select sc.Cost).ToList();

            if (heightTotal < 2)
            {
                lStoneSlabCost = (float)findSlabCost.FirstOrDefault();
            }

            else if (heightTotal >= 2 && heightTotal < 3)
            {
                lStoneSlabCost = (float)findSlabCost.ElementAt(1);
            }

            else
            {
                lStoneSlabCost = (float)findSlabCost.ElementAt(2);
            }

            return lStoneSlabCost;
        }

        private float DetermineSStoneSlabCost(float heightTotal)
        {
            //determine cost of the slab based on its depth and
            //stonetype sandstone is selected by the user
            float sndStoneSlabCost = 0;

            var findSlabCost =
                (from sc in db.Slabs
                 where sc.StoneId == 2

                 select sc.Cost).ToList();

            if (heightTotal < 2)
            {
                sndStoneSlabCost = (float)findSlabCost.FirstOrDefault();
            }

            else if (heightTotal >= 2 && heightTotal < 3)
            {
                sndStoneSlabCost = (float)findSlabCost.ElementAt(1);
            }

            else
            {
                sndStoneSlabCost = (float)findSlabCost.ElementAt(2);
            }

            return sndStoneSlabCost;
        }


        
        //Determines the slab height based on the slab deminsions
        //private float DetermineSlab(float heightTotal)
        //{
        //    //determine cost of the slab based on its depth and
        //    //stonetype granite is selected by the user
        //    float slabCost = 0;

        //    var findSlabCost =
        //        (from sc in db.Slabs
        //         where sc.StoneId == ddlStoneType.SelectedIndex  

        //         select sc.Cost).ToList();

        //    if (heightTotal < 2 && ddlStoneType.SelectedIndex == 1)
        //    {
        //        slabCost = (float)findSlabCost.FirstOrDefault();
        //    }

        //    if ((heightTotal >= 2 && ddlStoneType.SelectedIndex == 1) && (heightTotal < 3 && ddlStoneType.SelectedIndex == 1))
        //    {
        //        slabCost = (float)findSlabCost.ElementAt(1);
        //    }

        //    if (heightTotal > 3 && ddlStoneType.SelectedIndex == 1)
        //    {
        //        slabCost = (float)findSlabCost.ElementAt(2);
        //    }

        //    ////determine cost of the slab based on its depth and
        //    ////stonetype limestone selected by the user
        //    if (heightTotal < 2 && ddlStoneType.SelectedIndex == 2)
        //    {
        //        slabCost = (float)findSlabCost.FirstOrDefault();
        //    }
        //    if ((heightTotal >= 2 && ddlStoneType.SelectedIndex == 2) && (heightTotal < 3 && ddlStoneType.SelectedIndex == 2))
        //    {
        //        slabCost = (float)findSlabCost.ElementAt(1);
        //    }

        //    if (heightTotal > 3 && ddlStoneType.SelectedIndex == 2)
        //    {
        //        slabCost = (float)findSlabCost.ElementAt(2);
        //    }

        //    ////determine cost of the slab based on its depth and
        //    ////stonetype sandstone selected by the user
        //    if (heightTotal < 2 && ddlStoneType.SelectedIndex == 3)
        //    {
        //        slabCost = (float)findSlabCost.FirstOrDefault();
        //    }
        //    if ((heightTotal >= 2 && ddlStoneType.SelectedIndex == 3) && (heightTotal < 3 && ddlStoneType.SelectedIndex == 3))
        //    {
        //        slabCost = (float)findSlabCost.ElementAt(1);
        //    }

        //    if (heightTotal > 3 && ddlStoneType.SelectedIndex == 3)
        //    {
        //        slabCost = (float)findSlabCost.ElementAt(2);
        //    }

        //    return slabCost;

        //}

        //private decimal DetermineSideCutCosts()
        //{
        //    decimal sideCuts = 0;

        //    var sideCalcCost =
        //        (from scc in db.Slabs
        //         where scc.StoneId == ddlStoneType.SelectedIndex
        //         select scc.CutCostPerSqMtr).ToList();

        //    if (ddlStoneType.SelectedIndex == 1)
        //    {
        //        sideCuts = (Decimal)sideCalcCost.FirstOrDefault();
        //    }

        //    else if (ddlStoneType.SelectedIndex == 2)
        //    {
        //        sideCuts = (Decimal)sideCalcCost.ElementAt(1);
        //    }

        //    else if (ddlStoneType.SelectedIndex == 3)
        //    {
        //        sideCuts = (Decimal)sideCalcCost.ElementAt(2);
        //    }

        //    return sideCuts ;
        //}

        //private decimal DeterminePyramidCutCost(decimal pyrArea)
        //{
        //    decimal pyrCutCost = 0;

        //    var cutCalcCost =
        //        (from cc in db.Slabs

        //         where cc.StoneId == ddlStoneType.SelectedIndex
        //         select cc.CutCostPerSqMtr).ToList();
            

        //    if (ddlStoneType.SelectedIndex == 1)
        //    {
        //        pyrCutCost = (Decimal)cutCalcCost.FirstOrDefault();
        //    }

        //    else if (ddlStoneType.SelectedIndex == 2)
        //    {
        //        pyrCutCost = (Decimal)cutCalcCost.ElementAt(1);
        //    }

        //    else if (ddlStoneType.SelectedIndex == 3)
        //    {
        //        pyrCutCost = (Decimal)cutCalcCost.ElementAt(2);
        //    }

        //    return pyrCutCost * pyrArea;
        //}

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