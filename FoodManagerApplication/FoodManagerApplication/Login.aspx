<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FoodManagerApplication.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Login Form</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        function preventBack()
        {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);

        window.onunload = function()
        {
            null
        };
       
       (function () {
            $(function ()
            {
                $(".login--container").removeClass("preload");
                return $(".js-toggle-login").click(() => {
                    $(".login--container").toggleClass("login--active");
                    return $(".login--username-container input").focus();
                });
            });
         })();
      </script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body
        {
            height: 100%;
            background-image:url(Content/login.png);
            background-size:cover;
            background-repeat:no-repeat;
            font-family: "Roboto Slab", serif;
            color: white;
        }
        .preload * 
        {  
            transition: none !important;
        }
        label 
        {
            display: block;
            font-weight: bold;
            font-size: small;
            text-transform: uppercase;
            font-size: 0.7em;
            margin-bottom: 0.35em;
        }
        input[type="text"], input[type="password"]
        {
            width: 100%;
            border: none;
            padding: 0.5em;
            border-radius: 2px;
            margin-bottom: 0.5em;
            color: #333;
        }
        input[type="text"]:focus, input[type="password"]:focus
        {
            outline: none;
            box-shadow: inset -1px -1px 3px rgba(0, 0, 0, 0.3);
        }
        .button {
            padding-left: 1.5em;
            padding-right: 1.5em;
            padding-bottom: 0.5em;
            padding-top: 0.5em;
            border: none;
            border-radius: 2px;
            background-color: #7E5AF1;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.25);
            color: white;
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
        }
        small 
        {  
            font-size: 1em;
        }
        .login--login-submit
        {
            margin-top:5%;
            float: right;
        }
        .login--container
        {
            width: 800px;
            background-color: transparent;
            margin: 0 auto;
            position: relative;
            top: 25%;
        }
        .login--toggle-container
        {
            position: absolute;
            right: 0;
            line-height: 2.5em;
            width: 100%;
            margin-top:-2%;
            background: rgba(0,0,0,0.4);
            border-radius:3px;
            border: 3px solid white;
            color: White;
            text-align: center;
            cursor: pointer;
            transform: perspective(1000px) translateZ(1px);
            transform-origin: 0% 0%;
            transition: all 1s cubic-bezier(0.06, 0.63, 0, 1);
            backface-visibility: hidden;
        }
        .login--toggle-container .js-toggle-login
        {
            font-size:xx-large;
            text-decoration: none;
        }
        .login--active .login--toggle-container
        {
            transform: perspective(1000px) rotateY(180deg);
            background-color: #bc1012;
        }
        .login--username-container, .login--password-container
        {
            float: left;
            background: rgba(0,0,0,0.4);
            width: 50%;
            height: 200px;
            position:relative;
            margin-top:-7%;
            padding: 1em;
        }
        .login--username-container,.login--password-container
        {
            transform-origin: 100% 0%;
            transform: perspective(1000px) rotateY(180deg);
            transition: all 1s cubic-bezier(0.06, 0.63, 0, 1);
            padding:37px;
            backface-visibility: hidden;
        }
        .login--active .login--password-container
        {
            transform: perspective(1000px) rotateY(0deg);
            border-bottom-right-radius:4px;
            border-top-right-radius:4px;
        } 
        .login--active .login--username-container
        {
            transform: perspective(1000px) rotateY(0deg);
            border-bottom-left-radius:4px;
            border-top-left-radius:4px;
        }
    </style>
</head>
<body>
    <form id="LoginForm" runat="server" style="position:relative;top:45%;">
        <div class='preload login--container'>
            <div class='login--form'>
                <div class='login--username-container'>
                    <label>Username</label>
                    <asp:TextBox ID="txtUserName" runat="server" Height="38px" />
                    <asp:RequiredFieldValidator ID="rfvUser" ErrorMessage="Please enter Username" ControlToValidate="txtUserName" runat="server" />
                </div>
                <div class='login--password-container'>
                    <label>Password</label>
                    <asp:TextBox ID="txtPWD" runat="server" TextMode="Password" Height="38px"/>
                    <asp:RequiredFieldValidator ID="rfvPWD" runat="server" ControlToValidate="txtPWD" ErrorMessage="Please enter Password"/>
                    <asp:Button ID="btnSubmit" runat="server" Text="Login" onclick="btnSubmit_Click" class="button js-toggle-login login--login-submit " />
                </div>
            </div>
            <div class='login--toggle-container js-toggle-login'>
                <small><b>Hey you,</b></small>
                <div style="font-size:xx-large;"><b>PINCH ME TO GET SERVED...!</b></div><br />
                <small>Have a nice day</small>
            </div>
        </div>
   </form>
</body>
</html>
