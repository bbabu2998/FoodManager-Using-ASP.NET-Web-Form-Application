using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using iTextSharp.text.html.simpleparser;

namespace FoodManagerApplication
{
	public partial class Report : Page
	{
		public SqlConnection con = new SqlConnection("Data Source = MS-10011; Initial Catalog=FoodManager; User ID=sa; Password = password-123");

		protected void Page_Load(object sender, EventArgs e)
		{
			if(start.Value=="" && end.Value =="")
			{
				start.Value = DateTime.Now.ToString("yyyy-MM-dd");
				end.Value = DateTime.Now.ToString("yyyy-MM-dd");
			}
			if(month.Value == "") month.Value = DateTime.Now.ToString("yyyy-MM");

			LabelID_TotalAmount.Visible = false;
			SendPeriodReport.Visible = false;
			string UserName = Session["UserName"].ToString();
			if(UserName == "phoenix")
			{
				SendMonthlyReport.Visible = false;
			}
			else if(UserName == "admin")
			{
				SendMonthlyReport.Visible = true;
			}
		}

		protected void OnClick_getReport(object sender, EventArgs e)
		{
			try
			{
				string strStartDate = start.Value;
				string strEndDate = end.Value;
				string strResultName = DropDownListID_PersonName.Text;
				con.Open();

				if(strResultName == string.Empty)
				{
					SqlCommand sqlcommand = new SqlCommand("SELECT EntryDate,Name,Period,Amount from FoodEntry Where EntryDate between '"+strStartDate+"' and '"+strEndDate+"' ", con);
					SqlDataAdapter sqlDA = new SqlDataAdapter(sqlcommand);
					DataSet ds = new DataSet();
					sqlDA.Fill(ds, "FoodEntry");

					DataTable dtFoodEntry = new DataTable();
					dtFoodEntry = ds.Tables["FoodEntry"];

					DataTable dtCloneTable = dtFoodEntry.Clone();
					int nCount = 0;

					foreach(DataRow dr in dtFoodEntry.Rows)
					{
						object[] objData = dr.ItemArray;
						for(int i = 0; i < objData.Length; i++)
						{
							DateTime date;
							var val = objData[i].ToString();
							if(DateTime.TryParse(val, out date))
							{
								date = Convert.ToDateTime(val);
								string strDate = date.ToString("dd/MM/yyyy");
								val = strDate;
								if(nCount == 0)
								{
									dtCloneTable.Columns[i].DataType = typeof(string);
								}
								objData[i] = val.ToString();
								dtCloneTable.Rows.Add(objData);
							}
						}
					}
					con.Close();

					if(ds.Tables["FoodEntry"].Rows.Count > 0)
					{
						GridViewID_Report.DataSource = dtCloneTable;
						GridViewID_Report.DataBind();

						con.Open();
						SqlCommand sqlcmd = new SqlCommand("Select SUM(Amount) from FoodEntry where EntryDate between '"+strStartDate+"' and '"+strEndDate+"' ", con);
						SqlDataReader sqlreader = sqlcmd.ExecuteReader();
						sqlreader.Read();
						LabelID_TotalAmount.Text = "OverallTotal = ₹" + sqlreader[0].ToString() + "  ";
						LabelID_TotalAmount.Visible = true;
						string strUserName = Session["UserName"].ToString();
						if(strUserName == "phoenix")
						{
							SendPeriodReport.Visible = false;
							SendMonthlyReport.Visible = false;
						}
						else if(strUserName == "admin")
						{
							SendPeriodReport.Visible = true;
							SendMonthlyReport.Visible = false;
						}
						con.Close();
					}
				}
				else
				{
					SqlCommand sqlCommand = new SqlCommand("SELECT EntryDate,Name,Period,Amount from FoodEntry Where Name = '"+strResultName+"' and EntryDate between '"+strStartDate+"' and '"+strEndDate+"' ", con);
					SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
					DataSet ds = new DataSet();
					sqlDA.Fill(ds, "FoodEntry");
					DataTable dtFoodEntry = new DataTable();
					dtFoodEntry = ds.Tables["FoodEntry"];

					DataTable dtCloneTable = dtFoodEntry.Clone();
					int nCount = 0;
					foreach(DataRow dr in dtFoodEntry.Rows)
					{
						object[] objData = dr.ItemArray;
						for(int i = 0; i < objData.Length; i++)
						{
							DateTime date;
							var val = objData[i].ToString();
							if(DateTime.TryParse(val, out date))
							{
								date = Convert.ToDateTime(val);
								string strDate = date.ToString("dd/MM/yyyy");
								val = strDate;
								if(nCount == 0)
								{
									dtCloneTable.Columns[i].DataType = typeof(string);
								}
								objData[i] = val.ToString();
								dtCloneTable.Rows.Add(objData);
							}
						}
					}
					con.Close();

					if(ds.Tables["FoodEntry"].Rows.Count > 0)
					{
						GridViewID_Report.DataSource = dtCloneTable;
						GridViewID_Report.DataBind();
						con.Open();
						SqlCommand sqlCmd = new SqlCommand("Select SUM(Amount) from FoodEntry where Name = '"+strResultName+"' and EntryDate between '"+strStartDate+"' and '"+strEndDate+"'", con);
						SqlDataReader sqlReader = sqlCmd.ExecuteReader();
						sqlReader.Read();
						LabelID_TotalAmount.Text = sqlReader[0].ToString();
						LabelID_TotalAmount.Text = " " + strResultName + "'s Total = ₹" + sqlReader[0].ToString() + " ";
						LabelID_TotalAmount.Visible = true;
						string steUserName = Session["UserName"].ToString();
						if(steUserName == "phoenix")
						{
							SendPeriodReport.Visible = false;
							SendMonthlyReport.Visible = false;
						}
						else if(steUserName == "admin")
						{
							SendPeriodReport.Visible = true;
							SendMonthlyReport.Visible = false;
						}
						SendMonthlyReport.Visible = false;
					}
					else
					{
						GridViewID_Report.Visible = false;
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter Valid Details');" + "window.location ='Report.aspx';", true);
					}
				}
			}
			catch(Exception ex)
			{
				if("String was not recognized as a valid DateTime." == ex.Message)
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the valid Date');" + "window.location ='Report.aspx';", true);
				else
					ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the name');" + "window.location ='Report.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}

		protected void Onclick_SendPeriodReport(object sender, EventArgs e)
		{
			try
			{
				string strStartDate = Convert.ToDateTime(start.Value).ToShortDateString();
				string strEndDate = Convert.ToDateTime(end.Value).ToShortDateString();
				string strResultName = DropDownListID_PersonName.Text;
				string strMonth = "";
				
				if(strResultName == "")
				{
					con.Open();
					SqlCommand sqlcommand = new SqlCommand("select * from PersonDetails",con);
					SqlDataReader sqlreader = sqlcommand.ExecuteReader();
					int nCount = sqlreader.Cast<object>().Count();
					sqlreader.Close();

					sqlreader = sqlcommand.ExecuteReader();
					string[] strNames = new string[nCount];
					string[] strEmails = new string[nCount];

					int nIndex = 0;
					while(sqlreader.Read())
					{
						strNames[nIndex] = sqlreader["Name"].ToString();
						strEmails[nIndex] = sqlreader["Email"].ToString();
						nIndex++;
					}
					sqlreader.Close();

					for(nIndex = 0; nIndex < nCount; nIndex++)
					{
						sentMail(strNames[nIndex], strEmails[nIndex], strStartDate, strEndDate, strMonth);
					}
				}
				else
				{
					con.Open();
					SqlCommand sqlcmd = new SqlCommand("select * from PersonDetails where Name = '"+strResultName+"'",con);
					SqlDataReader sqlReader = sqlcmd.ExecuteReader();
					sqlReader.Read();
					sentMail(sqlReader["Name"].ToString(), sqlReader["Email"].ToString(), strStartDate, strEndDate, strMonth);
					sqlReader.Close();
				}
			}
			catch
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the Valid Date');" + "window.location ='Report.aspx';", true);

			}
			finally
			{
				con.Close();
			}
		}

