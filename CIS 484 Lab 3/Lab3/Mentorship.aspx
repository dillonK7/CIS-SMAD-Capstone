<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="Mentorship.aspx.cs" Inherits="Lab3.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--Nick Kirbabas 
    CIS 484 Lab 3
    02/12/22 
    This is the mentorship webpage to assign a student to webpage--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: 300px">
        <asp:Label ID="lblAssign" runat="server" Text="Assign Mentor: "></asp:Label>
        <asp:DropDownList ID="ddlMembers" 
        AutoPostBack="true"
        DataSourceID="SqlDataMember"
        DataTextField="UserInfo"
        DataValueField="MemberID" 
        OnSelectedIndexChanged="ddlStudents_SelectedIndexChanged"
        runat="server" Width="165px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataMember" runat="server" ConnectionString="<%$ConnectionStrings:Lab3 %>" SelectCommand="SELECT FirstName + ' ' + LastName AS UserInfo, MemberID FROM Members" >
        </asp:SqlDataSource>
        <%--connects to the DB and displays the available list of members --%>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="LblTo" runat="server" Text="To Student: "></asp:Label>
        <asp:DropDownList ID="ddlStudents" 
        AutoPostBack="true"
        DataSourceID="sqlsrcUserTable"
        DataTextField="UserInfo"
        DataValueField="StudentID" 
        OnSelectedIndexChanged="ddlStudents_SelectedIndexChanged"
        runat="server" Width="165px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sqlsrcUserTable" runat="server" ConnectionString="<%$ConnectionStrings:Lab3 %>" SelectCommand="SELECT FirstName + ' ' + LastName AS UserInfo, StudentID FROM Students" >
        </asp:SqlDataSource>
        <%--This connects to the DB and displays all students--%>
        <br /><br /><br /><br />
    </div >
    <center>
    <asp:Button ID="btnAssign" runat="server" Text="Assign Mentor" OnClick="btnAssign_Click" style="margin-left: 0px"/>
    
    
    </center>
</asp:Content>
