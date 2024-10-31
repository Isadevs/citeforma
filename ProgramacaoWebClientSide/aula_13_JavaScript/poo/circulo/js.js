class Circulo
{
    constructor(raio)
    {
        this.raio = raio;
    }

    get perimetro()
    {
        return parseFloat((raio) * 2 * Math.PI).toFixed(2);
    }

    get area()
    {
        return ((parseFloat(this.raio), 2) * Math.PI).toFixed(2);
    }
}

class Cilindro extends Circulo
{
    constructor(raio, altura)
    {
        super(raio);//faz referencia ao raio do construtor
        this.altura = altura;
    }

    get volume()
    {
        return super(area) * parseFloat(this.altura).toFixed(2);
    }
}

class Cone extends Cilindro
{
    super
}