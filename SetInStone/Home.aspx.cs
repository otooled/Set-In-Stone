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
        
        private SetInStoneEntities db = new SetInStoneEntities();

        protected void Dispose(bool disposing)
        {
            db.Dispose();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                
                PopulateStoneMenu();
                PopulateSlabMenu();
                PopulateProductMenu();
                if (ddlStoneType.SelectedIndex == 0)
                {
                    btnCalculate.Enabled = false;
                    btnCalculate.ToolTip = "Please choose a Product & Stone Type";
                }
                
            }

        }

        protected void BtnProvisionalCost_Click(object sender, EventArgs e)
        {
            //decimal slabHeight = Convert.ToDecimal(SlabHeight.Value);
            //decimal pryamidHeight = Convert.ToDecimal(PryHeight.Value);
            //decimal slabWidth = Convert.ToDecimal(SlabWidth.Value);
            //lblDisplyHeightTotal.Text = (slabHeight + pryamidHeight).ToString("#0.00");
            //lblDisplayTotalWidth.Text = (slabWidth * slabWidth).ToString("#0.00");

            //lblTotalHeight.Visible = true;
            //lblTotalWidth.Visible = true;
            //lblCalculateAnswer.Text = "test";
            //DetermineSlab();
            
        }

        

        protected void btnCalculate_Click(object sender, EventArgs e)
        {

            //decimal stoneType = Convert.ToDecimal(ddlStoneType.SelectedValue);
            //decimal stoneSlab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);

            //lblCalculateAnswer.Text = ((stoneSlab * stoneType)).ToString();

            CalculateDeminsions();

            DetermineSlab(ddlStoneSlab.SelectedIndex);

            CalculateStoneSlabCost();

            CalculateTotal(Convert.ToDecimal(lblTotalCost.Text));
            //lblTotalCost.Text = "hello";
        }

        private void CalculateDeminsions()
        {
            decimal slabHeight = Convert.ToDecimal(SlabHeight.Value);
            decimal pryamidHeight = Convert.ToDecimal(PryHeight.Value);
            decimal slabWidth = Convert.ToDecimal(SlabWidth.Value);

            decimal heightTotal = (slabHeight + pryamidHeight);
            decimal widthTotal = (slabWidth*slabWidth);

            decimal totalSlabDeminsions = heightTotal + widthTotal;

            DetermineSlab(heightTotal);
            
            //CalculateTotal(heightTotal);

            lblDisplyHeightTotal.Text = heightTotal.ToString("#0.00");
            lblDisplayTotalWidth.Text = widthTotal.ToString("#0.00");

            //lblDisplyHeightTotal.Text = (slabHeight + pryamidHeight).ToString("#0.00");
            //lblDisplayTotalWidth.Text = (slabWidth * slabWidth).ToString("#0.00");
            
            lblTotalHeight.Visible = true;
            lblTotalWidth.Visible = true;
           
        }

        private void DetermineSlab(decimal height)
        {
            if (height < 2)
            //if(decimal.Parse(lblDisplyHeightTotal.Text)<2)
            {
                ddlStoneSlab.SelectedIndex = 1;
            }
            else if (height >= 2 && height < 3)
           // else if (decimal.Parse(lblDisplyHeightTotal.Text) >= 2 && decimal.Parse(lblDisplyHeightTotal.Text) < 3)
            {
                ddlStoneSlab.SelectedIndex = 2;
            }

            else
            {
                ddlStoneSlab.SelectedIndex = 3;
            }
           
        }

        private void CalculateStoneSlabCost()
        {
            decimal stoneType = Convert.ToDecimal(ddlStoneType.SelectedValue);
            decimal stoneSlab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);

            decimal provionalSlabCost = (stoneSlab*stoneType);

            CalculateTotal(provionalSlabCost);
            lblCalculateAnswer.Text = provionalSlabCost.ToString();
        }

        private void CalculateTotal(decimal psc)
        {
            decimal slabCost, slabHeight;
            slabCost = psc;
            //slabCost = Convert.ToDecimal(lblCalculateAnswer.Text);
           // slabHeight = totalHet;
            slabHeight = Convert.ToDecimal(lblDisplyHeightTotal.Text);

            decimal totalCost = (slabCost+slabHeight);
            lblTotalCost.Text = totalCost.ToString();
           // lblTotalCost.Text = (slabCost * slabHeight).ToString();
        }






        protected void btnTotalCost_Click(object sender, EventArgs e)
        {
            decimal slabCost, slabHeight;
            slabCost = Convert.ToDecimal(lblCalculateAnswer.Text);
            slabHeight = Convert.ToDecimal(lblDisplyHeightTotal.Text);
            lblTotalCost.Text = (slabCost * slabHeight).ToString();
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            //decimal stone = Convert.ToDecimal(ddlStoneType.SelectedValue);
            //decimal slab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);
            //lblCalculateAnswer.Text = ((stone * slab)).ToString();
        }

       

        private void PopulateStoneMenu()
        {
            var stone = from s in db.Stone_Types select new { s.StoneType, s.CostPerSqMetre };
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
            var p = from pdt in db.Products select new {pdt.ProductName};
            ddlProductType.DataSource = p.ToList();
            ddlProductType.DataValueField = "ProductName";
            ddlProductType.DataTextField = "ProductName";
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