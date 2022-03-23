<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Lab3.Home" %>
<%--Nick Kirbabas 
CIS 484 Lab 3 
This page is the home page for all users--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: 200px">
    <asp:Label ID="lblWelcome" runat="server" Text="Label" Font-Size="XX-Large"></asp:Label>
    <br /><br />
        <asp:Label ID="lblError" runat="server" Text=""
                            ForeColor="Red" Font-Bold="true"></asp:Label>
    </div>
</asp:Content>
