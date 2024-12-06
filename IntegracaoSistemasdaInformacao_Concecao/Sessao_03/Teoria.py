#Representando um produto:"

#1º Tipo de dados para representar um produto:"
#Como criar classes:"

# o que não se coloca são os atributos, 
#vai ser atribuidos em outros mecanismos modernos, 
#sera colocado métodos
#Criando os construtores:

from decimal import Decimal as dec

PRODUCT_TYPES = {
    'AL'  :'Alimentação',
    'DL'  : 'Detergentes p/ Loiça',
    'FRL' : 'Frutas e Legumes'
}

class Produto:    

    def __init__(
            self,
            id_ : int, 
            nome: str, 
            tipo:str,
            quantidade: int,
            preco: dec,
    ):
    #Função do construtor:

    # 1: Validar Parâmetros
    # 2: Inicializar o objeto ou definir o objeto

    #Métodos staticos são os metodos de instância
    #O self é o mesmo que o this, é uma espécie de 
    #variavel que está sempre definida
        if id_<= 0 or len(str(id_)) !=5:
            raise ValueError(f'{id=} (inválido deve ser > 0 e ter 5 dídigos)')

        if not nome.strip():
            raise ValueError(f'{nome=} inválido')
        
        if tipo not in PRODUCT_TYPES:
            raise ValueError(f'{tipo=}: tipo não reconhecido')
        
        if quantidade < 0:
            raise ValueError(f'{quantidade} inválida (deve ser >= 0)')
        
        self.id = id_
        self.nome= nome
        self.tipo = tipo
        self.quantidade = quantidade
        self.preco = preco
#:

def valida_nome1(nome: str) -> bool: 
    return bool(re.search(r'^[a-zA]{2,}(\s+[a-zA]{2,})+$', nome))


def valida_nome2(nome: str) -> bool:
    #pelo menos 2 palavras com pelo menos 2 cars.
    palavras = nome.split()
    if len(palavras) < 2:
        return False
    return all(len(palavra) >= 2 for palavra in palavras)
#:

def valida_nome3(nome: str) -> bool:
    #pelo menos 2 palavras com pelo menos 2 cars.
    palavras = nome.split()
    
    if len(palavras) < 2:
        return False
    
    for palavra in palavras:
        if len(palavra) < 2:
            return False
    return True
#:

class InvalidProdAttr(ValueError):
    """
    Invalid Product Atribute.
    """

def main():
    try:
        prod1 = Produto(
            id_ = 30987,
            nome ='Pão de Milho',
            tipo ='AL',
            quantidade =2,
            preco = dec('1'),
    )
    
        prod2 = Produto(
            id_ = 30098,
            nome ='Pão de Milho',
            tipo ='AL',
            quantidade =2,
            preco = dec('1'),
        )    
        #Print do valor da classe
        print(f"Produto ID: {prod1.id} NOME: {prod1.nome}")

    except ValueError as ex:
        print("Erro: atributo inválido")
        print(ex)


        
if __name__ == '__main__':
    main()

