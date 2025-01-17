using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace projetofinal
{
    public partial class pesquisa : System.Web.UI.Page
    {
        // Defina a connectionString aqui ou carregue do Web.config
        private string connectionString = @"Data Source=.\SqlExpress;Initial Catalog=Locais;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDistritos();
            }
        }

        // Método para carregar os distritos no DropDownList
        void LoadDistritos()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT Id, Nome FROM Distrito", conn);
                SqlDataReader reader = cmd.ExecuteReader();

                listDistrito.DataSource = reader;
                listDistrito.DataTextField = "Nome";
                listDistrito.DataValueField = "Id";
                listDistrito.DataBind();

                // Adicionar item inicial
                listDistrito.Items.Insert(0, new ListItem("Selecione um Distrito", "0"));
            }
        }

        // Método para carregar os conselhos baseados no distrito selecionado
        private void LoadConselhos(int distritoId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT Id, Nome FROM Concelho WHERE Distrito = @DistritoId", conn);
                cmd.Parameters.AddWithValue("@DistritoId", distritoId);

                SqlDataReader reader = cmd.ExecuteReader();
                listConcelho.DataSource = reader;
                listConcelho.DataTextField = "Nome";
                listConcelho.DataValueField = "Id";
                listConcelho.DataBind();

                // Adicionar item inicial
                listConcelho.Items.Insert(0, new ListItem("Selecione um Concelho", "0"));
            }
        }

        // Evento para carregar conselhos ao selecionar um distrito
        protected void listDistrito_SelectedIndexChanged(object sender, EventArgs e)
        {
            int distritoId;
            if (int.TryParse(listDistrito.SelectedValue, out distritoId) && distritoId > 0)
            {
                LoadConselhos(distritoId);
            }
            else
            {
                listConcelho.Items.Clear();
                listConcelho.Items.Insert(0, new ListItem("Selecione um Concelho", "0"));
            }
        }

        protected void linkPrimeira_Click(object sender, EventArgs e)
        {

        }

        protected void linkAnterior_Click(object sender, EventArgs e)
        {

        }

        protected void linkSeguinte_Click(object sender, EventArgs e)
        {

        }

        protected void linkUltima_Click(object sender, EventArgs e)
        {

        }


        protected void buttonPesquisar_Click(object sender, EventArgs e)
        {
            //definição da query que seleciona os dados do local
            string command = "SELECT L.Id AS LocalID, L.Nome AS NomeLocal, C.Nome AS Concelho, " +
            "D.Nome AS Distrito, F.Ficheiro AS PrimeiraFoto " +
            "FROM Local L INNER JOIN Concelho C ON L.Concelho = C.Id " +
            "INNER JOIN Distrito D ON C.Distrito = D.Id " +
            "LEFT JOIN (SELECT Local, MIN(Id) AS PrimeiraFotoId FROM Foto " +
            "GROUP BY Local) FP ON L.Id = FP.Local " +
            "LEFT JOIN Foto F ON FP.PrimeiraFotoId = F.Id ";
            bool condicao = false;
            //a cláusula WHERE é adicionada à query se o nome foi definido, ou se foi
            //selecionado um distrito ou um concelho
            if ((string.IsNullOrWhiteSpace(textNome.Text) == false) ||
           (listDistrito.SelectedValue != "Selecione um Distrito") ||
           (listConcelho.SelectedValue != "Selecione um Concelho" &&
           listConcelho.SelectedValue != ""))
            {
                command += "WHERE ";
                if (string.IsNullOrWhiteSpace(textNome.Text) == false)
                {
                    condicao = true;
                    command += "L.Nome LIKE '%" + textNome.Text.Trim() + "%' ";
                }
                if (listDistrito.SelectedValue != "Selecione um Distrito")
                    if (condicao)
                        command += " AND D.Id = " + listDistrito.SelectedValue;
                    else
                        command += " D.Id = " + listDistrito.SelectedValue;
                if (listConcelho.SelectedValue != "Selecione um Concelho" &&
               listConcelho.SelectedValue != "")
                    if (condicao)
                        command += " AND C.Id = " + listConcelho.SelectedValue;
                    else
                        command += " C.Id = " + listConcelho.SelectedValue;
            }
            DataTable resultadoPesquisa = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(command, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader(); // erro nesta linha de codigo
                resultadoPesquisa.Load(reader);
                reader.Close();
            }
            //os dados são passados ao método que usa a classe PagedDataSource
            //para permitir a paginação
            //BindListLocais(resultadoPesquisa);
        }

    }
}
