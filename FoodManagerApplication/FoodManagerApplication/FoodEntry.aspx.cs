using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodManagerApplication
{
	public partial class Contact : Page
	{
		public SqlConnection con = new SqlConnection("Data Source = MS-10011; Initial Catalog=FoodManager; User ID=sa; Password = password-123");

		protected void Page_Load(object sender, EventArgs e)
		{
			if(DateValue.Value == "" ) DateValue.Value = DateTime.Now.ToString("yyyy-MM-dd");
			if(ModalID_UpdateDate.Value == "") ModalID_UpdateDate.Value = DateTime.Now.ToString("yyyy-MM-dd");
		}
		protected void AddFoodEntry_Onclick(object sender, EventArgs e)
		{
			try
			{
				if(GridViewID_FoodEntry.Rows.Count == 0)
				{
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found');" + "window.location ='FoodEntry.aspx';", true);
				}

				con.Open();
				string strFoodName = "", strLabelName = "", strName = "";
				int nCount = 0, SuccessCount = 0;
				DateTime dtSelectedDate = Convert.ToDateTime(DateValue.Value);
				string strSelectedDate = dtSelectedDate.ToString("yyyy-MM-dd");

				for(int index = 0; index < GridViewID_FoodEntry.Rows.Count; index++)
				{
					Label TextBoxID_PersonName = (Label) GridViewID_FoodEntry.Rows[index].Cells[0].FindControl("LabelID_PersonName");
					strLabelName = TextBoxID_PersonName.Text;
					DropDownList DropDownListID_FoodName = (DropDownList) GridViewID_FoodEntry.Rows[index].Cells[0].FindControl("DropDownListID_FoodName");
					strFoodName = DropDownListID_FoodName.Text;
					strName = string.Empty;

					SqlCommand sqlcmd = new SqlCommand("SELECT EntryDate, Period from FoodEntry Where Name = '"+strLabelName+"' and EntryDate = '"+strSelectedDate+"' ",con);
					SqlDataReader reader = sqlcmd.ExecuteReader();

					while(reader.Read())
					{
						string Period = DropDownListID_Period.Text;
						string Date = DateValue.Value;
						DateTime startDate = Convert.ToDateTime(reader["EntryDate"]);
						string strDuplicateDate = startDate.ToString("yyyy-MM-dd");
						string strDuplicatePeriod = reader["Period"].ToString();

						if(strDuplicateDate == Date && strDuplicatePeriod == Period)
						{
							nCount++;
							strName = "Exist";
							break;
						}
					}
					reader.Close();

					if(strName != "Exist")
					{
						SqlCommand sqlcommand = new SqlCommand("SELECT CONVERT(int,Amount) FROM Amount Where Item =  + '" + strFoodName + "'", con);
						SqlDataReader sqlreader = sqlcommand.ExecuteReader();
						SqlCommand sqlcmdAddValue = new SqlCommand("insert into FoodEntry (EntryDate,Name,Period,Amount)"+" values (@DateValue,@Name,@Period,@Amount)", con);
						
						sqlcmdAddValue.Parameters.AddWithValue("@DateValue", DateValue.Value);
						sqlcmdAddValue.Parameters.AddWithValue("@Name", strLabelName);
						sqlcmdAddValue.Parameters.AddWithValue("@Period", DropDownListID_Period.SelectedItem.Text);

						sqlreader.Read();
						sqlcmdAddValue.Parameters.AddWithValue("@Amount", sqlreader[0]);
						sqlreader.Close();

						sqlcmdAddValue.ExecuteNonQuery();
						sqlcommand.ExecuteNonQuery();

						SuccessCount++;
					}
				}

				if(nCount == GridViewID_FoodEntry.Rows.Count)
				{
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Entry already exists..!');" +
					"window.location ='FoodEntry.aspx';", true);
				}
				else if(SuccessCount == GridViewID_FoodEntry.Rows.Count)
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Added succefully');" + "window.location ='FoodEntry.aspx';", true);
				else if(SuccessCount + nCount == GridViewID_FoodEntry.Rows.Count)
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Entry already exists and Remaining Entry added succesfully');" +
					"window.location ='FoodEntry.aspx';", true);
			}
			catch(Exception ex)
			{
				if("String was not recognized as a valid DateTime." == ex.Message)
				{
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the valid Date');" + "window.location ='FoodEntry.aspx';", true);
				}
				else
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the valid Item');" + "window.location ='FoodEntry.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}

		protected void Update_Onclick(object sender, EventArgs e)
		{
			try
			{
				con.Open();
				string strModalName = DropDownListID_PersonName.Text;
				string strModalPeriod = DropDownListID_UpdatePeriod.Text;
				string strModalDate = ModalID_UpdateDate.Value;
				string strModalItem = DropDownListID_UpdateFood.Text;

				SqlCommand sqlcommand = new SqlCommand("SELECT CONVERT(int,Amount) FROM Amount Where Item =  + '" + strModalItem + "'", con);
				SqlDataReader sqlreader = sqlcommand.ExecuteReader();

				SqlCommand cmd = new SqlCommand("Update FoodEntry SET EntryDate=@Date,Name=@Name,Period=@Period,Amount=@Amount where EntryDate='"+strModalDate+"' and Name='"+strModalName+"' and Period ='"+strModalPeriod+"' ", con);
				cmd.Parameters.AddWithValue("@Date", strModalDate);
				cmd.Parameters.AddWithValue("@Name", strModalName);
				cmd.Parameters.AddWithValue("@Period", strModalPeriod);

				while(sqlreader.Read())
				{
					cmd.Parameters.AddWithValue("@Amount", sqlreader[0]);
				}

				sqlreader.Close();
				cmd.ExecuteNonQuery();
				sqlcommand.ExecuteNonQuery();
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Updated succefully');" + "window.location ='FoodEntry.aspx';", true);
			}
			catch(Exception ex)
			{
				if("String was not recognized as a valid DateTime." == ex.Message)
				{
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the valid Date');" + "window.location ='FoodEntry.aspx';", true);
				}
			}
			finally
			{
				con.Close();
			}
		}

		protected void AutoSelectFoodItem(object sender, EventArgs e)
		{
			try
			{
				con.Open();
				string strFoodName  = DropDownListID_Period.Text;
				DayOfWeek day = Convert.ToDateTime(DateValue.Value).DayOfWeek;
				SqlCommand sqlcommand = new SqlCommand("SELECT "+strFoodName+" from Menu where Days = '"+day+"' ", con);

				SqlDataSource sqlDS = new SqlDataSource();
				sqlDS.ConnectionString = con.ToString();
				SqlCommand sqlCommand_ListItem = new SqlCommand("SELECT Item FROM Amount", con);
				SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand_ListItem);

				DataSet dt = new DataSet();
				sqlDA.Fill(dt);

				for(int i = 0; i < GridViewID_FoodEntry.Rows.Count; i++)
				{
					var ddlDropDownListFillItem = GridViewID_FoodEntry.Rows[i].FindControl("DropDownListID_FoodName") as DropDownList;
					ddlDropDownListFillItem.DataSource = dt;
					ddlDropDownListFillItem.DataTextField = "Item";
					ddlDropDownListFillItem.DataBind();
					ddlDropDownListFillItem.Items.Insert(i, new ListItem(ddlDropDownListFillItem.SelectedItem.Value));
				}

				SqlDataReader sqlreader = sqlcommand.ExecuteReader();
				sqlreader.Read();
				string Dish = sqlreader[0].ToString();

				for(int i = 0; i < GridViewID_FoodEntry.Rows.Count; i++)
				{
					DropDownList ddlDropdDownListItem = GridViewID_FoodEntry.Rows[i].FindControl("DropDownListID_FoodName") as DropDownList;
					ddlDropdDownListItem.SelectedItem.Text = Dish;
				}
				sqlreader.Close();
			}
			catch(Exception ex)
			{
					if("String was not recognized as a valid DateTime." == ex.Message)
					{
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the valid Date');" + "window.location ='FoodEntry.aspx';", true);
					}
			}
			finally
			{
				con.Close();
			}
		}
	}
}