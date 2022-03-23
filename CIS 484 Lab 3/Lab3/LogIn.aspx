<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="Lab3.LogIn" %>

<!DOCTYPE html>
<%--Nick Kirbabas 
CIS 484 Lab 3 
This is the log in page--%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kirbabas DukeGroup</title>
</head>
<body>
    <form id="form1" runat="server">
         <asp:Image ID="pageLogo" runat="server" ImageUrl="/images/DukeGroupLogo.png" Width="1159px" Height="289px"/>
            <div style="margin:50px">
         
            </div> 
        <center>
            <asp:Table ID="Table1" runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="lblUserName" runat="server" Text="User Name: "></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="lblPassword" runat="server" Text="Password: "></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtPassword" runat="server"
                            TextMode="Password"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="btnLogin" runat="server" Text="Login ­>"
                            OnClick="btnLogin_Click" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSignUp" runat="server" Text="Sign Up"
                            OnClick="btnSignUp_Click" />
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <asp:Label ID="lblIncorrectLogin" runat="server" Text=""
                            ForeColor="Red" Font-Bold="true"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </center>
    </form>
</body>
</html>
