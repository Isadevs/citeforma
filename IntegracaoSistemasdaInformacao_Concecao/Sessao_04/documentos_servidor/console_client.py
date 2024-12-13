import sys

from products import PRODUCT_TYPES, ProductCollection, InvalidProdAttr
from console_utils import accept, ask, show_msg, pause, cls


PRODUCTS_CSV_PATH = 'Sessao_04/documentos_servidor/products.csv'
prods_collection: ProductCollection


def main():
    global prods_collection
    try: 
        prods_collection = ProductCollection.from_csv(PRODUCTS_CSV_PATH)
        exec_menu()
    except InvalidProdAttr as ex:
        print("Erro ao carregar produtos")
        print(ex)
    except KeyboardInterrupt:
        exec_end()
#:

def exec_menu():
    print("MENU PRINCIPAL")
    while True:
        cls()
        print()
        show_msg("┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓")
        show_msg("┃                                           ┃")
        show_msg("┃   L  - Listar catálogo                    ┃")
        show_msg("┃   P  - Pesquisar por id                   ┃")
        show_msg("┃   PT - Pesquisar por tipo                 ┃")
        show_msg("┃   A  - Acrescentar produto                ┃")
        show_msg("┃   E  - Eliminar produto                   ┃")
        show_msg("┃   G  - Guardar catálogo em ficheiro       ┃")
        show_msg("┃                                           ┃")
        show_msg("┃   T  - Terminar programa                  ┃")
        show_msg("┃                                           ┃")
        show_msg("┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛")
        print()

        option = ask("  OPÇÃO> ")

        match option.upper():
            case 'L' | 'LISTAR':
                exec_list_products()
            case 'P' | 'PESQUISAR':
                exec_search_by_id()
            case 'PT' | 'TIPO':
                exec_search_by_type()
            case 'E' | 'ELIMINAR':
                exec_delet_product()
            case 'T' | 'TERMINAR':
                exec_end()
            case 'G' | 'GUARDAR':
                exec_save_catalog()
            case _:
                print("Opção inválida")
#:

def exec_list_products():
    enter_menu("PRODUTOS")
    show_table_with_prods(prods_collection)
    print()
    pause()
#:

def exec_search_by_id():
    enter_menu("PESQUISAR POR ID")
    id_ = accept(
        msg = "Indique o ID do produto a pesquisar: ",
        error_msg = "ID {} inválido! Tente novamente.",
        convert_fn = int,
    )
    
    if prod := prods_collection.search_by_id(id_):
        show_msg("Produto encontrado.")
        print()
        show_table_with_prods(ProductCollection([prod]))
    else:
        show_msg(f"Produto com ID {id_} não encontrado.")

    print()
    pause()
#:

def exec_search_by_type():
    enter_menu("PESQUISA POR TIPO")
    prod_type = accept(
        msg = "Indique o tipo do produto a pesquisar: ",
        error_msg = "Tipo {} inválido! Tente novamente",
        check_fn = lambda prod: prod in PRODUCT_TYPES,
    )
    print()

    if prods := prods_collection.search(lambda prod: prod.prod_type == prod_type):
        show_msg("Foram encontrados os seguintes produtos:")
        print()
        show_table_with_prods(ProductCollection(prods))
    else:
        show_msg(f"Não foram encontrados produtos com tipo {prod_type}.")

    print()
    pause()
#:

def exec_delet_product():
    enter_menu("ELIMINAR PRODUTO")
    id_ = accept(
        msg ="Indique o ID do produto a eliminar: ",
        error_msg = "ID {} inválido! Tente novamente.",
        convert_fn=int,
    ) 
    if prod := prods_collection.search_by_id(id_):
        confirmation = ask (f"Tem certeza que deseja eliminar o produto {prod.name} (S/s)?")
        if confirmation == 'S' or confirmation == 's':
            prods_collection.remove_by_id(id_)
            show_msg(f"Produto com ID {id_} eliminado com sucesso")
        else:
            show_msg("Operação cancelada.")
    else:
        show_msg(f"Produto com ID {id_} não encontrado")
    
    print()
    pause()
#

def exec_save_catalog():
    enter_menu("GUARDAR CATÁLOGO")
    
    try:
        prods_collection.export_to_csv(PRODUCTS_CSV_PATH)
        show_msg(f"Catálogo guardado com sucesso em '{PRODUCTS_CSV_PATH}'.")
    except ValueError as e:
        show_msg(f"Erro {e}")
    except Exception as e:
        show_msg(f"Ocorreu um erro inesperado ao guardar o catálogo: {e}")
    
    print()
    pause()
#:

def exec_end():
    print("  O programa vai terminar...")
    sys.exit(0)
#:

def show_table_with_prods(prods: ProductCollection):
    header = f'{"ID":^8} | {"Nome":^26} | {"Tipo":^8} | {"Quantidade":^16} | {"Preço":^14}'
    sep = f'{"-" * 9}+{"-" * 28}+{"-" * 10}+{"-" * 18}+{"-" * 16}'

    show_msg(header)
    show_msg(sep)

    for prod in prods:
        data_line = f'{prod.id:^8} | {prod.name:<26} | {prod.prod_type:<8} | {prod.quantity:>16} | {prod.price:>14.2f}€'
        show_msg(data_line)
#:

def enter_menu(title: str):
    cls()
    show_msg(title.upper())
    print()
#:

if __name__ == "__main__":  # verifica se o script foi executado
    main()  # na linha de comandos


# y: int = 20

# def fun():
#     print(y)
#     # global y
#     # y = 10
