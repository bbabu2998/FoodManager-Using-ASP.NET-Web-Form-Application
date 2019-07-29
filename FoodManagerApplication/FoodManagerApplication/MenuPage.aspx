<%@ Page Title="UpdateMenu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MenuPage.aspx.cs" Inherits="FoodManagerApplication.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server"> 
    <body style="background-image:url('Content/images2.png');background-repeat: no-repeat;background-size: cover;"><br />
        <script type="text/javascript">
            $(document).ready(function ()
            {
                $("#myModal").on('shown.bs.modal', function ()
                {
                    $(this).find('input[type="text"]').focus();
                });
            });
        </script>
        <div class="row" style="margin:15px">
            <div class="col-md-4">
                <asp:GridView ID="GridView_Menu" runat="server" AutoGenerateColumns="False" BackColor="#CCFFCC" BorderColor="#e6ac00" CaptionAlign="Right" DataSourceID="SqlDataSource_UpdateMenu" Font-Size="Medium" Height="701px" Width="100%" HorizontalAlign="Left" EditRowStyle-VerticalAlign="NotSet">
                    <RowStyle Font-Bold="True" Font-Names="Bodoni MT Poster Compressed" CssClass="table-row-style" HorizontalAlign="Center" VerticalAlign="Middle" /> 
                    <Columns>
                        <asp:TemplateField HeaderText="Days"> 
                            <ItemTemplate>  
                                <asp:Label ID="Days" runat="server" Text='<%# Bind("Days") %>' ></asp:Label> 
                            </ItemTemplate> 
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Breakfast">  
                            <EditItemTemplate>  
                                <asp:DropDownList ID="breakfastDropdownlist" Text='<%# Bind("Breakfast") %>' runat="server" Width="150px" DataSourceID="SqlDataSource_Amount" DataTextField="Item" DataValueField="Item"> 
                                </asp:DropDownList>  
                            </EditItemTemplate>  
                            <ItemTemplate> 
                                <asp:Label ID="breakfast" runat="server" Text='<%# Bind("Breakfast") %>' ></asp:Label> 
                            </ItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Lunch"> 
                            <EditItemTemplate> 
                                <asp:DropDownList ID="lunchDropdownlist"  Text='<%# Bind("Lunch") %>' runat="server" Width="150px" DataSourceID="SqlDataSource_Amount" DataTextField="Item" DataValueField="Item">  
                                </asp:DropDownList>
                            </EditItemTemplate> 
                            <ItemTemplate>  
                                <asp:Label ID="lunch" runat="server" Text='<%# Bind("Lunch") %>' ></asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Dinner"> 
                            <EditItemTemplate>  
                                <asp:DropDownList ID="dinnerDropdownlist" Text='<%# Bind("Dinner") %>' runat="server" Width="150px" DataSourceID="SqlDataSource_Amount" DataTextField="Item" DataValueField="Item" >
                                </asp:DropDownList> 
                            </EditItemTemplate>  
                            <ItemTemplate>  
                                <asp:Label ID="dinner" runat="server" Text='<%# Bind("Dinner") %>'></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:CommandField HeaderText="Update" ShowEditButton="True" />
                    </Columns>
                </asp:GridView>
            </div> 
            <div class="col-md-6 col-md-push-2">
                <asp:GridView ID="GridViewID_Item" runat="server" AutoGenerateColumns="False" BackColor="#CCFFCC" BorderColor="#E6AC00" CaptionAlign="Right" DataSourceID="SqlDataSource_UpdateAmount" Font-Size="Medium" Height="701px"  style="box-shadow:1px 1px 1px #111" Width="50%" HorizontalAlign="Left" EditRowStyle-VerticalAlign="NotSet" DataKeyNames="S_NO">
                    <AlternatingRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <Columns>
                        <asp:BoundField DataField="S_NO" HeaderText="S_NO" SortExpression="S_NO" ReadOnly="true" Visible="False" />
                        <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                        <asp:CommandField HeaderText="Update" ShowEditButton="True" ShowHeader="True" />
                    </Columns>
                    <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    <HeaderStyle CssClass="table-menu-header" Font-Bold="True" Font-Italic="False" BackColor="#e6ac00" BorderColor="#997300" Font-Size="Medium" ForeColor="#003300" HorizontalAlign="Right" VerticalAlign="Middle" Wrap="True" />
                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle"  />
                    <RowStyle Font-Bold="True" Font-Names="Bodoni MT Poster Compressed" CssClass="table-row-style" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <SelectedRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:GridView>
            </div>
            <div class="col-md-2" align="center">
                <a ID="AddItem" runat="server" Style="width:50%;padding:5%; margin-top:100%" type="button" Class="btn btnstyle" data-toggle="modal" href="#Modal_AddItem">Add Item</a>
                <div class="bs-example"> 
                    <div id="Modal_AddItem" class="modal fade">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title"><b>Add New Food</b></h4>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="form-group">
                                            <label for="inputItem">Item</label>
                                            <input id="inputItem" runat="server" type="text" class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label for="inputAmount">Amount</label>
                                            <input id="inputAmount" class="form-control" type="number" runat="server"  />
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" type="button" class="btn btnstyle" Text="Add" onclick="AddFood_Onclick" />
                                    <a ID="A1" runat="server" align="center" style="padding:2.5%" type="button" Class="btn btnstyle " data-toggle="modal" data-dismiss="modal" href="#Modal_RemoveItem">Remove</a>
                                    <button type="button" class="btn btnstyle" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
                <div class="bs-example"> 
                    <div id="Modal_RemoveItem" class="modal fade">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">Remove Food</h4>
                                </div>
                                <div class="modal-body">        
                                    <div class="form-group">
                                        <asp:DropDownList ID="DropDownListID_Item" runat="server" CssClass="dropdownlist" DataSourceID="SqlDataSource_UpdateAmount" DataTextField="Item" DataValueField="Item" AppendDataBoundItems="true">
                                            <asp:ListItem value="">Select</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>   
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" type="button" class="btn btnstyle glyphicon-glyphicon-ok-circle" Text="Remove" onclick="RemoveFood_Onclick" />
                                    <button type="button" class="btn btnstyle" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
        <asp:SqlDataSource runat="server" ID="SqlDataSource_Amount" ConnectionString='<%$ ConnectionStrings:FoodManagerConnectionString %>' SelectCommand="SELECT [Item] FROM [Amount]"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="SqlDataSource_UpdateAmount"  ConnectionString="<%$ ConnectionStrings:FoodManagerConnectionString %>" 
            SelectCommand="SELECT [S_NO], [Item], [Amount] FROM [Amount]"
            UpdateCommand="UPDATE Amount SET Item = @Item, Amount = @Amount WHERE S_NO = @S_NO">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_UpdateMenu" runat="server" ConnectionString="<%$ ConnectionStrings:FoodManagerConnectionString %>"
            SelectCommand="SELECT [Days], [Breakfast], [Lunch], [Dinner] FROM [Menu]" 
            UpdateCommand="UPDATE Menu SET Breakfast = @Breakfast, Lunch = @Lunch, Dinner = @Dinner WHERE Days = @Days">
            <UpdateParameters>
                <asp:Parameter Name="Breakfast" Type="String" />
                <asp:Parameter Name="Lunch" Type="String" />
                <asp:Parameter Name="Dinner" Type="String" />
            </UpdateParameters>         
        </asp:SqlDataSource>
    </body>
    <style>
        table, td, th 
        {
            border: 1px solid black;
            text-align:center;
            background:#CCFFCC;
            padding:12px;
        }
        table
        {
            border-collapse: collapse;
            width: 80%;
            padding:12px;
        }
        th
        {
            background:#e6ac00;
            height: 50px;
        }
        tr.table-row-style > td
        {
            Padding:10px;
            background-color: lemonchiffon;
            border-collapse: collapse;
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
            font-size: 17px;
            font-weight:bold;
        }
        .dropdownlist
        {
            width:50%;
            height:50px;
            border:solid 2px ;
            text-align-last:center;
            margin-top:50px;
        }
    </style>
</asp:Content>
