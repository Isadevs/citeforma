<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="temperatura.aspx.cs" Inherits="temperatura.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style ="text-align: center;">
            <h2>Temperatura a Converter</h2>
            <asp:TextBox ID="txtTemperatura" runat="server" Width="100px"
                placeholder="Digite o valor"></asp:TextBox>
            <br /><br />
            <div style="display: inline-block; text-align: left;">
                <fieldset>
                    <legend>Converter de</legend>
                    <asp:RadioButton ID="rbDeCelsius" runat="server" GroupName="de" Text="Celsius" />
                    <br />
                    <asp:RadioButton ID="rbDeFahrenheit" runat="server" GroupName="de" Text="Fahrenheit" />
                    <br />
                    <asp:RadioButton ID="rbDeKelvin" runat="server" GroupName="de" Text="Kelvin" />
                </fieldset>
            </div>
            
            <div style="display: inline-block; text-align:left; margin-left:20px;">
                <fieldset>
                    <legend>Converter para</legend>
                    <asp:RadioButton ID="rbParaCelsius" runat="server" GroupName="para" Text="Celsius" />
                    <br />
                    <asp:RadioButton ID="rbParaFahrenheit" runat="server" GroupName="para" Text="Fahrenheit" />
                    <br />
                    <asp:RadioButton ID="rbParaKelvin" runat="server" GroupName="para" Text="Kelvin" />
                </fieldset>
            </div>
            <br /> <br />
            <asp:Button ID="btnConverter" runat="server" Text="Converter" OnClick="btnConverter_click" />
            <br /><br />
            <asp:Label ID="lblResultado" runat="server" Text="" Font-Bold="true"></asp:Label>
        </div>
    </form>
</body>
</html>