		protected void OnClick_sendMonthlyReport(object sender, EventArgs e)
		{
			try
			{
				string strResultName = DropDownListName.Text;
				DateTime Today = Convert.ToDateTime(month.Value).Date;
				DateTime Month = new DateTime(Today.Year, Today.Month, 1);
				DateTime dateStartDate = Month.AddMonths(0);
				DateTime dateEndDate = Month.AddMonths(1).AddDays(-1);
				string strStartDate = dateStartDate.ToShortDateString();
				string strEndDate = dateEndDate.ToShortDateString();
				string strMonth = new DateTime(dateEndDate.Year, dateEndDate.Month, 1).ToString("MMMM");

				if(strResultName == "")
				{
					con.Open();
					SqlCommand sqlcommand = new SqlCommand("select * from PersonDetails",con);
					SqlDataReader sqlreader = sqlcommand.ExecuteReader();
					int nCount = sqlreader.Cast<object>().Count();
					sqlreader.Close();

					sqlreader = sqlcommand.ExecuteReader();
					string[] strNames = new string[nCount];
					string[] strEmails = new string[nCount];

					int nIndex = 0;
					while(sqlreader.Read())
					{
						strNames[nIndex] = sqlreader["Name"].ToString();
						strEmails[nIndex] = sqlreader["Email"].ToString();
						nIndex++;
					}
					sqlreader.Close();

					for(nIndex = 0; nIndex < nCount; nIndex++)
					{
						sentMail(strNames[nIndex], strEmails[nIndex], strStartDate, strEndDate, strMonth);
					}
				}
				else
				{
					con.Open();
					SqlCommand sqlCommnad = new SqlCommand("select * from PersonDetails where Name = '"+strResultName+"'",con);
					SqlDataReader sqlreader = sqlCommnad.ExecuteReader();
					sqlreader.Read();
					sentMail(sqlreader["Name"].ToString(), sqlreader["Email"].ToString(), strStartDate, strEndDate, strMonth);
					sqlreader.Close();
				}
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the Valid Date');" + "window.location ='Report.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}

		public void sentMail(string strName, string strEmail, string strStartDate, string strEndDate, string strMonth)
		{
			try
			{
				SqlConnection con = new SqlConnection("Data Source = MS-10011; Initial Catalog=FoodManager; User ID=sa; Password = password-123");
				con.Open();
				MailMessage msg = new MailMessage();
				msg.From = new MailAddress("Your Mail ID..");

				SqlCommand sqlcommand = new SqlCommand("Select SUM(Amount) from FoodEntry where Name = '"+strName+"' and EntryDate between convert(Date,'"+strStartDate+"') and convert(Date,'"+strEndDate+"')   ", con);
				SqlDataReader sqlreader = sqlcommand.ExecuteReader();

				sqlreader.Read();
				msg.To.Add(strEmail);

				if(strEmail == "Total Report has to be send Email-ID") SendBillDetails_Mail(strEmail, strStartDate, strEndDate, strMonth);
				//if(strEmail == "santhoshkumar.oxford@gmail.com") SendBillDetails_Mail(strEmail, strStartDate, strEndDate, strMonth);
				int nAmount = Convert.ToInt32(sqlreader[0]);
				sqlreader.Close();

				StringBuilder sbtxt = new StringBuilder();
				sbtxt.Append("<table width='100%' cellspacing='1' cellpadding='2'>");
				sbtxt.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>Payment Amount</b></td></tr><br/>");
				sbtxt.Append("<tr><td colspan = '1' ><b>Name : </b>");
				sbtxt.Append(strName);
				sbtxt.Append("</td><td><b>Date : </b>");
				sbtxt.Append(DateTime.Now.ToString("MM/dd/yyyy"));
				sbtxt.Append("</td></tr>");
				sbtxt.Append("<tr><td colspan = '1'><b>From : </b> ");
				sbtxt.Append(strStartDate);
				sbtxt.Append("</td><td><b>To   : </b>");
				sbtxt.Append(strEndDate);
				sbtxt.Append("</td></tr>");
				sbtxt.Append("<td><h3> Amount : Rs." + nAmount + "</h3></td>");
				sbtxt.Append("</table>");
				sbtxt.Append("<br />");
				sbtxt.Append("<p align='center'><b>Summary</b></p>");
				msg.Body = sbtxt.ToString();

				SqlCommand sqlCommnad = new SqlCommand("select EntryDate,Period,Amount from FoodEntry where Name = '"+strName+"' and EntryDate between '"+strStartDate+"' and '"+strEndDate+"'",con);
				SqlDataReader sqlReader = sqlCommnad.ExecuteReader();
				StringBuilder sbpdf = new StringBuilder();
				sbpdf.Append("<div style='background-color: #18B5F0'><h3 align='center'><b>Payment Amount</b></h3></div><br />");
				sbpdf.Append("<table width='100%' cellspacing='1' cellpadding='4px'>");
				sbpdf.Append("<tr><td colspan = '1' ><b>Name : </b>");
				sbpdf.Append(strName);
				sbpdf.Append("</td><td><b>Date : </b>");
				sbpdf.Append(DateTime.Now.ToString("MM/dd/yyyy"));
				sbpdf.Append("</td></tr>");
				sbpdf.Append("<tr><td colspan = '1'><b>From : </b> ");
				sbpdf.Append(strStartDate);
				sbpdf.Append("</td><td><b>To   : </b>");
				sbpdf.Append(strEndDate);
				sbpdf.Append("</td></tr><br />");
				sbpdf.Append("<tr><td><b>Amount : Rs." + nAmount + "</b></td></tr>");
				sbpdf.Append("</table>");
				sbpdf.Append("<table border='1px solid black' border-collapse='collapse' cellpadding='4px' width='100%'><tr>");
				sbpdf.Append("<td align='center' style='background-color: #18B5F0'><b> Date </b></td>");
				sbpdf.Append("<td align='center' style='background-color: #18B5F0'><b> Period </b> </td>");
				sbpdf.Append("<td align='center' style='background-color: #18B5F0'><b> Amount </b> </td>");
				sbpdf.Append("</tr>");

				while(sqlReader.Read())
				{
					DateTime dateTime = Convert.ToDateTime(sqlReader[0].ToString());
					sbpdf.Append("<tr>");
					sbpdf.Append("<td align='center'>");
					sbpdf.Append(dateTime.ToString("dd-MM-yyyy"));
					sbpdf.Append("</td >");
					sbpdf.Append("<td align='center'>");
					sbpdf.Append(sqlReader[1]);
					sbpdf.Append("</td>");
					sbpdf.Append("<td align='center'>");
					sbpdf.Append(sqlReader[2]);
					sbpdf.Append("</td>");
					sbpdf.Append("</tr>");
				}
				sbpdf.Append("</table>");
				sqlReader.Close();

				using(StringWriter sw = new StringWriter(sbpdf))
				{
					using(HtmlTextWriter hw = new HtmlTextWriter(sw))
					{
						MemoryStream memoryStream = new MemoryStream();
						StringReader sr = new StringReader(sw.ToString());
						Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
						PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
						pdfDoc.Open();
						XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
						pdfDoc.Close();
						byte[] bytes = memoryStream.ToArray();
						memoryStream.Close();

						msg.IsBodyHtml = true;
						msg.Subject = "U can Enter U r Subject";
						DateTime CurrentStartDate = Convert.ToDateTime(strStartDate);
						DateTime CurrentEndDate = Convert.ToDateTime(strEndDate);
						if(new DateTime(CurrentStartDate.Year, CurrentStartDate.Month, 1).ToString("MMMM") == new DateTime(CurrentEndDate.Year, CurrentEndDate.Month, 1).ToString("MMMM"))
							msg.Attachments.Add(new Attachment(new MemoryStream(bytes), "FoodBill-" + new DateTime(CurrentStartDate.Year, CurrentStartDate.Month, 1).ToString("MMMM") + "PDF.pdf"));
						else
							msg.Attachments.Add(new Attachment(new MemoryStream(bytes), "FoodBill(" + new DateTime(CurrentStartDate.Year, CurrentStartDate.Month, 1).ToString("MMMM") + "-" + new DateTime(CurrentEndDate.Year, CurrentEndDate.Month, 1).ToString("MMMM") + ")PDF.pdf"));
						SmtpClient smt = new SmtpClient("smtp.gmail.com");
						smt.Port = 587;
						smt.Credentials = new NetworkCredential("Your Mail ID..", "Your Mail ID.. password");
						smt.EnableSsl = true;
						smt.Send(msg);

						string script = "<script>alert('Mail Sent Successfully');self.close();</script>";
						this.ClientScript.RegisterClientScriptBlock(this.GetType(), "sendMail", script);
						ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "window.location ='Report.aspx';", true);
					}
				}
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the Valid Date');" + "window.location ='Report.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}

		public void SendBillDetails_Mail(string strEmail, string strStartDate, string strEndDate, string strMonth)
		{
			try
			{
				SqlConnection con = new SqlConnection("Data Source = MS-10011; Initial Catalog=FoodManager; User ID=sa; Password = password-123");
				con.Open();
				MailMessage msg = new MailMessage();
				msg.From = new MailAddress("Your Mail ID..");
				msg.To.Add(strEmail);

				SqlCommand sqlCommand = new SqlCommand("select SUM(Amount) AS Amount from FoodEntry", con);
				SqlDataReader sqlReader = sqlCommand.ExecuteReader();
				sqlReader.Read();
				int nAmount = Convert.ToInt32(sqlReader[0]);
				sqlReader.Close();

				StringBuilder sbtxt = new StringBuilder();
				sbtxt.Append("<table width='100%' cellspacing='1' cellpadding='5px'>");
				sbtxt.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>"+ strMonth + " Month's Payment Amount</b></td></tr><br/>");
				sbtxt.Append("<tr><td align='center' colspan = '2'><b>Total Amount To Be Paid : Rs." + nAmount + "</b></td></tr>");
				sbtxt.Append("</table>");
				sbtxt.Append("<br />");
				sbtxt.Append("<table border='1px solid black' border-collapse='collapse' cellpadding='4px' width='100%'><tr>");
				sbtxt.Append("<td align='center' style='background-color: #18B5F0'><b> Name </b></td>");
				sbtxt.Append("<td align='center' style='background-color: #18B5F0'><b> Amount </b> </td>");

				SqlCommand sqlcommand = new SqlCommand("select DISTINCT(Name),SUM(Amount) AS Amount from FoodEntry Group By Name", con);
				SqlDataReader sqlreader = sqlcommand.ExecuteReader();
				while(sqlreader.Read())
				{
					sbtxt.Append("<tr>");
					sbtxt.Append("<td align='center'>");
					sbtxt.Append(sqlreader[0]);
					sbtxt.Append("</td>");
					sbtxt.Append("<td align='center'>Rs.");
					sbtxt.Append(sqlreader[1]);
					sbtxt.Append("</td>");
					sbtxt.Append("</tr>");
				}
				sbtxt.Append("<tr><td align='center' ><b>Total Amount</b> </td>");
				sbtxt.Append("<td align='center' ><b>Rs."+nAmount+"</b></td></tr>");
				sbtxt.Append("</table>");
				sqlreader.Close();

				msg.Body = sbtxt.ToString();
				MemoryStream memoryStream = new MemoryStream();
				StringReader sr = new StringReader(sbtxt.ToString());
				byte[] bytes = memoryStream.ToArray();
				memoryStream.Close();

				msg.IsBodyHtml = true;
				msg.Subject = "M&S GuestHouse " + strMonth + " Month's Food Bill";
				SmtpClient smt = new SmtpClient("smtp.gmail.com");
				smt.Port = 587;
				smt.Credentials = new NetworkCredential("Your Mail ID..", "Your Mail ID.. password");
				smt.EnableSsl = true;
				smt.Send(msg);
			}
			catch(Exception ex)
			{
				ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Enter the Valid Date');" + "window.location ='Report.aspx';", true);
			}
			finally
			{
				con.Close();
			}
		}

		protected void OnPaging(object sender, GridViewPageEventArgs e)
		{
			OnClick_getReport(sender, e);
			GridViewID_Report.Visible = true;
			GridViewID_Report.PageIndex = e.NewPageIndex;
			GridViewID_Report.DataBind();
		}
	}
}
