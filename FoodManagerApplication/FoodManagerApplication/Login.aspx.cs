using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace FoodManagerApplication
{
	public partial class Login : System.Web.UI.Page
	{
		SqlConnection con = new SqlConnection("Data Source = MS-10011; Initial Catalog=FoodManager; User ID=sa; Password = password-123");
		protected void Page_Load(object sender, EventArgs e)
		{
			
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			try
			{
				con.Open();
				SqlCommand sqlcommand = new SqlCommand("select * from UserInformation where UserName =@username and Password=@password", con);
				sqlcommand.Parameters.AddWithValue("@username", txtUserName.Text);
				sqlcommand.Parameters.AddWithValue("@password", txtPWD.Text);
				SqlDataAdapter sqlDA = new SqlDataAdapter(sqlcommand);
				DataTable dt = new DataTable();
				sqlDA.Fill(dt);
				if(dt.Rows.Count > 0)
				{
					Session["UserName"] = txtUserName.Text;
					Response.Redirect("Default.aspx");
				}
				else
				{
					ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Invalid Username and Password')</script>");
				}
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Username and Password...!');" +
				"window.location ='Login.aspx';", true);
			}

			finally
			{
				con.Close();
			}
		}
	}
}