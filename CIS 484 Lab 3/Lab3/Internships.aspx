<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="Internships.aspx.cs" Inherits="Lab3.Internships" %>

<%--Nick Kirbabas 
CIS 484 Lab 3
This page is for creating and editing internships --%>

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
        <%-- Connectes to sql database and displays company name--%>
        <br />
        <br />
        <asp:Label ID="lblDescription" runat="server" Text="Internship Description: "></asp:Label>
        <br />
        <asp:TextBox ID="txtDescription" Wrap="true" Text="Please Enter Data" runat="server" Height="100px" Width="357px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblYear" runat="server" Text="Internship Year:"></asp:Label>
        <asp:DropDownList ID="ddlYear" runat="server">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Freshman</asp:ListItem>
            <asp:ListItem>Sophomore</asp:ListItem>
            <asp:ListItem>Junior</asp:ListItem>
            <asp:ListItem>Senior</asp:ListItem>
        </asp:DropDownList>
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
    </div>
    <br />
    <br />
    <center>
        <asp:Button ID="btnAssign" runat="server" Text="Assign" OnClick="btnAssign_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
        <br />
    </center>
    <asp:GridView ID="grdvIntern"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcIntern"
        AllowPaging="True" Width="1048px" DataKeyNames="InternID" BackColor="LightGoldenrodYellow"
        BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnRowCommand="grdvIntern_RowCommand">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField DataField="InternID" HeaderText="InternID" SortExpression="InternID" Visible="false" InsertVisible="False" ReadOnly="True" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click"
                        CommandName="InternID" CommandArgument='<%# Eval("InternID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="InternDesc" HeaderText="InternDesc" SortExpression="InternDesc" />
            <asp:BoundField DataField="InternYr" HeaderText="InternYr" SortExpression="InternYr" />
            <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" />
            <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate" />
            <asp:BoundField DataField="CompanyName" HeaderText="CompanyName" SortExpression="CompanyName" />
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
        ID="sqlsrcIntern"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>" ProviderName="System.Data.SqlClient"
        SelectCommand="sp_SelectInternship"
        UpdateCommand="UPDATE [Internship] SET [InternDesc] = @Desc, [InternYr] = @Yr, [StartDate] = @Start, [EndDate] = @End WHERE [InternID] = @InternID" SelectCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Type="String" Name="Desc" />
            <asp:Parameter Type="String" Name="Yr" />
            <asp:Parameter Type="String" Name="Start" />
            <asp:Parameter Type="String" Name="End" />
            <asp:Parameter Type="String" Name="InternID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <center>
    <asp:Label ID="lblInternDesc" runat="server" Text="Internship Description" Visible="false"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtInternDesc" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
    <br />
    <br />
     <asp:Label ID="lblInternYear" runat="server" Text="Internship Year:" Visible="false"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlInternYr" runat="server">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Freshman</asp:ListItem>
            <asp:ListItem>Sophomore</asp:ListItem>
            <asp:ListItem>Junior</asp:ListItem>
            <asp:ListItem>Senior</asp:ListItem>
        </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="lblStartDate2" runat="server" Text="Start Date" Visible="false"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtStartDate2" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
    <br />
    <br />
    <asp:Label ID="lblEndDate2" runat="server" Text="End Date" Visible="false"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtEndDate2" Text="Please Enter Data" runat="server" Visible="false"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="btnUpdate" runat="server" Text="Update Company Information" Visible="false" OnClick="btnUpdate_Click" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </center>


</asp:Content>
