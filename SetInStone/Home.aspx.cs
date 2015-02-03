using System;
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

        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
           //txtResult.Text = 
        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            int SH = Convert.ToInt32(txtStoneHeight.Text);
            int SW = Convert.ToInt32(txtStoneWidth.Text);
            decimal SC = Convert.ToDecimal(DropDownList1.SelectedValue);
            lblAnswer.Text = (SH + SW + SC).ToString();

            //lblAnswer.Text = (Convert.ToInt32(txtStoneHeight.Text)
            // + Convert.ToInt32(txtStoneWidth.Text) );
        }

        
    }
}