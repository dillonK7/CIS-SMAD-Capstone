<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="JobCreation.aspx.cs" Inherits="Lab3.JobCreation" %>

<%--Nick Kirbabas 
CIS 484 Lab 3
This page is for creating and editing Jobs --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: 300px">
        <asp:Label ID="lblCompany" runat="server" Text="Company Name: "></asp:Label>
        <asp:DropDownList ID="ddlCompany"
            AutoPostBack="true"
            DataSourceID="SqlDataCompany"
            DataTextField="CompanyName"
            DataValueField="CompanyID"
            runat="server" Height="21px" Width="190px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataCompany" runat="server"
            ConnectionString="<%$ConnectionStrings:Lab3 %>"
            SelectCommand="SELECT CompanyName, CompanyID FROM Company"></asp:SqlDataSource>

        <br />
        <br />
        <asp:Label ID="lblPosition" runat="server" Text="Job Title: "></asp:Label>
        <br />
        <asp:TextBox ID="txtDescription" Wrap="true" Text="Please Enter Data" runat="server" Height="27px" Width="357px"></asp:TextBox>
        <br />
        <br />

        <asp:Label ID="lblStartDate" runat="server" Text="Starting Date: "></asp:Label>
        <asp:TextBox ID="txtStartDate" Text="01/01/2000" runat="server"></asp:TextBox>
        <asp:CompareValidator ID="CV_StartDate" runat="server"
            ControlToCompare="txtStartDate" CultureInvariantValues="true"
            Display="Dynamic" EnableClientScript="true"
            ControlToValidate="txtEndDate"
            ErrorMessage="Start date must be earlier than finish date" ForeColor="Red"
            Type="Date" SetFocusOnError="true" Operator="GreaterThanEqual"
            Text="Start date must be earlier than finish date"></asp:CompareValidator>
        <%--This validator makes sure the start date is before the end date--%>
        <br />
        <br />
        <asp:Label ID="lblEndDate" runat="server" Text="Ending Date: "></asp:Label>
        <asp:TextBox ID="txtEndDate" Text="01/02/2000" runat="server"></asp:TextBox>

        <br />
        <br />
    </div>

    <center>
        <asp:Button ID="btnAssign" runat="server" Text="Assign" OnClick="btnAssign_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
        <br />
    </center>

    <asp:GridView ID="grdvJobCreation"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcJob"
        AllowPaging="True" Width="1048px" DataKeyNames="JobID" BackColor="LightGoldenrodYellow" BorderColor="Tan"
        BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnRowCommand="grdvJobCreation_RowCommand">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField HeaderText="JobID" DataField="JobID" SortExpression="JobID" ReadOnly="True" Visible="false" InsertVisible="False" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click"
                        CommandName="JobID" CommandArgument='<%# Eval("JobID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="JobPosition" DataField="JobPosition" SortExpression="JobPosition" />
            <asp:BoundField HeaderText="StartDate" DataField="StartDate" SortExpression="StartDate" />
            <asp:BoundField HeaderText="EndDate" DataField="EndDate" SortExpression="EndDate" />
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
    <asp:SqlDataSource ID="sqlsrcJob"
        runat="server"
        ConnectionString='<%$ ConnectionStrings:Lab3 %>' ProviderName="System.Data.SqlClient"
        SelectCommand="SELECT JobID, JobPosition, StartDate, EndDate, CompanyStreet, CompanyZip FROM Job LEFT JOIN Company ON Job.CompanyID = Company.CompanyID">      
    </asp:SqlDataSource>

    <center>
        <asp:Panel ID="pnlJob" runat="server" Visible="false">
        <asp:Label ID="lblJobTitle" runat="server" Text="Job Title: "></asp:Label>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:TextBox ID="txtJobTitle" Wrap="true" Text="Please Enter Data" runat="server" Height="27px" Width="357px"></asp:TextBox>
        <br />
        <br />

        <asp:Label ID="lblStartDate2" runat="server" Text="Starting Date: "></asp:Label>
        &nbsp;&nbsp;
        <asp:TextBox ID="txtStartDate2" Text="01/01/2000" runat="server" Width="109px"></asp:TextBox>
        <asp:CompareValidator ID="CV_Date" runat="server"
            ControlToCompare="txtStartDate2" CultureInvariantValues="true"
            Display="Dynamic" EnableClientScript="true"
            ControlToValidate="txtEndDate2"
            ErrorMessage="Start date must be earlier than finish date" ForeColor="Red"
            Type="Date" SetFocusOnError="true" Operator="GreaterThanEqual"
            Text="Start date must be earlier than finish date"></asp:CompareValidator>
        <%--This validator makes sure the start date is before the end date--%>
        <br />
        <br />
        <asp:Label ID="lblEndDate2" runat="server" Text="Ending Date: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtEndDate2" Text="01/02/2000" runat="server" Width="109px"></asp:TextBox>
        <br /><br />
        <asp:Button ID="btnUpdate" runat="server" Text="Update Information" OnClick="btnUpdate_Click" />
        </asp:Panel>
    </center>

</asp:Content>
