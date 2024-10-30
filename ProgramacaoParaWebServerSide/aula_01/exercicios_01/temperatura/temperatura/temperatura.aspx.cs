using System;
using System.Web.UI;

namespace temperatura
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void btnConverter_click(object sender, EventArgs e)
        {
            double temperatura;
            bool isNumeric = double.TryParse(txtTemperatura.Text, out temperatura);

            if (!isNumeric)
            {
                lblResultado.Text = "Valor inválido.";
                return;
            }

            string de = "";
            string para = "";

            // Unidade de entrada
            if (rbDeCelsius.Checked) de = "Celsius";
            if (rbDeFahrenheit.Checked) de = "Fahrenheit";
            if (rbDeKelvin.Checked) de = "Kelvin";

            // Unidade de saída
            if (rbParaCelsius.Checked) para = "Celsius";
            if (rbParaFahrenheit.Checked) para = "Fahrenheit";
            if (rbParaKelvin.Checked) para = "Kelvin";

            double resultado = ConverterTemperatura(temperatura, de, para);
            lblResultado.Text = $"Resultado: {resultado} {para}";
        }

        private double ConverterTemperatura(double valor, string de, string para)
        {
            if (de == para)
                return valor;

            // Celsius para Fahrenheit e Kelvin
            if (de == "Celsius" && para == "Fahrenheit")
                return (valor * 9 / 5) + 32;
            if (de == "Celsius" && para == "Kelvin")
                return valor + 273.15;

            // Fahrenheit para Celsius e Kelvin
            if (de == "Fahrenheit" && para == "Celsius")
                return (valor - 32) * 5 / 9;
            if (de == "Fahrenheit" && para == "Kelvin")
                return (valor - 32) * 5 / 9 + 273.15;

            // Kelvin para Celsius e Fahrenheit
            if (de == "Kelvin" && para == "Celsius")
                return valor - 273.15;
            if (de == "Kelvin" && para == "Fahrenheit")
                return (valor - 273.15) * 9 / 5 + 32;

            return valor;
        }
    }
}
