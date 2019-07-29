using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace FoodManagerApplication
{
	public partial class About : Page
	{
		SqlConnection con = new SqlConnection("Data Source = MS-10011; Initial Catalog=FoodManager; User ID=sa; Password = password-123");

		protected void Page_Load(object sender, EventArgs e)
		{
			
		}

		protected void AddFood_Onclick(object sender, EventArgs e)
		{
			con.Open();
			int nIndex = 0;
			string strFoodName = "";
			try
			{
				string strInputName = inputItem.Value;
				int nAmount = Int32.Parse(inputAmount.Value);

				SqlCommand sqlcmd = new SqlCommand("select Item from Amount", con);
				SqlDataReader sqlreader = sqlcmd.ExecuteReader();
				while(sqlreader.Read())
				{
					string strDuplicateFoodName = sqlreader[nIndex].ToString();
					if(strDuplicateFoodName == strInputName)
					{
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Item already exists...!');" +
						"window.location ='MenuPage.aspx';", true);
						strFoodName = "Exist";
						break;
					}
				}
				sqlreader.Close();
				if(strFoodName != "Exist")
				{
					if(strInputName != string.Empty && nAmount >= 0)
					{
						SqlCommand sqlcommand = new SqlCommand("insert into Amount (Item,Amount) values('"+strInputName+"','"+nAmount+"')", con);
						sqlcommand.ExecuteNonQuery();
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Food details saved sucessfully');" +
						"window.location ='MenuPage.aspx';", true);
					}
					else
					{
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter Food Name and Amount Correctly...!');" +
						"window.location ='MenuPage.aspx';", true);
					}
				}
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter Food Details again...!');" +
			    "window.location ='MenuPage.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}

		protected void RemoveFood_Onclick(object sender, EventArgs e)
		{
			try
			{
				string strFoodName = DropDownListID_Item.SelectedItem.Text;
				con.Open();
				if(strFoodName != "Select")
				{
					SqlCommand sqlcommand = new SqlCommand("Delete from Amount where Item = '"+strFoodName+"'", con);
					sqlcommand.ExecuteNonQuery();
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Removed sucessfully');" +
				    "window.location ='MenuPage.aspx';", true);
				}
				else
					throw new Exception();
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select or Food not Available...!');" +
				"window.location ='Default.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}
	}
}