<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="calculadora.aspx.cs" Inherits="ApsNet01.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Calculadora</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
     <form id="form1" runat="server">
        <div class="container mt-5">
            <h2>ASP.NET - server side code</h2>
            <table class="table">
                <tr>
                    <td>Valor 1</td>
                    <td><asp:TextBox ID="textBoxValor1" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Valor 2</td>
                    <td><asp:TextBox ID="textBoxValor2" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Resultado</td>
                    <td><asp:TextBox ID="textBoxResultado" runat="server" ReadOnly="true"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="buttonSomar" runat="server" Text="+" OnClick="buttonSomar_Click" CssClass="btn btn-primary" />
                        <asp:Button ID="buttonSubtrair" runat="server" Text="-" OnClick="buttonSubtrair_Click" CssClass="btn btn-danger" />
                        <asp:Button ID="buttonMultiplicar" runat="server" Text="*" OnClick="buttonMultiplicar_Click" CssClass="btn btn-success" />
                        <asp:Button ID="buttonDividir" runat="server" Text="/" OnClick="buttonDividir_Click" CssClass="btn btn-warning" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
