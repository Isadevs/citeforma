<%@ Page Title="" Language="C#" MasterPageFile="~/modelo.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="projetofinal.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <asp:Label runat="server" Font-Bold="true">Login</asp:Label>

    <table>
        <tr>
            <td>Utilizador</td>
            <td>
                <asp:TextBox 
                    runat="server" 
                    ID="loginUtilizador" 
                    CssClass="form-control" 
                    required="required" />
                <asp:RequiredFieldValidator 
                    ErrorMessage="Campo obrigatório" 
                    ControlToValidate="loginUtilizador" 
                    runat="server" 
                    ForeColor="#CC0000" />
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td>
                <asp:TextBox 
                    runat="server" 
                    ID="TextPass" 
                    CssClass="form-control" 
                    required="required" />
                <asp:RequiredFieldValidator 
                    ErrorMessage="Campo obrigatório" 
                    ControlToValidate="TextPass" 
                    runat="server" 
                    ForeColor="#CC0000" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button 
                    runat="server" 
                    ID="buttonLogin" 
                    Text="Login" 
                    CssClass="btn" 
                    Style="background-color: #D7D3BF;" 
                    OnClick="buttonLogin_Click" />
            </td>

            <td>
                <asp:Button 
                    runat="server" 
                    ID="criarLogin" 
                    Text="Criar Login" 
                    CssClass="btn" 
                    Style="background-color:#D7D3BF;" 
                    OnClick="buttonLogin_Click" />
            </td>   
        </tr>
    </table>
</asp:Content>

