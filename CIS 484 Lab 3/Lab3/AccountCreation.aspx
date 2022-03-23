<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountCreation.aspx.cs" Inherits="Lab3.AccountCreation" %>

<!DOCTYPE html>
<%--Nick Kirbabas
CIS 484 Lab 3 
This page is where a new user will apply for an account--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Image ID="pageLogo" runat="server" ImageUrl="/images/DukeGroupLogo.png" Width="1159px" Height="289px" />
        <div>
            <div style="margin-left: 300px">
                <br />
                <asp:Label ID="lblUserType" runat="server" Text="Account Type:"></asp:Label>

                <br />

                <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="Student" Value="Student" />
                    <asp:ListItem Text="Member" Value="Member" />
                </asp:RadioButtonList>

                <br />
                <asp:Label ID="lblUserName" runat="server" Text="User Name"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtUserName" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RFV_UserName"
                    ControlToValidate="txtUserName"
                    Text="(Required)" ForeColor="#ff0000"
                    runat="server">
                </asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtPassword" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RFV_Password"
                    ControlToValidate="txtPassword"
                    Text="(Required)" ForeColor="#ff0000"
                    runat="server">
                </asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="lblFName" runat="server" Text="First Name"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtFName" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RFV_FName"
                    ControlToValidate="txtFName"
                    Text="(Required)" ForeColor="#ff0000"
                    runat="server">
                </asp:RequiredFieldValidator>
                <%--Requires that a first name be entered--%>
                <br />
                <br />
                <asp:Label ID="lblLName" runat="server" Text="Last Name"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtLName" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RFV_LName"
                    ControlToValidate="txtLName"
                    Text="(Required)" ForeColor="#ff0000"
                    runat="server">
                </asp:RequiredFieldValidator>
                <%--This validator makes sure a last name is entered--%>
                <br />
                <br />
                <asp:Label ID="lblEmail" runat="server" Text="Email Address"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtEmail" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="RFV_Email"
                    ControlToValidate="txtEmail"
                    Text="(Required)" ForeColor="#ff0000"
                    runat="server">
                </asp:RequiredFieldValidator>
                <%--This required validator requires an email be entered--%>
                <br />
                <br />
                <asp:Label ID="lblPhoneNum" runat="server" Text="Phone Number"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtPhoneNum" runat="server" Text="0000000000" Width="200px" Height="20px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegExpValPhone" runat="server"
                    ControlToValidate="txtPhoneNum" ErrorMessage="Invalid Phone Number (No dashes)" ForeColor="#ff0000"
                    ValidationExpression="[0-9]{10}">
                </asp:RegularExpressionValidator>
                <%--This validator makes sure only numbers are entered into the text box and must be 10 digits--%>
                <br />
                <br />
                <asp:Panel ID="pnlGradDate" runat="server">
                    <asp:Label ID="lblGradDate" runat="server" Text="Expected Graduation Date"></asp:Label>
                    &nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtGradDate" runat="server" Text="01/01/1111" Height="20px" Width="200px"></asp:TextBox>
                    <asp:Label ID="lblFormat" runat="server" Text="(MM/DD/YYYY)"></asp:Label>
                    <asp:CompareValidator ID="CV_GradDate" runat="server" Type="Date"
                        Operator="DataTypeCheck" ControlToValidate="txtGradDate" ErrorMessage="Please enter a valid date.">
                    </asp:CompareValidator>
                </asp:Panel>
                <%--        This validator controls whether or not a date is entered into textbox--%>
                <br />
                <asp:Label ID="lblMajor" runat="server" Text="Major"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtMajor" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
                <br />
                <br />
                <t />
                <asp:Panel ID="pnlEmployStatus" runat="server">
                    <asp:Label ID="lblEmployStatus" runat="server" Text="Employment Status"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="DDEmployList" runat="server" Visible="true" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Employed</asp:ListItem>
            <asp:ListItem>Internship</asp:ListItem>
            <asp:ListItem>Not Employed</asp:ListItem>
        </asp:DropDownList>
                </asp:Panel>
                <br />
                <br />
                <asp:Button ID="btnApply" runat="server" Text="Sign Up" OnClick="btnApply_Click" />
                <br />
                <asp:Label ID="lblUpload" runat="server" Text="" Font-Bold="true"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
