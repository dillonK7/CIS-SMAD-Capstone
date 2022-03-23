<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="StudentPage.aspx.cs" Inherits="Lab3.WebForm1" %>

<%--Nick Kirbabas 
CIS 484 Lab 3 
This page is for adding students and editing existing ones--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--search bar for looking for students--%>
    <asp:Label ID="lblSearch" runat="server" Text="Search for a student by first and last name"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    <br /><br />
    <%--Gridview for the search result--%>
    <asp:GridView ID="grdv_Search"
        runat="server"
        AllowPaging="True" Width="1048px" BackColor="LightGoldenrodYellow" BorderColor="Tan"
        BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None"> 
        <FooterStyle BackColor="Tan" />
        <HeaderStyle BackColor="Tan" Font-Bold="True" />
        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
        <SortedAscendingCellStyle BackColor="#FAFAE7" />
        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
        <SortedDescendingCellStyle BackColor="#E1DB9C" />
        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
    </asp:GridView>
    <br /><br /><br />


    <asp:GridView ID="grdvStudent"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcStudent"
        AllowPaging="True" Width="1048px" BackColor="LightGoldenrodYellow" BorderColor="Tan"
        BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnRowCommand="grdvStudent_RowCommand">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField HeaderText="StudentID"
                DataField="StudentID" SortExpression="StudentID" ReadOnly="True" Visible="false" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click"
                        CommandName="StudentID" CommandArgument='<%# Eval("StudentID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="FirstName"
                DataField="FirstName" SortExpression="FirstName" />
            <asp:BoundField HeaderText="LastName"
                DataField="LastName" SortExpression="LastName" />
            <asp:BoundField HeaderText="Email"
                DataField="Email" SortExpression="Email" />
            <asp:BoundField HeaderText="PhoneNumber"
                DataField="PhoneNumber" SortExpression="PhoneNumber" />
            <asp:BoundField HeaderText="GradDate"
                DataField="GradDate" SortExpression="GradDate" />
            <asp:BoundField HeaderText="Major"
                DataField="Major" SortExpression="Major" />
            <asp:BoundField HeaderText="EmployStatus"
                DataField="EmployStatus" SortExpression="EmployStatus" />
            <asp:BoundField HeaderText="Mentor"
                DataField="Mentor" SortExpression="Mentor" ReadOnly="True" />
            <asp:TemplateField HeaderText="Download Here">
                <ItemTemplate>
                    <asp:Button ID="lnkDownload" runat="server" CausesValidation="False"
                        Text='Download' OnClick="showDownloadLink" CommandName="StudentID" CommandArgument='<%# Eval("StudentID") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            

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
    <br />
    <asp:LinkButton ID="lnkDownload" runat="server" CausesValidation="False"
                        Text='Download' OnClick="lnkDownload_Click" Visible="false" />
      

    <asp:SqlDataSource
        ID="sqlsrcStudent"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>"
        SelectCommand="sp_displayStudent"
        ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <center>
        <asp:Panel ID="pnlStudent" runat="server" Visible="false">
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
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblPhoneNum" runat="server" Text="Phone Number"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtPhoneNum" runat="server" Text="0000000000" Width="200px" Height="20px"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegExpValPhone" runat="server"
                ControlToValidate="txtPhoneNum" ErrorMessage="Invalid Phone Number (No dashes)" ForeColor="#ff0000"
                ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
            <%--This validator makes sure only numbers are entered into the text box and must be 10 digits--%>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblGradDate" runat="server" Text="Expected Graduation Date"></asp:Label>
            &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtGradDate" runat="server" Text="01/01/1111" Height="20px" Width="200px"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblFormat" runat="server" Text="(MM/DD/YYYY)"></asp:Label>
            <asp:CompareValidator ID="dateValidator" runat="server" Type="Date"
                Operator="DataTypeCheck" ControlToValidate="txtGradDate" ErrorMessage="Please enter a valid date.">
            </asp:CompareValidator>
            <%--        This validator controls whether or not a date is entered into textbox--%>
            <br />
            <br />
            <asp:Label ID="lblMajor" runat="server" Text="Major"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtMajor" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
            <br />
            <br />
            <t />
            <asp:Label ID="lblEmployStatus" runat="server" Text="Employment Status"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="DDEmployList" runat="server">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Employed</asp:ListItem>
            <asp:ListItem>Internship</asp:ListItem>
            <asp:ListItem>Not Employed</asp:ListItem>
        </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Update Information" OnClick="btnUpdate_Click" />
        </asp:Panel>
    </center>

</asp:Content>
