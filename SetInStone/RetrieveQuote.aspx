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
        <asp:Label ID="lblFirstName" runat="server" CssClass="Labels"></asp:Label>
        <asp:Label ID="lblDisplayFName" runat="server" ></asp:Label>

        <br />
        <asp:Button ID="btnRetrieveQuote" runat="server" Text="Retrieve Quote" 
            OnClick="btnRetrieveQuote_Click" CssClass="btn btn-info" />
        <br />
        <asp:Button ID="btnEditQuote" runat="server" Text="Edit Quote" CssClass="btn btn-danger"/>
        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-success"/>
        <br />
    </div>
    </form>
</body>
</html>
