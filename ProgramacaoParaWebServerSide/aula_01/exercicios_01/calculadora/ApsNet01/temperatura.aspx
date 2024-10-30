<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="temperatura.aspx.cs" Inherits="ApsNet01.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Temperatura</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="form-group">
                        <label for="temperatura">Temperatura a Converter:</label>
                        <input type="number" class="form-control" id="temperatura" placeholder="Digite a temperatura" />
                    </div>

                    <div class="row">
                        <class=>Converter de:</class=>
                        <br/>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="form-check-input" ID="celsiusDe" runat="server" Value="celsius" Checked="true" />
                            <label for="celsiusDe" class="form-check-label">Celsius</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="form-check-input" ID="fahrenheitDe" runat="server" Value="fahrenheit" />
                            <label for="fahrenheitDe" class="form-check-label">Fahrenheit</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="form-check-input" ID="kelvinDe" runat="server" Value="kelvin" />
                            <label for="kelvinDe" class="form-check-label">Kelvin</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
