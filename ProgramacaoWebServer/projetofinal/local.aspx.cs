using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace projetofinal
{
    public partial class local : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verifica se a página está sendo carregada pela primeira vez
            if (!IsPostBack)
            {
                // Obtém o ID do local a partir da query string
                string localId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(localId))
                {
                    CarregarDadosDoLocal(localId);
                    CarregarFotosDoLocal(localId);
                }
                else
                {
                    // Se o ID não estiver presente, exibe uma mensagem de erro ou redireciona
                    Response.Write("<script>alert('ID do local não fornecido.');</script>");
                }
            }
        }

        private void CarregarDadosDoLocal(string localId)
        {
            // String de conexão ao banco de dados
            string connectionString = @"data source=.\sqlexpress; initial catalog=Locais; integrated security=true;";

            // Query para obter os dados do local
            string query = @"
                SELECT L.Nome, L.Descricao, L.Localidade, C.Nome AS 'Concelho', D.Nome AS 'Distrito'
                FROM Local L
                JOIN Concelho C ON L.Concelho = C.Id
                JOIN Distrito D ON C.Distrito = D.Id
                WHERE L.Id = @id";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Passa o ID como parâmetro para evitar SQL Injection
                    command.Parameters.AddWithValue("@id", localId);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        // Atualiza os controles com os dados do local
                        nomeLocal.Text = reader["Nome"].ToString();
                        descricao.Text = reader["Descricao"].ToString();
                        localizacao.Text = $"{reader["Localidade"]} | {reader["Concelho"]} | {reader["Distrito"]}";
                    }
                    else
                    {
                        Response.Write("<script>alert('Local não encontrado.');</script>");
                    }

                    reader.Close();
                }
            }
        }

        private void CarregarFotosDoLocal(string localId)
        {
            // String de conexão ao banco de dados
            string connectionString = @"data source=.\sqlexpress; initial catalog=Locais; integrated security=true;";

            // Query para obter as fotos do local
            string query = "SELECT Id, Legenda, Ficheiro FROM Foto WHERE Local = @id";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Passa o ID como parâmetro
                    command.Parameters.AddWithValue("@id", localId);

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable fotos = new DataTable();
                    adapter.Fill(fotos);

                    // Associa as fotos ao Repeater
                    rptFotos.DataSource = fotos;
                    rptFotos.DataBind();
                }
            }
        }
        
    }
}