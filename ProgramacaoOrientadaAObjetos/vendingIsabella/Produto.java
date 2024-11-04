package vendingIsabella;

import java.util.Date;

public class Produto {

    //Construtor:
    public Produto(String nome, Double preco, String referencia, Date validade) {
        this.nome = nome;
        this.preco = preco;
        this.referencia = referencia;
        this.validade = validade;
    }

    //Atributo:
    private String nome;
    private Double preco;
    private String referencia;
    private Date validade;

    //Métodos:
    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setPreco(Double preco) {
        this.preco = preco;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public void setValidade(Date validade) {
        this.validade = validade;
    }

    public String getNome() {
        return nome;
    }

    public Double getPreco() {
        return preco;
    }

    public String getReferencia() {
        return referencia;
    }

    public Date getValidade() {
        return validade;
    }
}
