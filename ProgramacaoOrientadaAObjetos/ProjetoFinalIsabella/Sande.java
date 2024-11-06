package vendingIsabella;

import java.util.Date;

public class Sande extends Produto {

    //Construtor
    public Sande(String nome, Double preco, String referencia, Date validade, String produtor, String sabor) {
        super(nome, preco, referencia, validade);
        this.produtor = produtor;
        this.sabor = sabor;
    }

    //Atributos
    private String produtor;
    private String sabor;

    //Métodos
    public String getProdutor() {
        return produtor;
    }

    public String getSabor() {
        return sabor;
    }

    public void setProdutor(String produtor) {
        this.produtor = produtor;
    }

    public void setSabor(String sabor) {
        this.sabor = sabor;
    }

}
