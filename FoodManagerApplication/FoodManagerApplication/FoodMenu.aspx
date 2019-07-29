<%@ Page Title="FoodMenu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FoodMenu.aspx.cs" Inherits="FoodManagerApplication.FoodMenu" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server"> 
    <body style="background-image:url('Content/colorgif.gif');background-repeat: no-repeat;background-size: cover;">
        <asp:GridView ID="GridViewID_FoodMenu" runat="server" AutoGenerateColumns="False" class="table-row-content" CaptionAlign="Right" DataSourceID="SqlDataSource_Menu" Font-Size="Medium" Height="701px" style="margin-left: 25%; margin-top: 1%" Width="803px" HorizontalAlign="Center" EditRowStyle-VerticalAlign="NotSet">
            <AlternatingRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <Columns>
                <asp:BoundField DataField="Days" HeaderText="Days" SortExpression="Days">
                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Breakfast" HeaderText="Breakfast" SortExpression="Breakfast" />
                <asp:BoundField DataField="Lunch" HeaderText="Lunch" SortExpression="Lunch" />
                <asp:BoundField DataField="Dinner" HeaderText="Dinner" SortExpression="Dinner" />
            </Columns>
            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <HeaderStyle CssClass="table-menu-header" Font-Names="Bodoni MT Poster Compressed" BackColor="#660033" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#003300" HorizontalAlign="Right" VerticalAlign="Middle" Wrap="True"  />
            <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <RowStyle Font-Bold="True" Font-Names="Bodoni MT Poster Compressed" ForeColor="white" HorizontalAlign="Center" VerticalAlign="Middle" />
            <SelectedRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView>  
        <asp:SqlDataSource ID="SqlDataSource_Menu" runat="server" ConnectionString="<%$ ConnectionStrings:FoodManagerConnectionString %>" SelectCommand="SELECT [Days], [Breakfast], [Lunch], [Dinner] FROM [Menu]"> </asp:SqlDataSource>
    </body>
    <style>
        tr.table-menu-header > th 
        {
            text-align: center;
            color:white;
        }
        .table-row-content
        {
            background: #1d4350;
            background: -webkit-linear-gradient(to right, #1d4350, #a43931); 
            background: linear-gradient(to right, #1d4350, #a43931);
        }
    </style>
</asp:Content>
