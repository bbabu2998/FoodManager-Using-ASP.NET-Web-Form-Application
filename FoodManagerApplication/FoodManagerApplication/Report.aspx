<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Report.aspx.cs" Inherits="FoodManagerApplication.Report" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server"> 
    <body style="background-image:url('Content/images2.png');background-repeat: no-repeat;background-size: cover;">
        <div class="row" style="margin:15px">
            <div class="col-md-4" align="center">
                <asp:DropDownList ID="DropDownListID_PersonName" runat="server" class="dropdown_input" DataSourceID="SqlDataSource_PersonDetails" DataTextField="Name" DataValueField="Name" AppendDataBoundItems="true">
                    <asp:ListItem value="">Select</asp:ListItem>
                </asp:DropDownList>
                <input Id="start" runat="server" type="date" class="dropdown_input"/>
                <input Id="end" runat="server" type="date" class="dropdown_input"/> 
                <div style="text-align:center" >
                    <asp:Button runat="server" Style="width: 50%;margin-top:50px;" CssClass="btn" Text="Get Report" onclick="OnClick_getReport"></asp:Button>
                </div>
            </div><br />
            <div class="col-md-8">
                <div class="row" align="center" >
                    <div class="col-md-8" >
                        <asp:GridView ID="GridViewID_Report" runat="server" Page-Size="10" OnPageIndexChanging="OnPaging" AllowPaging="true" BackColor="#F0F8FF" CaptionAlign="Right" Font-Size="Medium" style=" margin-right:5%;border-radius:5px;" Width="100%" HorizontalAlign="Left" >
                            <AlternatingRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <HeaderStyle CssClass="table-menu-header"  Font-Bold="True" Font-Italic="False" Font-Size="Large" BackColor="#2bae66ff"  HorizontalAlign="Right" VerticalAlign="Middle" Wrap="True" />
                            <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <RowStyle Font-Bold="True" CssClass="table-row-style" Font-Names="Bodoni MT Poster Compressed" HorizontalAlign="Center" VerticalAlign="Middle" />
                            <SelectedRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:GridView> 
                        <asp:Label ID="LabelID_TotalAmount" runat="server" Text="Label" class="label" BackColor="#fcf6f5ff" ForeColor="#2be66ff" BorderColor="Black" BorderStyle="Double" Font-Bold="True" Font-Size="Large" style="position:relative"></asp:Label>
                        <a ID="SendPeriodReport" runat="server" Style="width: 80%;font-size: 20px;margin-top:20px;" type="button" Class="btn" data-toggle="modal" href="#Modal_SendPeriod"><b>Send Period Report</b></a>
                        <div class="bs-example"> 
                            <div id="Modal_SendPeriod" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h3 class="modal-title"><b>Are you sure</b></h3>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group" align="center">
                                                <img src="Content/modal.gif" style="height:200px;"/>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button runat="server" type="button" class="btn1 btnstyle" Text="Yes" onclick="Onclick_SendPeriodReport" />
                                            <button type="button" class="btn1 btnstyle" data-dismiss="modal">No</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="col-md-4"></div>
                    <div style="margin:15%";>
                        <a ID="SendMonthlyReport" runat="server" Style="width: 50%;font-size: 20px;" type="button" Class="btn" data-toggle="modal" href="#Modal_SendMonthly"><b>Send Monthly Report</b></a>
                        <div class="bs-example"> 
                            <div id="Modal_SendMonthly" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h3 class="modal-title"><b>Are you sure</b></h3>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group" align="center">
                                                <asp:DropDownList ID="DropDownListName" runat="server" class="dropdown_input" DataSourceID="SqlDataSource_PersonDetails" DataTextField="Name" DataValueField="Name" AppendDataBoundItems="true">                                   
                                                    <asp:ListItem value="">Select</asp:ListItem>
                                                </asp:DropDownList>
                                                <input Id="month" runat="server" type="month" class="dropdown_input"/>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button runat="server" type="button" class="btn1 btnstyle" Text="Yes" onclick="OnClick_sendMonthlyReport" />
                                            <button type="button" class="btn1 btnstyle" data-dismiss="modal">No</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div> 
    </body>
    <asp:SqlDataSource ID="SqlDataSource_PersonDetails" runat="server" ConnectionString="<%$ ConnectionStrings:FoodManagerConnectionString %>" SelectCommand="SELECT [Name] FROM [PersonDetails]"></asp:SqlDataSource>
    <style>
        tr.table-menu-header > th 
        {
            text-align: center;
            Padding:15px;
        }
        tr.table-row-style > td
        {
            Padding:10px;
        }
        .dropdown_input
        {
            width:50%;
            height:50px;
            border:solid 2px ;
            font-size:medium;
            text-align-last:center;
            margin-top:50px;
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
       .label
       {
           width:80%;
           height:100%;
           border:solid 2px ;
           text-align-last:center;
           margin-top:20px;
           padding:10px;
           position:relative; 
       }
    </style>
</asp:Content>

