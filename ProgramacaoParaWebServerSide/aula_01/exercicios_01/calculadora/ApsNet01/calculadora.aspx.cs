using System;
using System.Web.UI;

namespace ApsNet01
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void buttonSomar_Click(object sender, EventArgs e)
        {
            Calcular("+");
        }

        protected void buttonSubtrair_Click(object sender, EventArgs e)
        {
            Calcular("-");
        }

        protected void buttonMultiplicar_Click(object sender, EventArgs e)
        {
            Calcular("*");
        }

        protected void buttonDividir_Click(object sender, EventArgs e)
        {
            Calcular("/");
        }

        private void Calcular(string operacao)
        {
            int valor1, valor2, resultado = 0; 

            if (int.TryParse(textBoxValor1.Text, out valor1) && int.TryParse(textBoxValor2.Text, out valor2))
            {
                switch (operacao)
                {
                    case "+":
                        resultado = valor1 + valor2;
                        break;

                    case "-":
                        resultado = valor1 - valor2;
                        break;

                    case "*":
                        resultado = valor1 * valor2;
                        break;

                    case "/":
                        if (valor2 != 0)
                        {
                            resultado = valor1 / valor2;
                        }
                        else
                        {
                            textBoxResultado.Text = "Divisão por zero!";
                            return; // Retorna para evitar atribuir resultado se houver divisão por zero
                        }
                        break;
                }
                textBoxResultado.Text = resultado.ToString();
            }
            else
            {
                textBoxResultado.Text = "Por favor, insira valores válidos.";
            }
        }
    }
}
