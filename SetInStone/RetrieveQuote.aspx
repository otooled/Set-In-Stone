<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RetrieveQuote.aspx.cs" Inherits="SetInStone.RetrieveQuote" %>
<%@ Import Namespace="System.Web.Optimization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%: Styles.Render("~/Content/bootstrap.css", "~/Content/RetrieveQuote.css") %> 
    <%: Scripts.Render("~/bundles/jQuery") %>
    <title>Set In Stone</title>
</head>
<body>
    <form id="form1" runat="server">
        <br/>
    <br/>
        <div id="divTitle">
        <label>Set In Stone</label>
    </div>
    <div id="divRetrieve">
    
<%--        <asp:Label ID="lblQuoteRef" runat="server" Text="Quote Ref" CssClass="Labels"></asp:Label>--%>
        <asp:TextBox ID="txtQuoteRef" runat="server" CssClass="TextBoxes"
            placeholder="Quote Ref"></asp:TextBox>

    
        <br />
        <asp:Label ID="lblFirstName" runat="server" CssClass="Labels" Text="First Name"></asp:Label>

        <br />
        <asp:Label ID="lblSurname" runat="server" CssClass="Labels" placeholder="Surame"></asp:Label>
        <br />
        <asp:Label ID="lblAddress" runat="server" CssClass="Labels" placeholder="Address"></asp:Label>
        <br />
        <asp:Label ID="lblPhoneNo" runat="server" CssClass="Labels" placeholder="Phone Number"></asp:Label>
        <br />
        <asp:Label ID="lblProduct" runat="server" CssClass="Labels" placeholder="Product"></asp:Label>
        <br />
        <asp:Label ID="lblStone" runat="server" CssClass="Labels" placeholder="Stone"></asp:Label>
        <br />
        <asp:Label ID="lblPrice" runat="server" CssClass="Labels" placeholder="Price"></asp:Label>
        

        <br />
        <asp:Button ID="btnRetrieveQuote" runat="server" Text="Retrieve Quote" 
            OnClick="btnRetrieveQuote_Click" CssClass="btn btn-info" />
        <br />
        <br />
        <asp:Button ID="btnEditQuote" runat="server" Text="Edit Quote" CssClass="btn btn-danger" OnClick="btnEditQuote_Click"/>
        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-success"/>
        <br />
    </div>
    </form>
</body>
</html>
