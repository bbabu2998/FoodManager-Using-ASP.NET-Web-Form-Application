<%@ Page Title="Food Entry" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FoodEntry.aspx.cs" Inherits="FoodManagerApplication.Contact" %>
     
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <body style="background-image:url('Content/image.png');background-repeat: no-repeat;background-size: cover;"> 
        <div class="row" style="margin:15px"><br />
            <div class="col-md-5" style="margin-top:10%" align="center">
                <input Id="DateValue" runat="server" type="date" class="date_dropdownstyle" />
                <asp:DropDownList ID="DropDownListID_Period" AutoPostBack = "true" OnSelectedIndexChanged="AutoSelectFoodItem"  runat="server" class="date_dropdownstyle">
                    <asp:ListItem value="" >Select</asp:ListItem>
                    <asp:ListItem value="Breakfast">Breakfast</asp:ListItem>
                    <asp:ListItem value="Lunch">Lunch</asp:ListItem>
                    <asp:ListItem value="Dinner">Dinner</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-7" align="center">
                <a ID="UpdateEntryID" runat="server" Style="width: 50%;margin-top:1%;padding:15px" type="button" Class="btn btnstyle" data-toggle="modal" href="#Modal_UpdateEntry">Update</a>
                <div class="bs-example"> 
                    <div id="Modal_UpdateEntry" class="modal fade">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title"><b>Update Entry</b></h4>
                                </div>
                                <div class="modal-body">
                                    <asp:DropDownList ID="DropDownListID_PersonName" runat="server" class="date_dropdownstyle" DataSourceID="SqlDataSource_PersonDetails" DataTextField="Name" DataValueField="Name" AppendDataBoundItems="true">             
                                        <asp:ListItem value="">Select</asp:ListItem></asp:DropDownList>
                                    <input Id="ModalID_UpdateDate" runat="server" type="date" class="date_dropdownstyle" />
                                    <asp:DropDownList ID="DropDownListID_UpdatePeriod" runat="server" class="date_dropdownstyle">
                                        <asp:ListItem value="" >Select</asp:ListItem>
                                        <asp:ListItem value="Breakfast">Breakfast</asp:ListItem>
                                        <asp:ListItem value="Lunch">Lunch</asp:ListItem>
                                        <asp:ListItem value="Dinner">Dinner</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DropDownListID_UpdateFood" runat="server" CssClass="date_dropdownstyle" DataSourceID="SqlDataSource_Amount" DataTextField="Item" DataValueField="Item" AppendDataBoundItems="true">
                                        <asp:ListItem value="">Select</asp:ListItem>
                                    </asp:DropDownList>
                                    
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" type="button" class="btn btnstyle" Text="Update" onclick="Update_Onclick" />
                                    <button type="button" class="btn btnstyle" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
                <asp:GridView ID="GridViewID_FoodEntry" runat="server" AutoGenerateColumns="False" CaptionAlign="Right" DataSourceID="SqlDataSource_PersonDetails" Font-Size="Medium"  Height="100%" PageSize="10" AllowPaging="true"  style="Width:100%;margin-top:5%;background:#8e9eab;background:-webkit-linear-gradient(to right, #8e9eab, #eef2f3);background:linear-gradient(to right, #8e9eab, #eef2f3);padding:20px" Width="33%" HorizontalAlign="center" EditRowStyle-VerticalAlign="NotSet">
                    <AlternatingRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />  
                    <Columns>  
                        <asp:TemplateField HeaderText="Name">  
                            <EditItemTemplate>  
                                <asp:TextBox ID="TextBoxID_PersonName" runat="server"  Text='<%# Bind("Name") %>'></asp:TextBox>
                            </EditItemTemplate> 
                            <ItemTemplate>  
                                <asp:Label ID="LabelID_PersonName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>   
                            </ItemTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField HeaderText="Item">
                            <EditItemTemplate>  
                                <asp:TextBox ID="TextBoxID_FoodName" runat="server"></asp:TextBox> 
                            </EditItemTemplate> 
                            <ItemTemplate>  
                                <asp:DropDownList ID="DropDownListID_FoodName"  runat="server" Width="200px"> 
                                </asp:DropDownList>  
                            </ItemTemplate>  
                        </asp:TemplateField>  
                    </Columns>  
                    <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <HeaderStyle CssClass="table-menu-header" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#003300" HorizontalAlign="Right" VerticalAlign="Middle" Wrap="True" />
                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <RowStyle  Font-Names="fantasy" CssClass="table-row-style" ForeColor="#110252" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <SelectedRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:GridView>  
                <asp:Button runat="server"  class="buttons-flex-box" Text="Add" Font-Bold="True" Font-Size="Large" onclick="AddFoodEntry_Onclick" ForeColor="Black"  />
            </div> 
        </div>
        <asp:SqlDataSource ID="SqlDataSource_PersonDetails" runat="server" ConnectionString="<%$ ConnectionStrings:FoodManagerConnectionString %>" SelectCommand="SELECT [Name] FROM [PersonDetails]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Amount" runat="server" ConnectionString="<%$ ConnectionStrings:FoodManagerConnectionString %>" SelectCommand="SELECT [Item] FROM [Amount]"></asp:SqlDataSource>
    </body>

    <style>
        .date_dropdownstyle
        {
            width:50%;
            height:50px;
            border:solid 2px ;
            font-size:medium;
            text-align-last:center;
            margin-top:50px;
        }
        tr.table-row-style > td
        {
            Padding:10px;
        }
        tr.table-menu-header > th
        {
            text-align: center;
            padding:12px;
        }
        .btnstyle
        {
            width:30%;
            height:50px;
            text-align:center;
            padding:0px;
	        font-size: 18px;
            font-weight:bold;
        }
        .buttons-flex-box
        {
	        display: flex;
	        flex-direction: row;
            justify-content: center;
            border: none;
            width:50%;
            position: relative;
	        margin-top: 50px;
	        padding: 15px 32px;
	        border-radius: 6px;
	        box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
        }
        .flex
        {
            display: flex;
            flex-direction: row;
            justify-content:space-between;
        }
        .buttons-flex-box:hover
        {
            background-color: rgb(74, 13, 143);
            background: -moz-linear-gradient(135deg, rgb(74, 13, 143) 0%, rgb(250, 42, 143) 100%);
            background: -webkit-linear-gradient(135deg, rgb(74, 13, 143) 0%, rgb(250, 42, 143) 100%);
        }
    </style>
</asp:Content>
