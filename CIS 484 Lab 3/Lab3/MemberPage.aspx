<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="MemberPage.aspx.cs" Inherits="Lab3.MemberPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--Nick Kirbabas 
    CIS 484 Lab 3 
    This page displays all the members and can be edited--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
    <br />
    <br />
    <asp:GridView ID="grdvMember"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcMember"
        AllowPaging="True" Width="1048px" DataKeyNames="MemberID" BackColor="LightGoldenrodYellow" BorderColor="Tan" 
        BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnRowCommand="grdvMember_RowCommand">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField DataField="MemberID" HeaderText="MemberID" InsertVisible="False" ReadOnly="True" Visible="false" SortExpression="MemberID" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click"
                        CommandName="MemberID" CommandArgument='<%# Eval("MemberID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MUsername" HeaderText="MUsername" SortExpression="MUsername" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber" />
            <asp:BoundField DataField="GradDate" HeaderText="GradDate" SortExpression="GradDate" />
            <asp:BoundField DataField="Major" HeaderText="Major" SortExpression="Major" />
            <asp:BoundField DataField="StudentName" HeaderText="StudentName" ReadOnly="True" SortExpression="StudentName" />
        </Columns>
        <FooterStyle BackColor="Tan" />
        <HeaderStyle BackColor="Tan" Font-Bold="True" />
        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
        <SortedAscendingCellStyle BackColor="#FAFAE7" />
        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
        <SortedDescendingCellStyle BackColor="#E1DB9C" />
        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
    </asp:GridView>
    <asp:SqlDataSource
        ID="sqlsrcMember"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>" ProviderName="System.Data.SqlClient"
        SelectCommand="sp_displayMembers"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <br />
    <br />
    <center>
        <asp:Panel ID="PnlMember" runat="server" Visible="false">
            <asp:Label ID="lblFName" runat="server" Text="First Name"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtFName" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
            <asp:RequiredFieldValidator
                ID="RequiredFieldValidator3"
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
                ID="RequiredFieldValidator4"
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
                ID="RequiredFieldValidator5"
                ControlToValidate="txtEmail"
                Text="(Required)" ForeColor="#ff0000"
                runat="server">
            </asp:RequiredFieldValidator>
            <%--This required validator requires an email be entered--%>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lblPhoneNum" runat="server" Text="Phone Number"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtPhoneNum" runat="server" Text="0000000000" Width="200px" Height="20px"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                ControlToValidate="txtPhoneNum" ErrorMessage="Invalid Phone Number (No dashes)" ForeColor="#ff0000"
                ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
            <%--This validator makes sure only numbers are entered into the text box and must be 10 digits--%>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lblGradDate" runat="server" Text="Graduation Date"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtGradDate" runat="server" Text="01/01/1111" Height="20px" Width="200px"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblDateReq" runat="server" Text="(MM/DD/YYYY)"></asp:Label>
            <asp:CompareValidator ID="CompareValidator1" runat="server" Type="Date"
                Operator="DataTypeCheck" ControlToValidate="txtGradDate" ErrorMessage="Please enter a valid date.">
            </asp:CompareValidator>
            <%--        This validator controls whether or not a date is entered into textbox--%>
            <br />
            <br />
            <asp:Label ID="lblMajor" runat="server" Text="Degree Major"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
        <asp:TextBox ID="txtMajor" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Update Information" OnClick="btnUpdate_Click" />
        </asp:Panel>
    </center>


</asp:Content>
