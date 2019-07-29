<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FoodManagerApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <body id="body" style="background-repeat:no-repeat;">
        <script type="text/javascript">
            $(document).ready(function ()
            {
                $("#Modal_PersonCredential").on('shown.bs.modal', function ()
                {
                    $(this).find('input[type="text"]').focus();
                });
            });

            var UserName = '<%= Session["UserName"] %>';
            if (UserName == "admin")
            {
                $(function () {
                    var body = $('body');
                    var backgrounds = new Array('url(Content/slide2.png)no-repeat', 'url(Content/food.png)no-repeat');
                    var current = 0;
                    function nextBackground()
                    {
                        body.css('background', backgrounds[current = ++current % backgrounds.length]);
                        document.getElementById("body").style.backgroundSize = "cover";
                        setTimeout(nextBackground, 5000);
                    }
                    setTimeout(nextBackground, 5000);
                    body.css('background', backgrounds[0]);
                    document.getElementById("body").style.backgroundSize = "cover";
                });
            }
            else
            {
                $(function ()
                {
                    var body = $('body');
                    var backgrounds = new Array('url(Content/open.png)no-repeat', 'url(Content/slide2.png)no-repeat', 'url(Content/food.png)no-repeat');
                    var current = 0;
                    function nextBackground()
                    {
                        body.css('background', backgrounds[current = ++current % backgrounds.length]);
                        document.getElementById("body").style.backgroundSize = "cover";
                        setTimeout(nextBackground, 5000);
                    }
                    setTimeout(nextBackground, 5000);
                    body.css('background', backgrounds[0]);
                    document.getElementById("body").style.backgroundSize = "cover";
                });
            }
        </script>
        <div class="head-menu">M&S GuestHouse</div>       
        <div class="buttons-flex-box">
            <asp:Button ID="UpdateMenu" runat="server" Style="width: 20%;" CssClass="btn" Text="Update Menu" PostBackUrl="~/MenuPage.aspx" />
            <asp:Button ID="FoodEntry" runat="server" Style="width: 20%;" CssClass="btn" Text="Food Entry" PostBackUrl="~/FoodEntry.aspx" />
            <asp:Button ID="Report" runat="server" Style="width: 20%;" CssClass="btn" Text="Report" PostBackUrl="~/Report.aspx" />
            <a ID="AddPerson" runat="server" Style="width: 20%;" type="button" Class="btn" data-toggle="modal" href="#Modal_PersonCredential">Person Credential</a>
              <div class="bs-example"> 
                  <div id="Modal_PersonCredential" class="modal fade">
                      <div class="modal-dialog">
                          <div class="modal-content">
                              <div class="modal-header">
                                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                  <h4 class="modal-title">Add New Person</h4>
                              </div>
                              <div class="modal-body">
                                  <form>
                                      <div class="form-group">
                                          <label for="inputName">Name</label>
                                          <input id="inputname" runat="server" type="text" class="form-control" />
                                      </div>
                                      <div class="form-group">
                                          <label for="inputEmail">Email</label>
                                          <input id="inputEmail" class="form-control"  type="email" runat="server"  />
                                      </div>
                                  </form>
                              </div>
                              <div class="modal-footer">
                                  <asp:Button runat="server" type="button" class="btn btnstyle" Text="Add" onclick="Add_Person" />
                                  <a ID="A1" runat="server" align="center" type="button" Class="btn btnRemovestyle " data-toggle="modal" data-dismiss="modal" href="#Modal_RemovePerson">Remove</a>
                                  <button type="button" class="btn btnstyle" data-dismiss="modal">Cancel</button>
                              </div>
                          </div>
                      </div>
                  </div>
              </div> 
            <div class="bs-example"> 
                  <div id="Modal_RemovePerson" class="modal fade">
                      <div class="modal-dialog">
                          <div class="modal-content">
                              <div class="modal-header">
                                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                  <h4 class="modal-title" align="center">Remove Person</h4>
                              </div>
                              <div class="modal-body">
                                      <div class="form-group" align="center">
                                          <asp:DropDownList ID="DropDownList1" runat="server" CssClass="dropdownstyle" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name" AppendDataBoundItems="true">
                                           <asp:ListItem value="">Select</asp:ListItem>
                                          </asp:DropDownList>
                                          <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:FoodManagerConnectionString %>' SelectCommand="SELECT [Name] FROM [PersonDetails]"></asp:SqlDataSource>
                                      </div>
                              </div>
                              <div class="modal-footer">
                                  <asp:Button runat="server" type="button" class="btn btnstyle glyphicon-glyphicon-ok-circle" Text="Remove" onclick="Remove_Person" />
                                 <button type="button" class="btn btnstyle" data-dismiss="modal">Cancel</button>
                              </div>
                          </div>
                      </div>
                  </div>
              </div> 
        </div>
    </body>

    <style>
        .bs-example
        {
            margin: 20px;
        }
        .head-menu 
        {
            color: azure;
            font-family:emoji;
            font-size: 84px;
            text-align: right;
            margin-right: 8%;
            margin-top:7%
        }
        .btnRemovestyle{
            width:30%;
            height:50px;
            text-align:center;
	        font-size: 17px;
            font-weight:bold;
            padding:2.5%;
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
        .dropdownstyle
        {
            width:50%;
            height:50px;
            border:solid 2px ;
            text-align-last:center;
            margin-top:50px;
        }
        .buttons-flex-box
        {
	      padding: 0;
          margin: 0;
          list-style: none;
          display: -webkit-box;
          display: -moz-box;
          display: -ms-flexbox;
          display: -webkit-flex;
          display: flex;
          -webkit-flex-flow: row wrap;
          justify-content: space-around;
          flex-flow: row wrap;
          margin-top:15%;
          margin-left:7%;
        }
        @media screen and (max-width: 600px)
        {
            .buttons-flex-box 
            {
                flex-direction: column;
            }  
        }
    </style>
</asp:Content>
