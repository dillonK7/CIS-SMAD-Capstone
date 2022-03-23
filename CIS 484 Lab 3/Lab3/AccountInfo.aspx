<%@ Page Title="Kirbabas DukeGroup" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="AccountInfo.aspx.cs" Inherits="Lab3.AccountInfo" %>

<%--Nick Kirbabas 
CIS 484 Lab 3 
This page displays the users info--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

   <%-- Account info if the user is a student--%>
    <asp:GridView ID="grdvStudent"
        runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="sqlsrcStudent"
        AllowPaging="True" Width="1048px" DataKeyNames="StudentID" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField ReadOnly="true" HeaderText="StudentID" DataField="StudentID" SortExpression="StudentID" InsertVisible="False" Visible="false" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click"  />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="SUsername" DataField="SUsername" SortExpression="SUsername" />
            <asp:BoundField HeaderText="FirstName" DataField="FirstName" SortExpression="FirstName" />
            <asp:BoundField HeaderText="LastName" DataField="LastName" SortExpression="LastName" />
            <asp:BoundField HeaderText="Email" DataField="Email" SortExpression="Email" />
            <asp:BoundField HeaderText="PhoneNumber" DataField="PhoneNumber" SortExpression="PhoneNumber" />
            <asp:BoundField HeaderText="GradDate" DataField="GradDate" SortExpression="GradDate" />
            <asp:BoundField HeaderText="Major" DataField="Major" SortExpression="Major" />
            <asp:BoundField HeaderText="EmployStatus" DataField="EmployStatus" SortExpression="EmployStatus" />
            <asp:BoundField HeaderText="resumeFile" DataField="resumeFile" SortExpression="resumeFile" />
            <%--Download button for resume--%>
            <asp:TemplateField HeaderText="Download Here">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDownload" runat="server" CausesValidation="False"
                        Text='Download' OnClick="lnkDownload_Click" />
                </ItemTemplate>
            </asp:TemplateField>

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
        SelectCommand="sp_selectStudent"
        ProviderName="System.Data.SqlClient"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="SUsername" SessionField="UserName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <center>
        <asp:Label ID="lblResume" runat="server" Text="Resume Upload" Visible="false"></asp:Label>
        <asp:FileUpload ID="ResumeUpload" runat="server" Width="202px" Visible="false" />
        <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" Visible="false" />
        
    </center>
    <br />
    <br />
    <%--Gridview for if the user is a member--%>
    <asp:GridView ID="GridView1" runat="server"
        AutoGenerateColumns="False"
        AllowSorting="True"
        DataSourceID="SqlsrcMember"
        AllowPaging="True" Width="1048px" DataKeyNames="MemberID" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField DataField="MemberID" HeaderText="MemberID" ReadOnly="True" SortExpression="MemberID" Visible="false" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click"  />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MUsername" HeaderText="MUsername" SortExpression="MUsername" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber" />
            <asp:BoundField DataField="GradDate" HeaderText="GradDate" SortExpression="GradDate" />
            <asp:BoundField DataField="Major" HeaderText="Major" SortExpression="Major" />
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
    <asp:SqlDataSource ID="SqlsrcMember"
        ConnectionString="<%$ ConnectionStrings:Lab3 %>" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="sp_selectMember"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="MUsername" SessionField="UserName" Type="String" />
        </SelectParameters>

    </asp:SqlDataSource>

    <%--Form used to update user information--%>
    <center>
        <br /><br />
        <asp:Label ID="lblUsername" runat="server" Text="Username" Visible="false"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Label ID="lblFirstName" runat="server" Text="First Name" Visible="false"></asp:Label>
        <asp:TextBox ID="txtFirstName" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Label ID="lblLastName" runat="server" Text="Last Name" Visible="false"></asp:Label>
        <asp:TextBox ID="txtLastName" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Label ID="lblEmail" runat="server" Text="Email" Visible="false"></asp:Label>
        <asp:TextBox ID="txtEmail" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Label ID="lblPhone" runat="server" Text="Phone Number" Visible="false"></asp:Label>
        <asp:TextBox ID="txtPhone" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Label ID="lblGradDate" runat="server" Text="Graduation Date" Visible="false"></asp:Label>
        <asp:TextBox ID="txtGradDate" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Label ID="lblMajor" runat="server" Text="Major" Visible="false"></asp:Label>
        <asp:TextBox ID="txtMajor" runat="server" Visible="false"></asp:TextBox>
        <br /><br />
        <asp:Label ID="lblEmploymentStatus" runat="server" Text="Employment Status"  Visible="false"></asp:Label>
        <asp:TextBox ID="txtEmploymentStatus" runat="server" Visible="false" ></asp:TextBox>
        <br /><br />
        <asp:Button ID="btnClear" runat="server" Text="Undo Changes" Visible="false" OnClick="btnClear_Click" />

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:Button ID="btnUpdate" runat="server" Text="Update Info" Visible="false" OnClick="btnUpdate_Click" />
    </center>

</asp:Content>
