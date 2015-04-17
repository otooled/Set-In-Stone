<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SetInStone.Login" %>
<%@ Import Namespace="System.Web.Optimization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%: Styles.Render("~/Content/bootstrap.css", "~/Content/Login.css") %> 
    <%: Scripts.Render("~/bundles/jQuery") %>
    <title>Set In Stone</title>
</head>
<body>
    <br/>
    <br/>
       
    <div id="divTitle">
        <label>Set In Stone</label>
    </div>
    <form id="Login" runat="server">
        
        
    <div id="LoginDiv">
    
        <asp:TextBox runat="server" placeholder="Staff ID" ID="txtStaffID" CssClass="TextBoxes"></asp:TextBox>
        <br/>
        <label  class="bars"> </label>
        <br/>
        <asp:TextBox runat="server" placeholder="Password" ID="txtPassword" CssClass="TextBoxes" TextMode="Password"></asp:TextBox>
        <br/>
        <label  class="bars"> </label>
        <br/>
        <asp:Button runat="server" ID="btnLogin" Text="Login" CssClass="LoginButtons" OnClick="btnLogin_Click"/>
        
        <br/>
    <br/>
        <br/>
    <br/>
        <asp:Button runat="server" ID="btnRetrieveQuote" Text="Retrieve a Quote" CssClass="LoginButtons"/>
    </div>
        <div id="divNewEmployee">
            <asp:Button runat="server" ID="btnNewEmployee" Text="Other Options" CssClass="LoginButtons"/>
        </div>
    </form>
</body>
</html>
