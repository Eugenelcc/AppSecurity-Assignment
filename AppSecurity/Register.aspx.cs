using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppSecurity
{

    


    public partial class Register : System.Web.UI.Page
    {

        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["AppSec"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
               
            validate();



            string pwd = tbPassword.Text;
            //Generate random "salt"
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];
            //Fills array of bytes with a cryptographically strong sequence of random values.
            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);
            SHA512Managed hashing = new SHA512Managed();
            string pwdWithSalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
            finalHash = Convert.ToBase64String(hashWithSalt);
            RijndaelManaged cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;



            CreateAccount();
             
        }



        public void CreateAccount()
        {

            try
            {
                using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@firstname,@lastname,@email,@creditcard_info,@password_hash,@password_salt,@date_of_birth,@IV,@Key)"))

                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@firstname",tbFirst.Text);
                            cmd.Parameters.AddWithValue("@lastname", tbLast.Text);
                            cmd.Parameters.AddWithValue("@email", Email.Text);
                  
                        
                          
                            cmd.Parameters.AddWithValue("@creditcard_info", encryptData(tbCredit.Text));
                            cmd.Parameters.AddWithValue("@password_hash", finalHash);
                            cmd.Parameters.AddWithValue("@password_salt", salt);
                            cmd.Parameters.AddWithValue("@date_of_birth", Convert.ToDateTime(tbDate.Text));

                            cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                            cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));

                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }



        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0,
               plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }
        protected void validate()
        {
            //implement code for the button event 
            //Extract data from textbook 
            int scores = checkedPassword(tbPassword.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;

                case 2:
                    status = "Weak";
                    break;

                case 3:
                    status = "Medium";
                    break;

                case 4:
                    status = "Good";
                    break;

                case 5:
                    status = "Excellent";
                    break;


                default:
                    break;
            }

            lbl_PwdChecker.Text = "Status: " + status;
            if (scores < 4)
            {
                lbl_PwdChecker.ForeColor = Color.Red;
                return;
            }
            lbl_PwdChecker.ForeColor = Color.Green;
        }

        private int checkedPassword(string password)
        {
            int score = 0;
            // include your implementation here 
            // Score 0 very weak !
            // if length of password is less than 8 chars

            if (password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }
            // Score  = 2  Weak 
            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
            }
            // Score = 3 Medium 
            if (Regex.IsMatch(password, "[A-z]"))
            {
                score++;
            }
            //Score 4 Strong 
            if (Regex.IsMatch(password, "[0-9]"))
            {
                score++;
            }

            //Score 5 Excellent 
            if (Regex.IsMatch(password, "[^A-Za-z0-9]"))
            {
                score++;
            }


            return score;
        }

       
    }


}