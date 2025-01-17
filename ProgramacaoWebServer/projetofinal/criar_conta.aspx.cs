using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace projetofinal.Utilizadores
{
    public partial class criar_conta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string data = DateTime.Now.AddYears(-18).ToShortDateString();
                cvDataNascimento.ErrorMessage = "Defina data igual ou anterior a " + data;
                cvDataNascimento.Type = ValidationDataType.Date;
                cvDataNascimento.Operator = ValidationCompareOperator.LessThanEqual;
                cvDataNascimento.ValueToCompare = data;
            }
        }

        protected void buttonCriarConta_Click(object sender, EventArgs e)
        {
            //Criar conta - Membership
            Membership.CreateUser(textUtilizador.Text, textPass.Text, textEmail.Text);
            //obter o UserID
            MembershipUser user = Membership.GetUser(textUtilizador.Text);
            object user_id = user.ProviderUserKey;
            //Criar Utilizador (Locais.Utilizador)
            SqlConnection connection = new SqlConnection(
            @"data source=.\Sqlexpress; initial catalog = Locais; integrated security = true;");

            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "INSERT Utilizador(Id, Nome, Email, DataNascimento) " +
             "VALUES(@nome, @email, @data, @user_id)";
            command.Parameters.AddWithValue("@nome", textNome.Text);
            command.Parameters.AddWithValue("@email", textEmail.Text);
            command.Parameters.AddWithValue("@data", DateTime.Parse(textDataNasc.Text));
            command.Parameters.AddWithValue("@user_id", user_id.ToString());
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            Response.Redirect("login.aspx");
        }
    }
}