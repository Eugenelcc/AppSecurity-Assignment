using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSecurity
{
    public partial class Success : System.Web.UI.Page
    {
        static string email = null;
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["AppSec"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Email"]!= null && Session["AuthToken"]!=null && Request.Cookies["AuthToken"]!=null)
            {
                //Session != Cookie
                if (!Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                {
                    Response.Redirect("Login.aspx", false);
                }

                else
                {
                    email = Session["Email"].ToString();
                    displayUserProfile(email);
                }
            }
            else
            {
                Response.Redirect("Login.aspx", false);
            }


        }


        protected void displayUserProfile(string email)
        {
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "SELECT * FROM Account WHERE email= @email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@email", email);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if(reader["email"] != DBNull.Value)
                        {
                            lbl_email.Text = reader["Email"].ToString();
                        }
                        if (reader["firstname"] != DBNull.Value)
                        {
                            string first = reader["firstname"].ToString();
                            string last = reader["lastname"].ToString();
                            lbl_name.Text = first + " "+last;
                        }
                        if (reader["date_of_birth"] != DBNull.Value)
                        {

                           lbl_dob.Text = reader["date_of_birth"].ToString();

                        }
                    } 
                             
                         
                    
                }
            }//try
            
                catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                connection.Close();
            }
        }





    }
}