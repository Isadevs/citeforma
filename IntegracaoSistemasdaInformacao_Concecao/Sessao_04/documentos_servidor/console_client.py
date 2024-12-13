import sys
from products import ProductCollection, InvalidProdAttr

PRODUCTS_CSV_PATH = 'products.csv'
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
        print("  L - Lista catÃ¡logo")
        print("  P - Pesquisar por ID")
        print("  T - Terminar")

        opcao = input("OPÃ‡ÃƒO> ")

        match opcao.upper():
            case 'L':
                exec_list_products()
            case 'P':
                exec_search_by_id()
            case 'T':
                exec_end()
            case _:
                print("OpÃ§Ã£o invÃ¡lida")
#:

def exec_list_products():
    print("  PRODUTOS")
#:

def exec_search_by_id():
    print("  PESQUISAR POR ID")
#:

def exec_end():
    print("  O programa vai terminar...")
    sys.exit(0)
#:

if __name__ == "__main__":  # verifica se o script foi executado
    main()  # na linha de comandos


# y: int = 20

# def fun():
#     print(y)
#     # global y
#     # y = 10