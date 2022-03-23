<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="Application.aspx.cs" Inherits="Lab3.Application" %>
<%--Nick Kirbabas 
CIS 484 Lab 3 
This page shows the applications of students who applied --%>

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
        <asp:SqlDataSource ID="SqlDataScholarship" runat="server" ConnectionString="<%$ConnectionStrings:Lab3 %>" 
            SelectCommand="select ScholarshipName, ScholarshipID from Scholarship" >
        </asp:SqlDataSource>
       <br /><br />
        </div>

        <asp:GridView ID="grdvStudentScholarship"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcStudent"
        AllowPaging="True" Width="1048px" DataKeyNames="StudentID" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
            <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField HeaderText="StudentID"
                DataField="StudentID" SortExpression="StudentID" ReadOnly="True" Visible="false"/>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnApprove" runat="server" Text="Grant Scholarship" OnClick="btnApprove_Click"  />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="UserInfo"
                DataField="UserInfo" SortExpression="UserInfo" ReadOnly="True" />
            <asp:BoundField  HeaderText="Major"
                DataField="Major" SortExpression="Major" ReadOnly="True"/>
            <asp:BoundField HeaderText="Email"
                DataField="Email" SortExpression="Email" ReadOnly="True"/>
            <asp:BoundField  HeaderText="GradDate"
                DataField="GradDate" SortExpression="GradDate" ReadOnly="True"/>
            <asp:BoundField  HeaderText="ScholarshipName"
                DataField="ScholarshipName" SortExpression="ScholarshipName" ReadOnly="True"/>
            <asp:BoundField  HeaderText="AppStatus"
                DataField="AppStatus" SortExpression="AppStatus" />
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
        ID="sqlsrcStudent"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>"
        SelectCommand="sp_displayStuScholar"
        ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlScholarships" 
                DefaultValue="ddlScholarships.SelectedValue.ToString()" 
                Name="ScholarshipID" 
                PropertyName="SelectedValue" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>
