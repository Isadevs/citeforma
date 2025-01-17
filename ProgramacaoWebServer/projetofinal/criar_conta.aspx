<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="criar_conta.aspx.cs" Inherits="projetofinal.Utilizadores.criar_conta"
    MasterPageFile="~/modelo.Master" %>

<asp:Content ContentPlaceHolderID="headContent" ID="head" runat="server">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="main" runat="server">
    <asp:Label runat="server" Font-Bold="true">Criar Conta</asp:Label>
    <table>
        <tr>
            <td>Nome</td>
            <td>
                <asp:TextBox runat="server" ID="textNome" CssClass="form-control" required="required" />
                <asp:RequiredFieldValidator ErrorMessage="Campo obrigatório" ControlToValidate="textNome" runat="server" ForeColor="#CC0000" />
            </td>
        </tr>
        <tr>
            <td>Email</td>
            <td>
                <asp:TextBox runat="server" ID="textEmail" CssClass="form-control" required="required" />
                <asp:RequiredFieldValidator ErrorMessage="Campo obrigatório" ControlToValidate="textEmail" runat="server" ForeColor="#CC0000" />
                <asp:RegularExpressionValidator ID="regExpression1" runat="server" ControlToValidate="textEmail" ErrorMessage="Insira um e-mail válido."
                    ForeColor="Red" ValidationExpression="^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,7}$">
                </asp:RegularExpressionValidator>

            </td>
        </tr>
        <tr>
            <td>Data Nascimento</td>
            <td>
                <asp:TextBox runat="server" ID="textDataNasc" CssClass="form-control" required="required" />
                <asp:RequiredFieldValidator ErrorMessage="Campo obrigatório" ControlToValidate="textDataNasc" runat="server" ForeColor="#CC0000" />
                <asp:CompareValidator
                    ID="cvDataNascimento" runat="server" ControlToValidate="textDataNasc" ForeColor="Red">
                </asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td>Nome de utilizador</td>
            <td>
                <asp:TextBox runat="server" ID="textUtilizador" CssClass="form-control" required="required" />
                <asp:RequiredFieldValidator ErrorMessage="Campo obrigatório" ControlToValidate="textUtilizador" runat="server" ForeColor="#CC0000" />

            </td>
        </tr>
        <tr>
            <td>Palavra-passe </td>
            <td>
                <asp:TextBox runat="server" ID="textPass" CssClass="form-control" required="required" />
                <asp:RequiredFieldValidator ErrorMessage="Campo obrigatório" ControlToValidate="textPass" runat="server" ForeColor="#CC0000" />
            </td>
        </tr>
        <tr>
            <td>Repita a palavra-passe </td>
            <td>
                <asp:TextBox runat="server" ID="textPassRepetir" CssClass="form-control" required="required" />
                <asp:RequiredFieldValidator ErrorMessage="Campo obrigatório" ControlToValidate="textPassRepetir" runat="server" ForeColor="#CC0000" />
                <asp:CompareValidator ID="CompareValidator1" runat="server" ForeColor="#CC0000" ErrorMessage="As palavras-passe devem ser iguais." ControlToValidate="textPassRepetir"
                    ControlToCompare="textPass"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button runat="server" ID="buttonCriarConta" Text="Criar Conta" 
                    CssClass="btn" Style="background-color: #D7D3BF;" OnClick="buttonCriarConta_Click" />
            </td>
        </tr>
    </table>



</asp:Content>
