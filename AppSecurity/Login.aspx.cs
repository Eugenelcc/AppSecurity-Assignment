using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSecurity
{

    public class MyObject
    {
        public string success { get; set; }
        public List<string> ErrorMessage { get; set; }
    }


    public partial class Login : System.Web.UI.Page
    {
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["AppSec"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                if (Request.Cookies["Email"] != null && Request.Cookies["Pass"] != null)
                {
                    tbEmail_login.Text = Request.Cookies["Email"].Value;
                    tbPassword_login.Text = Request.Cookies["Pass"].Value;
                }
            }
        }

        protected void Btn_login_Click(object sender, EventArgs e)
        {

            if (ValidateCaptcha_v3())
            {

                string pwd = tbPassword_login.Text.ToString().Trim();
                string email = tbEmail_login.Text.ToString().Trim();
                SHA512Managed hashing = new SHA512Managed();
                string dbHash = getDBHash(email);
                string dbSalt = getDBSalt(email);
                try
                {
                    if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                    {
                        string pwdWithSalt = pwd + dbSalt;
                        byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                        string userHash = Convert.ToBase64String(hashWithSalt);
                        if (userHash.Equals(dbHash))
                        {

                            //RememberMe Cookie
                            if (RememberMe.Checked)
                            {
                                Response.Cookies["Email"].Value = tbEmail_login.Text;
                                Response.Cookies["Pass"].Value = tbPassword_login.Text;
                                Response.Cookies["Email"].Expires = DateTime.Now.AddMinutes(1);
                                Response.Cookies["Pass"].Expires = DateTime.Now.AddMinutes(1);

                            }

                            else
                            {
                                Response.Cookies["Email"].Expires = DateTime.Now.AddMinutes(-1);
                                Response.Cookies["Pass"].Expires = DateTime.Now.AddMinutes(-1);
                            }

                            Session["email"] = tbEmail_login.Text;

                            //Creating guid token
                            string guid = Guid.NewGuid().ToString();
                            Session["AuthToken"] = guid;

                            //add cookie
                            Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                            Response.Redirect("Default.aspx", false);

                        }
                        else
                        {
                            Lbl_err.Text = "Email Unauthorize";
                            PanelErrorResult.Visible = true;
                            Response.Redirect("Login.aspx", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { }

            }
        }


        protected string getDBHash(string userid)
        {
            var profile = new Dictionary<string, string>();
            string h = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select password_hash FROM Account WHERE email=@email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@email", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["password_hash"] != null)
                        {
                            if (reader["password_hash"] != DBNull.Value)
                            {
                                h = reader["password_hash"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return h;
        }




        protected string getDBSalt(string userid)
        {
            string s = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select password_salt FROM ACCOUNT WHERE email=@email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@email", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["password_salt"] != null)
                        {
                            if (reader["password_salt"] != DBNull.Value)
                            {
                                s = reader["password_salt"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return s;
        }




        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }
        public bool ValidateCaptcha_v3()
        {
            bool result = true;

            string captchaResponse = Request.Form["g-recaptcha-response"];

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
                ("https://www.google.com/recaptcha/api/siteverify?secret=6LcMxkAaAAAAAFLCkOfGG9oCXuofQ3dzmCOapIqB &response=" + captchaResponse);
            try
            {
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();

                        //lbl_captchaScore.Text = jsonResponse.ToString();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);

                        result = Convert.ToBoolean(jsonObject.success);

                    }
                }
                return result;
            }

            catch (WebException ex)
            {
                throw ex;
            }
        }
    }
}