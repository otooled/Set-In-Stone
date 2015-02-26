using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;

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
            }

        }
        

        //protected void btnCalculate_Click(object sender, EventArgs e)
        //{
        //    decimal stoneType = Convert.ToDecimal(ddlStoneType.SelectedValue);
        //    decimal stoneSlab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);
        //    //decimal SC = Convert.ToDecimal(DropDownList1.SelectedValue);
        //    //decimal StoneSlab = Convert.ToDecimal(DropDownList2.SelectedValue);
        //    decimal slabW = Convert.ToDecimal(SlabWidth.Value);

        //    //lblCalculateAnswer.Text = ((stoneSlab*stoneType)).ToString();
           
        //    //txtPryHeight.Text = SlabWidth.Value;
            

        //}

        protected void BtnProvisionalCost_Click(object sender, EventArgs e)
        {
            decimal slabHeight = Convert.ToDecimal(SlabHeight.Value);
            decimal pryamidHeight = Convert.ToDecimal(PryHeight.Value);
            decimal slabWidth = Convert.ToDecimal(SlabWidth.Value);
            lblDisplyHeightTotal.Text = (slabHeight + pryamidHeight).ToString("#0.00");
            lblDisplayTotalWidth.Text = (slabWidth * slabWidth).ToString("#0.00");
            
            lblTotalHeight.Visible = true;
            lblTotalWidth.Visible = true;
            //lblCalculateAnswer.Text = "test";
            DetermineSlab();
            
        }

        private void DetermineSlab()
        {
            if(decimal.Parse(lblDisplyHeightTotal.Text) <2)
            {
                ddlStoneSlab.SelectedIndex = 1;
            }

            else if (decimal.Parse(lblDisplyHeightTotal.Text) >= 2 && decimal.Parse(lblDisplyHeightTotal.Text) < 3)
            {
                ddlStoneSlab.SelectedIndex = 2;
            }

            else 
            {
                ddlStoneSlab.SelectedIndex = 3;
            }

            

        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {

            decimal stoneType = Convert.ToDecimal(ddlStoneType.SelectedValue);
            decimal stoneSlab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);

            lblCalculateAnswer.Text = ((stoneSlab * stoneType)).ToString();
            
            
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
            decimal stone = Convert.ToDecimal(ddlStoneType.SelectedValue);
            decimal slab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);
            lblCalculateAnswer.Text = ((stone * slab)).ToString();
        }

        protected void ddlTest_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlslabtest_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void PopulateStoneMenu()
        {
            var stone = from s in db.Stone_Types select new { s.StoneType, s.CostPerSqMetre };
            ddlStoneType.DataSource = stone.ToList();
            ddlStoneType.DataValueField = "CostPerSqMetre";
            ddlStoneType.DataTextField = "StoneType";
            ddlStoneType.DataBind();
            ddlStoneType.Items.Insert(0, "--Select--");
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
    }
}