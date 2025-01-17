<%@ Page Title="" Language="C#" MasterPageFile="~/modelo.Master" AutoEventWireup="true" CodeBehind="paginaInicial.aspx.cs" Inherits="projetofinal.paginaInicial" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
</asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">


    <div class="row mt-5">
        <div class="col-9">

            <span class="fs-2">Locais</span>

            <asp:DataList runat="server" ID="listLocais" RepeatColumns="3" RepeatDirection="Horizontal">
                <ItemTemplate>
                    <table class="table table-borderless">
                        <tr style="height: 220px; vertical-align: middle;">
                            <td style="width: 300px; text-align: center;">
                                <a href="local.aspx?id=<%# Eval("LocalID") %>">
                                    <img 
					src='<%# Eval("PrimeiraFoto") %>' 
					alt='<%# Eval("NomeLocal") %>' style="width: 250px;" />
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="local.aspx?id=<%# Eval("LocalId") %>" class="nav-link">
                                    <asp:Label Text='<%# Eval("NomeLocal") %>' runat="server" CssClass="fs-3" />
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>
                                    <asp:Label Text='<%# Eval("Concelho") %>' runat="server" />, &nbsp;
                                    <asp:Label Text='<%# Eval("Distrito") %>' runat="server" />
                                </span>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>

            <div class="mt-4 container" style="margin-bottom: 100px;">
                <asp:LinkButton Text="Primeira" runat="server" ID="linkPrimeira"
                    CssClass="text-decoration-none fs-5" OnClick="linkPrimeira_Click" />
                <asp:LinkButton Text="Anterior" runat="server" ID="linkAnterior"
                    CssClass="ms-3 text-decoration-none fs-5" OnClick="linkAnterior_Click" />
                <asp:LinkButton Text="Seguinte" runat="server" ID="linkSeguinte"
                    CssClass="ms-3 text-decoration-none fs-5" OnClick="linkSeguinte_Click" />
                <asp:LinkButton Text="Última" runat="server" ID="linkUltima"
                    CssClass="ms-3 text-decoration-none fs-5" OnClick="linkUltima_Click" />
            </div>

        </div>

        <div class="col-3 text-center">

            <span class="fs-5">Locais com melhor classificação</span>

        </div>

    </div>
</asp:Content>
