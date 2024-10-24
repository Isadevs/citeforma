class Pessoa
{
    constructor(nome, dataNascimento){
        this.nome = nome;
        this.dataNascimento = dataNascimento;
    }

    get idade()
    {
        return this.#calcularIdade(this.dataNascimento);
    }

    #calcularIdade(dataNascimento)
    //privado só pode ser visível dentro da classe que foi definido
    {
        //Converter a data de Nascimento para date
        let nascimento = new Date(dataNascimento);

        //obter a data atual
        let hoje = new Date();

        //calcular a diferença de anos (entre ano atual e ano de nascimento)
        let idade = hoje.getFullYear() - nascimento.getFullYear();

        let mesAtual = hoje.getMonth();
        let diaAtual = hoje.getDate();
    }
}