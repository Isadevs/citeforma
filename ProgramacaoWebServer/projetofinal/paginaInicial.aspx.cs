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
    public partial class paginaInicial : System.Web.UI.Page
    {
        int currentPage = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ObterLocais();
                ViewState["contador"] = 0;
            }
            currentPage = (int)ViewState["contador"];
        }

        void BindListLocais(DataTable table)
        {
            PagedDataSource paged = new PagedDataSource();

            paged.DataSource = table.DefaultView;

            paged.PageSize = 6;
            paged.AllowPaging = true;
            paged.CurrentPageIndex = currentPage;

            linkPrimeira.Enabled = !paged.IsFirstPage;
            linkAnterior.Enabled = !paged.IsFirstPage;
            linkSeguinte.Enabled = !paged.IsLastPage;
            linkUltima.Enabled = !paged.IsLastPage;

            ViewState["total"] = paged.PageCount;
            listLocais.DataSource = paged;
            listLocais.DataBind();
            ViewState["dataSource"] = table;
        }

        void ObterLocais()
        {

            SqlConnection connection = new SqlConnection(
                @"data source=.\Sqlexpress; initial catalog = Locais; integrated security = true;");

            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "GetLocais";

            //a

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            DataTable table = new DataTable();
            table.Load(reader);
            reader.Close();
            connection.Close();

            BindListLocais(table);
        }

        protected void linkPrimeira_Click(object sender, EventArgs e)
        {
            currentPage = 0;
            ViewState["contador"] = currentPage;
            ObterLocais();
        }

        protected void linkAnterior_Click(object sender, EventArgs e)
        {
            //obter valor da paginação atual
            currentPage = (int)ViewState["contador"];
            currentPage -= 1;
            ViewState["contador"] = currentPage;
            //utilizar dados do DataTable que se encontram em ViewState
            BindListLocais((DataTable)ViewState["dataSource"]);
        }

        protected void linkSeguinte_Click(object sender, EventArgs e)
        {
            //obter valor da paginação atual
            currentPage = (int)ViewState["contador"];
            currentPage += 1;
            ViewState["contador"] = currentPage;
            //utilizar dados do DataTable que se encontram em ViewState
            BindListLocais((DataTable)ViewState["dataSource"]);
        }

        protected void linkUltima_Click(object sender, EventArgs e)
        {
            //a variável "total" tem o total de páginas do DataList
            currentPage = (int)ViewState["total"] - 1;
            ViewState["contador"] = currentPage;
            //utilizar dados do DataTable que se encontram em ViewState
            BindListLocais((DataTable)ViewState["dataSource"]);
        }
    }
}