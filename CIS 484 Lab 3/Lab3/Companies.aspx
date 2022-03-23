<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="Companies.aspx.cs" Inherits="Lab3.Companies" %>
<%--Nick Kirbabas
CIS 484 Lab 3
This page allows a member to create a company--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: 300px">

        <asp:Label ID="lblCompanyName" runat="server" Text="Company Name"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtCompanyName" Text="Please Enter Data" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_CName"
            ControlToValidate="txtCompanyName"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%--The above validator requires the textbox to be filled in order for any of the other functions to work--%>
        <br />
        <br />
        <asp:Label ID="lblCompanyEmail" runat="server" Text="Company Email"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtCompanyEmail" Text="Please Enter Data" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_CEmail"
            ControlToValidate="txtCompanyEmail"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%-- Another validator for the company email which is used in the code behind to prevent duplicates--%>
        <br />
        <br />
        <asp:Label ID="lblState" runat="server" Text="Company State"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtState" Text="Please Enter Data" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblCity" runat="server" Text="Company City"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtCity" Text="Please Enter Data" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblStreet" runat="server" Text="Company Street"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtStreet" Text="Please Enter Data" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblZip" runat="server" Text="Company's Zip Code"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtZip" Text="Please Enter Data" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
        <br />
    </div>
    <center>
        <asp:Button ID="btnCommit" runat="server" Text="Commit" OnClick="btnCommit_Click" UseSubmitBehavior="false"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" UseSubmitBehavior="false" />
    </center>
    <br /><br />

    <asp:GridView ID="grdvCompanies"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcCompany"
        AllowPaging="True" Width="1048px" DataKeyNames="CompanyID" BackColor="LightGoldenrodYellow" BorderColor="Tan" 
        BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnRowCommand="grdvCompanies_RowCommand">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField HeaderText="CompanyID" DataField="CompanyID" SortExpression="CompanyID" ReadOnly="True" Visible="false" InsertVisible="False" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" 
                        CommandName="CompanyID" CommandArgument='<%# Eval("CompanyID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" />
            <asp:BoundField HeaderText="CompanyEmail" DataField="CompanyEmail" SortExpression="CompanyEmail" />
            <asp:BoundField HeaderText="CompanyState" DataField="CompanyState" SortExpression="CompanyState" />
            <asp:BoundField HeaderText="CompanyCity" DataField="CompanyCity" SortExpression="CompanyCity" />
            <asp:BoundField HeaderText="CompanyStreet" DataField="CompanyStreet" SortExpression="CompanyStreet" />
            <asp:BoundField HeaderText="CompanyZip" DataField="CompanyZip" SortExpression="CompanyZip" />

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

    <asp:SqlDataSource ID="sqlsrcCompany"
        runat="server"
        ConnectionString='<%$ ConnectionStrings:Lab3 %>' ProviderName="System.Data.SqlClient"
        SelectCommand="SELECT CompanyID, CompanyName, CompanyEmail, CompanyState, CompanyCity, CompanyStreet, CompanyZip FROM Company">      
    </asp:SqlDataSource>

    <br /><br />
    <center>
    
    <asp:Label ID="Label1" runat="server" Text="Company Name" Visible="false"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TextBox1" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator1"
            ControlToValidate="txtCompanyName"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%--The above validator requires the textbox to be filled in order for any of the other functions to work--%>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Company Email" Visible="false"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TextBox2" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator2"
            ControlToValidate="txtCompanyEmail"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%-- Another validator for the company email which is used in the code behind to prevent duplicates--%>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Company State" Visible="false"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TextBox3" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Company City" Visible="false"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TextBox4" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Company Street" Visible="false"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox5" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Company's Zip Code" Visible="false"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox6" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Button ID="btnUpdate" runat="server" Text="Update Company Information" Visible="false" OnClick="btnUpdate_Click"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnClearEdit" runat="server" Text="Undo Changes" Visible="false" OnClick="btnClearEdit_Click" />

        </center>
</asp:Content>
