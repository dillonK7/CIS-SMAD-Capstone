<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="CareerApply.aspx.cs" Inherits="Lab3.InternApply" %>
<%--Nick Kirbabas 
CIS 484 Lab 3
This page allows a student to apply for a job or internship depending on company--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: 300px">
        <asp:Label ID="lblCompany" runat="server" Text="Company: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlCompanies" 
        AutoPostBack="true"
        DataSourceID="SqlDataSrcCompany"
        DataTextField="CompanyName"
        DataValueField="CompanyID"
        runat="server" Width="165px">
        </asp:DropDownList>
<%--    This dropdown list is connected to sql database showing all current scholarships available--%>
        <asp:SqlDataSource ID="SqlDataSrcCompany" runat="server" 
            ConnectionString="<%$ConnectionStrings:Lab3 %>" 
            SelectCommand="select CompanyName, CompanyID from Company" >
        </asp:SqlDataSource>
        <br /><br />
        <asp:Label ID="lblJob" runat="server" Text="Choose Available Position: "></asp:Label>
        <asp:DropDownList ID="ddlJob" 
        AutoPostBack="true"
        DataSourceID="SqlDataJob"
        DataTextField="Positions"
        DataValueField="ID"
        runat="server" Width="165px">
        </asp:DropDownList>
<%--    This dropdown list is connected to sql database showing all current scholarships available--%>
        <asp:SqlDataSource ID="SqlDataJob" runat="server" ConnectionString="<%$ConnectionStrings:Lab3 %>" 
            SelectCommand="sp_listOpenings" SelectCommandType="StoredProcedure">
        <SelectParameters>
        <asp:ControlParameter ControlID="ddlCompanies" 
                DefaultValue="ddlCompanies.SelectedValue.ToString()" 
                Name="CompanyID" 
                PropertyName="SelectedValue" 
                Type="String" />
        </SelectParameters>    
        </asp:SqlDataSource>
        <br /><br />
        <asp:Label runat="server" ID="lblAppDate" Text="Application Date"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtAppDate" runat="server" Text="" ReadOnly="true" Width="223px"></asp:TextBox>
        <br /><br />
        
        
        
    </div >
    <br /><br /><br /><br />
    <center>
        <asp:Button ID="btnCommit" runat="server" Text="Sumbit" OnClick="btnCommit_Click" />
        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" /> 
    </center>
</asp:Content>
