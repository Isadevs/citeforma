<%@ Page 
    Title="" 
    Language="C#" 
    MasterPageFile="~/modelo.Master" 
    AutoEventWireup="true" 
    CodeBehind="local.aspx.cs" 
    Inherits="projetofinal.local" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>
        <asp:Label ID="nomeLocal" runat="server" Text="Nome do Local"></asp:Label>
    </h1>
    <p>
        <asp:Label ID="localizacao" runat="server" Text="Localização"></asp:Label>
    </p>
    <p>
        <asp:Label ID="descricao" runat="server" Text="Descrição"></asp:Label>
    </p>
    <div id="carouselFotos" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <asp:Repeater ID="rptFotos" runat="server">
                <ItemTemplate>
                    <div class='<%# Container.ItemIndex == 0 ? "carousel-item active" : "carousel-item" %>'>
                        <img src='<%# Eval("Ficheiro") %>' class="d-block w-100" alt='<%# Eval("Legenda") %>' />
                        <div class="carousel-caption d-none d-md-block">
                            <h5><%# Eval("Legenda") %></h5>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <a class="carousel-control-prev" href="#carouselFotos" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselFotos" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <asp:DataList 
        runat="server"
        ID="listComentarios"
        CssClass="mt-3" Width="1326px">
            <ItemTemplate>
                    <table class="table table-borderless mb-2">
                        <tr style="height:auto; padding-bottom: 20px;">
                            <td>
                                <asp:Label 
                                    ID="comentario"
                                    runat="server"
                                    Text='<%# Eval("comentario") %>' />
                                <br /><br />
                                <asp:Label Text='<%# "Classificação - " + Eval("classificacao")?.ToString()%>' runat="server"/>
                            </td>
                        </tr>
                        <tr style="vertical-align: middle; height: 40px;"></tr>
                            <td>
                                <asp:Label ID="utilizador" runat="server"
                                    Text='<%# Eval("utilizador") %>' />
                            </td>
                    </table>
            </ItemTemplate>
    </asp:DataList>
</asp:Content>

