<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="SetInStone.LandingPage" %>
<%@ Import Namespace="System.Web.Optimization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%: Styles.Render("~/Content/bootstrap.css", "~/Content/LandingPage/css/grayscale.css", "~/Content/LandingPage.css") %> 
    <%: Scripts.Render("~/bundles/jQuery") %>
    <title>Set In Stone</title>
</head>
<body>
    <br/>
    <br/>
    <div id="divTitle">
        <label>Set In Stone</label>
    </div>
    <form id="form1" runat="server">
        <div id="createControlsDiv" class="controlsDiv">
               <asp:DropDownList ID="ddlProductType" runat="server"   data-toggle="dropdown" OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged1"
                   AutoPostBack="True"/>
            
<%--            <asp:Button runat="server" ID="btnCreateQuote" CssClass="LoginButtons" Text="Create Quote" OnClick="btnCreateQuote_Click" />--%>
        </div>
        <div id="retrieveControlsDiv">
            <asp:Button runat="server" ID="btnRetrieveQuote" CssClass="LoginButtons" Text="Retrieve Quote" OnClick="btnRetrieveQuote_Click" />
        </div>
        <div id="otherDiv">
            <asp:Button runat="server" ID="btnOther" CssClass="LoginButtons" Text="Other" />
        </div>
    
    </form>
</body>
</html>
