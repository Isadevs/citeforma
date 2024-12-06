"""
    Programa para Gestao do catálogo de viaturas. Este Programa Permitirá
    - Listar o catálogo
    - Pesquisar por alguns campos
    - Eliminar um registro do catálogo
    - Guardar o catálogo em um ficheiro
"""

# matricula: DD-LL-DD onde D: Dígito L: Letra
# marca: deve ter uma ou mais palavras (apenas letras ou dífitos)
# modelo: mesmo que a marca
# data: deve vir no formato ISO: 'YYY-MM-DD'

from datetime import date

#Iniciando a classe de Placa

class Viatura:
    def __init__(
            self,
            matricula: str,
            marca: str,
            modelo: str,
            data: date
    ):
        self.matricula = matricula
        self.marca = marca
        self.modelo = modelo
        self.data = data

#Função do construtor:

    # 1: Validar Parâmetros Aqui vai entrar os tratamentos e exceções:
    
def main():
    carro1 = Viatura(
    matricula = "ABC1234",
    marca = "Toyota",
    modelo = "Economico",
    data = date(2024, 12, 5)
)

    print(f'Viatura - Matrícula: {carro1.matricula} Marca: {carro1.marca} Modelo: {carro1.modelo} Data: {carro1.data}')

if __name__ == '__main__':
    main()
