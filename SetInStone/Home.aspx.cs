﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetInStone
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
            //txtPryHeight.Text = SlabW.ToString();

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
            lblDisplyHTotal.Text = (slabHeight + pryamidHeight).ToString("#0.00");

            lblTotalHeight.Visible = true;
            //lblCalculateAnswer.Text = "test";
            DetermineSlab();
            
        }

        private void DetermineSlab()
        {
            //if (decimal.Parse(lblDisplyHTotal.Text) > 2)
            //{
            //    lblAnswer.Text = "ello";
            //}
        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            

            decimal stoneType = Convert.ToDecimal(ddlStoneType.SelectedValue);
            decimal stoneSlab = Convert.ToDecimal(ddlStoneSlab.SelectedValue);
            //decimal SC = Convert.ToDecimal(DropDownList1.SelectedValue);
            //decimal StoneSlab = Convert.ToDecimal(DropDownList2.SelectedValue);

            lblCalculateAnswer.Text = ((stoneSlab*stoneType)).ToString();
            
            //txtPryHeight.Text = SlabWidth.Value;
        }

        

        

        
    }
}