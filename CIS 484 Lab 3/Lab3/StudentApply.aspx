<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="StudentApply.aspx.cs" Inherits="Lab3.StudentApply" %>
<%--Nick Kirbabas 
CIS 484 Lab 3
This page is for students to apply for scholarships--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: 300px">
        <asp:Label ID="lblScholarship" runat="server" Text="Choose Scholarship: "></asp:Label>
        <asp:DropDownList ID="ddlScholarships" 
        AutoPostBack="true"
        DataSourceID="SqlDataScholarship"
        DataTextField="ScholarshipName"
        DataValueField="ScholarshipID"
        runat="server" Width="165px">
        </asp:DropDownList>
<%--    This dropdown list is connected to sql database showing all current scholarships available--%>
        <asp:SqlDataSource ID="SqlDataScholarship" runat="server" ConnectionString="<%$ConnectionStrings:Lab3 %>" SelectCommand="select ScholarshipName, ScholarshipID from Scholarship" >
        </asp:SqlDataSource>
        <br /><br />
        <asp:Label runat="server" ID="lblAppDate" Text="Application Date"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtAppDate" runat="server" Text="" ReadOnly="true" Width="223px"></asp:TextBox>
        

        <br /><br />
        <asp:Label runat="server" ID="lblAppText" Text="Application Description:"></asp:Label>
        <br />
        <asp:TextBox ID="txtAppText" runat="server" Wrap="true" Height="97px" Width="291px"></asp:TextBox>
        <br /><br />
        
    </div >
    <br /><br /><br /><br />
    <center>
        <asp:Button ID="btnCommit" runat="server" Text="Sumbit" OnClick="btnCommit_Click" />
        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" /> 
    </center>
</asp:Content>
