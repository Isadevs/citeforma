"""
Programa para gestÃ£o do catÃ¡logo de produtos. Este programa permite:
    - Listar o catÃ¡logo
    - Pesquisar por alguns campos 
    - Eliminar um registo do catÃ¡logo
    - Guardar o catÃ¡logo em ficheiro
"""

from decimal import Decimal as dec
import re
from typing import TextIO


CSV_DELIM = ','
PRODUCT_TYPES = {
    "AL": "AlimentaÃ§Ã£o",
    "DL": "Detergentes p/ LoiÃ§a",
    "FRL": "Frutas e Legumes",
}


class Produto:
    # id, designacao,tipo/categoria,quantidade,preco unitÃ¡rio
    def __init__(
            self,
            id_: int,  # > 0 e cinco dÃ­gitos
            nome: str,  # pelo menos 2 palavras com pelo menos 2 cars.
            tipo: str,  # tipo sÃ³ pode ser 'AL', 'DL', 'FRL'
            quantidade: int,  # >= 0
            preco: dec,  # >= 0
    ):
        # 1. Validar parÃ¢metros
        if id_ <= 0 or len(str(id_)) != 5:
            raise InvalidProdAttr(f"{id_=} invÃ¡lido (deve ser > 0 e ter 5 dÃ­gitos)")

        if not valida_nome(nome):
            raise InvalidProdAttr(f"{nome=} invÃ¡lido")

        if tipo not in PRODUCT_TYPES:
            raise InvalidProdAttr(f"{tipo=}: tipo nÃ£o reconhecido.")

        if quantidade < 0:
            raise InvalidProdAttr(f"{quantidade=} invÃ¡lida (deve ser >= 0)")

        if preco < 0:
            raise InvalidProdAttr(f"{preco=} invÃ¡lido (deve ser >= 0)")

        # 2. Inicializar/definir o objecto
        self.id = id_
        self.name = nome
        self.tipo = tipo
        self.quantidade = quantidade
        self.preco = preco
    #:

    @classmethod
    def from_csv(cls, csv: str, csv_delim = CSV_DELIM) -> 'Produto':
        attrs = csv.split(csv_delim)
        return Produto(
            id_= int(attrs[0]),
            nome = attrs[1],
            tipo = attrs[2],
            quantidade = int(attrs[3]),
            preco = dec(attrs[4])
        )
    #:

    def __str__(self) -> str:
        return f'Produto[id: {self.id} nome: {self.name}]'
    #:

    def __repr__(self) -> str:
        cls_name = self.__class__.__name__
        return f"{cls_name}({self.id}, '{self.name}', '{self.tipo}', {self.quantidade}, Decimal('{self.preco}'))"
    #:

    @property
    def desc_tipo(self) -> str:
        return PRODUCT_TYPES[self.tipo]
    #:
#:

def valida_nome(nome: str) -> bool:
    com_acento = 'Ã±Ã£Ã Ã¡Ã¢Ã¤Ã¥Ã©Ã¨ÃªÄ™Ä“Ã«Ã³ÃµÃ´Ã²Ã¶ÅÃ­Ã®Ã¬Ã¯Ä¯Ä«ÃºÃ¼Ã¹Ã»Å«Ã‘ÃƒÃ€ÃÃ‚Ã„Ã…Ã‰ÃˆÃŠÄ˜Ä’Ã‹Ã“Ã•Ã”Ã’Ã–ÅŒÃÃŽÃŒÃÄ®ÄªÃšÃœÃ™Ã›Åª'
    return bool(re.fullmatch(rf"[a-zA-Z{com_acento}]{{2,}}(\s+[a-zA-Z{com_acento}]{{2,}})*", nome))
#:

class InvalidProdAttr(ValueError):
    """
    Invalid Product Attribute.
    """
#:

class ProductCollection:
    def __init__(self):
        self._produtos: list[Produto] = []
    #:

    @classmethod
    def from_csv(cls, csv_path: str) -> 'ProductCollection':
        prods = ProductCollection()
        with open(csv_path, 'rt') as file:
            for line in relevant_lines(file):
                prods.append(Produto.from_csv(line))
        return prods
    #:

    def append(self, novo_prod: Produto):
        if self.search_by_id(novo_prod.id):
            raise DuplicateValue(f'Produto jÃ¡ existe com id {novo_prod.id}')
        self._produtos.append(novo_prod)
    #:

    def search_by_id(self, id_: int) -> Produto | None:
        for prod in self._produtos:
            if prod.id == id_:
                return prod
        return None
    #:

    def __iter__(self):
        for prod in self._produtos:
            yield prod #yeld e um return mas ele retorna um valor e volta é uma co-rotina
            

    def _dump(self):
        for prod in self._produtos:
            print(prod)
    #:
#:

def relevant_lines(file: TextIO):
    for line in file:
        line = line.strip()
        if len(line) == 0:
            continue
        if line.startswith('#'):
            continue
        yield line
#:

class DuplicateValue(Exception):
    """
    If there is a duplicate product in a ProductCollection.
    """
