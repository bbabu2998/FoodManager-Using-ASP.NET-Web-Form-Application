using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace FoodManagerApplication
{
	public partial class _Default : Page
	{
		SqlConnection con = new SqlConnection("Data Source = MS-10011; Initial Catalog=FoodManager; User ID=sa; Password = password-123");

		protected void Page_Load(object sender, EventArgs e)
		{
			string UserName = Session["UserName"].ToString();
			if(UserName == "phoenix")
			{
				UpdateMenu.Visible = false;
				FoodEntry.Visible = false;
				AddPerson.Visible = false;
			}
			else if(UserName == "admin")
			{
				UpdateMenu.Visible = true;
				FoodEntry.Visible = true;
				AddPerson.Visible = true;
				Report.Visible = true;
			}
		}

		protected void Add_Person(object sender, EventArgs e)
		{
			con.Open();
			int index =0;
			string strName ="";
			try
			{ 
				string strInputName = inputname.Value;
				string strInputEmail = inputEmail.Value;

				SqlCommand sqlcmd = new SqlCommand("select Name from PersonDetails", con);
				SqlDataReader reader = sqlcmd.ExecuteReader();
				while(reader.Read())
				{
					string strDuplicateName = reader[index].ToString();
					if(strDuplicateName == strInputName)
					{
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Person already exists...!');" +
						"window.location ='Default.aspx';", true);
						strName = "Exist";
						break;
					}
				}
				reader.Close();
				if(strName != "Exist")
				{
					if(strInputName != string.Empty && strInputEmail != string.Empty)
					{
						SqlCommand sqlcommand = new SqlCommand("insert into PersonDetails (Name,Email) values('"+strInputName+"','"+strInputEmail+"')", con);
						sqlcommand.ExecuteNonQuery();
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User details saved sucessfully');" +
						"window.location ='Default.aspx';", true);
					}
					else
					{
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter Person details again...!');" +
						"window.location ='Default.aspx';", true);
					}
				}
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the valid Details...!');" +
				"window.location ='Default.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}

		protected void Remove_Person(object sender, EventArgs e)
		{
			try
			{
				string strPersonName = DropDownList1.SelectedItem.Text;
				con.Open();
				if(strPersonName != "Select")
				{
					SqlCommand sqlcommand = new SqlCommand("Delete from PersonDetails where Name = '"+strPersonName+"'", con);
					sqlcommand.ExecuteNonQuery();
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Removed sucessfully');" +
					"window.location ='Default.aspx';", true);
				}
				else
					throw new Exception();
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select or User not Available...!');" +
				"window.location ='Default.aspx';", true);
			}

			finally
			{
				con.Close();
			}
		}
	}
}