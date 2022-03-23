<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="Scholarship.aspx.cs" Inherits="Lab3.Scholarship" %>

<%--Nick Kirbabas 
CIS 484 Lab 3
This page is for creating scholarships and editing them--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-left: 300px">
        <asp:Label ID="lblScholarName" runat="server" Text="Scholarship Name"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtScholarName" runat="server" Text="Please Enter Data" Width="359px" Height="20px"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_SName"
            ControlToValidate="txtScholarName"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%--This validator requires a scholarship name to be entered--%>
        <br />
        <br />
        <asp:Label ID="lblScholarAmt" runat="server" Text="Scholarship Amount"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtScholarAmt" runat="server" Text="Please Enter Data" Width="200px" Height="20px"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_SAmt"
            ControlToValidate="txtScholarAmt"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%--Requires a scholarship amount to added to text box--%>
        <br />
        <br />
        <asp:Label ID="lblScholarYr" runat="server" Text="Scholarship Year"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtScholarYr" runat="server" Text="Please Enter Data" Width="200px" Height="20px" Style="margin-left: 26px"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_SYr"
            ControlToValidate="txtScholarYr"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <br />
        <br />
        <br />
        <br />
    </div>
    <center>
        <asp:Button ID="btnCommit" runat="server" Text="Create" OnClick="btnCommit_Click" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
        <br /><br />
    </center>
    <asp:GridView ID="grdvScholarship"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcScholarship"
        AllowPaging="True" Width="1048px" DataKeyNames="ScholarshipID" BackColor="LightGoldenrodYellow"
        BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnRowCommand="grdvScholarship_RowCommand">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField DataField="ScholarshipID" HeaderText="ScholarshipID" Visible="False" InsertVisible="False" ReadOnly="True" SortExpression="ScholarshipID" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click"
                        CommandName="ScholarshipID" CommandArgument='<%# Eval("ScholarshipID") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ScholarshipName" HeaderText="ScholarshipName" SortExpression="ScholarshipName" />
            <asp:BoundField DataField="ScholarshipAmt" HeaderText="ScholarshipAmt" SortExpression="ScholarshipAmt" />
            <asp:BoundField DataField="ScholarshipYr" HeaderText="ScholarshipYr" SortExpression="ScholarshipYr" />
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
        ID="sqlsrcScholarship"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>" ProviderName="System.Data.SqlClient"
        SelectCommand="SELECT [ScholarshipID], [ScholarshipName], [ScholarshipAmt], [ScholarshipYr] FROM [Scholarship]"
        UpdateCommand="UPDATE [Scholarship] SET [ScholarshipName] = @ScholarshipName, [ScholarshipAmt] = @ScholarshipAmt, [ScholarshipYr] = @ScholarshipYr WHERE [ScholarshipID] = @ScholarshipID">
        <UpdateParameters>
            <asp:Parameter Type="String" Name="ScholarshipName" />
            <asp:Parameter Type="String" Name="ScholarshipAmt" />
            <asp:Parameter Type="String" Name="ScholarshipYr" />
            <asp:Parameter Type="String" Name="ScholarshipID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <center>
        <asp:Label ID="lblScholarName2" runat="server" Text="Scholarship Name" Visible="false"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtScholarName2" runat="server" Text="Please Enter Data" Width="359px" Height="20px" Visible="false"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_ScholarName"
            ControlToValidate="txtScholarName2"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%--This validator requires a scholarship name to be entered--%>
        <br />
        <br />
        <asp:Label ID="lblScholarAmount" runat="server" Text="Scholarship Amount" Visible="false"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtScholarAmount" runat="server" Text="Please Enter Data" Width="200px" Height="20px" Visible="false"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_ScholarAmount"
            ControlToValidate="txtScholarAmount"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <%--Requires a scholarship amount to added to text box--%>
        <br />
        <br />
        <asp:Label ID="lblScholarYear" runat="server" Text="Scholarship Year" Visible="false"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtScholarYear" runat="server" Text="Please Enter Data" Width="200px" Height="20px" Style="margin-left: 26px" Visible="false"></asp:TextBox>
        <asp:RequiredFieldValidator
            ID="RFV_ScholarYear"
            ControlToValidate="txtScholarYear"
            Text="(Required)" ForeColor="#ff0000"
            runat="server">
        </asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button ID="btnUpdate" runat="server" Text="Update Company Information" Visible="false" OnClick="btnUpdate_Click" />
    </center>

</asp:Content>
