<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Quote.aspx.cs" Inherits="SetInStone.Quote1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <asp:Label ID="lblQuote" runat="server" Text="Quote"></asp:Label>
        <asp:TextBox ID="txtQuote" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblName" runat="server" Text="First Name"></asp:Label>
        <asp:TextBox ID="txtFirstName" runat="server" ></asp:TextBox>
        <br />
         <br />
        <asp:Label ID="lblSurname" runat="server" Text="Surname"></asp:Label>
        <asp:TextBox ID="txtSurname" runat="server" ></asp:TextBox>
        <br />
         <br />
        <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
        <asp:TextBox ID="txtAddress" runat="server" ></asp:TextBox>
        <br />
         <br />
        <asp:Label ID="lblPhone" runat="server" Text="Phone No."></asp:Label>
        <asp:TextBox ID="txtPhoneNo" runat="server" ></asp:TextBox>
        <br />
         <br />
        <%--<asp:Label ID="lblEmail" runat="server" Text="Email Address"></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server" ></asp:TextBox>
        <br />--%>
        <asp:Button ID="btnSubmit" runat="server" Text="Button" OnClick="btnSubmit_Click" />
    </form>
</body>
</html>
