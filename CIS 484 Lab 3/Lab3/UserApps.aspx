<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="UserApps.aspx.cs" Inherits="Lab3.UserApps" %>

<%--Nick Kirbabas 
CIS 484 Lab 3
This page is for adding students and editing existing ones--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblAppNames" runat="server" Text="Pending Applications: "></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlNames"
            AutoPostBack="true"
            DataSourceID="SqlDataSrcUser"
            DataTextField="PendingUser" 
            DataValueField="UserAppID"
            runat="server" Width="165px">
        </asp:DropDownList>
    <%--    This dropdown list is connected to sql database showing all current scholarships available--%>
    <asp:SqlDataSource ID="SqlDataSrcUser" runat="server"
        ConnectionString="<%$ConnectionStrings:Lab3 %>"
        SelectCommand="select UserType + ': ' + FirstName + ' ' + LastName As PendingUser, UserAppID from AccountApp WHERE AppStatus is null"></asp:SqlDataSource>


    <asp:GridView ID="grdvApps"
        runat="server"
        AutoGenerateColumns="False"
        
        AllowSorting="True"
        DataSourceID="sqlsrcApps"
        AllowPaging="True" Width="1048px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" DataKeyNames="UserAppID">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField HeaderText="UserAppID"
                DataField="UserAppID" SortExpression="UserAppID" InsertVisible="False" ReadOnly="True" Visible="false" />
            <asp:BoundField HeaderText="UserType"
                DataField="UserType" SortExpression="UserType" />
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
            <asp:BoundField DataField="EmployStatus" HeaderText="EmployStatus" SortExpression="EmployStatus" />
            <asp:BoundField DataField="AppStatus" HeaderText="AppStatus" SortExpression="AppStatus" />
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
        ID="sqlsrcApps"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>"
        SelectCommand="sp_showApps"
        ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure">
        <SelectParameters>
        <asp:ControlParameter ControlID="ddlNames" 
                DefaultValue="ddlNames.SelectedValue.ToString()" 
                Name="UserAppID" 
                PropertyName="SelectedValue" 
                Type="String" />
        </SelectParameters>  
    </asp:SqlDataSource>
    <center>
        <asp:Button ID="btnCommit" runat="server" Text="Create Approved Accounts" OnClick="btnCommit_Click" />
    </center>
</asp:Content>
