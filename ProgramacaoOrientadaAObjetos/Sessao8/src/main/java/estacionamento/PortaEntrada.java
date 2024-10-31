
package estacionamento;

public class PortaEntrada extends Porta{
    public PortaEntrada(int hora){horaEntrada = hora;}
    
    //atributos
    private int horaEntrada;
    
    //métodos 
    @Override
    public void abrir() {System.out.println("Retirar bilhete para abrir.");}
    
    @Override
    public void fechar() {System.out.println("Carro entrou no estacionamento. Fechar Porta.");}

    @Override
    public void bilhete() {System.out.println("Hora de entrada: " + horaEntrada);}
}
