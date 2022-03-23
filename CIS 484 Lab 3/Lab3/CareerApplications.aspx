<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="CareerApplications.aspx.cs" Inherits="Lab3.CareerApplications" %>
<%--Nick Kirbabas 
CIS 484 Lab 3
This page displays all applications for internships and jobs--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--links to take user to adding jobs--%>
    <asp:Label ID="lblIntern" runat="server" Text="For Adding Internship opportunities Click "></asp:Label>
    <asp:HyperLink ID="HLIntern" runat="server" NavigateUrl="~/Internships.aspx" Text="Here"></asp:HyperLink>
    <br />
    <asp:Label ID="lblJob" runat="server" Text="For Adding Job opportunities Click "></asp:Label>
    <asp:HyperLink ID="HLJob" runat="server" NavigateUrl="~/JobCreation.aspx" Text="Here"></asp:HyperLink>
    <br /><br />

    <%--These gridviews show applications to internships and jobs--%>
    <asp:GridView ID="grdvStudent"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcInternships"
        AllowPaging="True" Width="1048px" DataKeyNames="JAppID" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField HeaderText="JAppID" DataField="JAppID" SortExpression="JAppID" ReadOnly="True" Visible="false" InsertVisible="False" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Mark as Reviewed" OnClick="btnEdit_Click"  />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Student" DataField="Student" SortExpression="Student" ReadOnly="True" />
            <asp:BoundField HeaderText="Major" DataField="Major" SortExpression="Major" ReadOnly="True"/>
            <asp:BoundField HeaderText="InternDesc" DataField="InternDesc" SortExpression="InternDesc" ReadOnly="True"/>
            <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" ReadOnly="True"/>
            <asp:BoundField HeaderText="AppStatus" DataField="AppStatus" SortExpression="AppStatus" />
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
        ID="sqlsrcInternships"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>"
        SelectCommand="sp_displayIApps"
        UpdateCommand="UPDATE [jobApp] SET [jobApp].[AppStatus] = @AppStatus WHERE [JAppID] = @JAppID" ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Student" />
            <asp:Parameter Name="Major" />
            <asp:Parameter Name="JobPosition" />
            <asp:Parameter Name="CompanyName" />
            <asp:Parameter Name="AppStatus" />
            <asp:Parameter Name="JAppID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <br />


    <asp:GridView ID="grdvJobs"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="SqlsrcJobs"
        AllowPaging="True" Width="1048px" DataKeyNames="JAppID" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField HeaderText="JAppID" DataField="JAppID" SortExpression="JAppID" ReadOnly="True" InsertVisible="False" Visible="false" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Mark as Reviewed" OnClick="btnEdit_Click1"  />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Student" DataField="Student" SortExpression="Student" ReadOnly="True" />
            <asp:BoundField HeaderText="Major" DataField="Major" SortExpression="Major" ReadOnly="True"/>
            <asp:BoundField HeaderText="JobPosition" DataField="JobPosition" SortExpression="JobPosition" ReadOnly="True"/>
            <asp:BoundField HeaderText="CompanyName" DataField="CompanyName" SortExpression="CompanyName" ReadOnly="True"/>
            <asp:BoundField HeaderText="AppStatus" DataField="AppStatus" SortExpression="AppStatus" />
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
        ID="SqlsrcJobs"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>"
        SelectCommand="sp_displayJApps"
        SelectCommandType="StoredProcedure"
        UpdateCommand="sp_updateJobAppJ" ProviderName="System.Data.SqlClient" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Student" />
            <asp:Parameter Name="Major" />
            <asp:Parameter Name="JobPosition" />
            <asp:Parameter Name="CompanyName" />
            <asp:Parameter Name="AppStatus" />
            <asp:Parameter Name="JAppID" />
        </UpdateParameters>
    </asp:SqlDataSource>

    
    

</asp:Content>
