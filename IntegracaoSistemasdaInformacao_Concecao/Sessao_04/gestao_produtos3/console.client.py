
from products import ProductCollection, InvalidProdArttr

PRODUCT_CSV_PATH = 'products.csv'
prods_collection: ProductCollection

def main(): #funcao é de inicializar o programa (preparar o programa para inicialização)
    global prods_collection
    exec_menu()
    
    try:
        prods = ProductCollection.from_csv(PRODUCT_CSV_PATH)
        exec_menu()
    except InvalidProdArttr as ex:
        print("Erro ao carregar produtos")
        print(ex)
    except KeyboardInterrupt:
        exec_end()

if __name__ == "__main__":
    main()

def exec_menu():
    print("MENU PRINCIPAL")
    while True:
        print("L - Lista catálogo")
        print("P - Pesquisar por ID")

    opcao = input("OPÇÃO>")

    match opcao.upper():
        case 'L':
            exec_list_product()
        case 'P':
            exec_search_by_id()
        case 'T':
            exec_end()
        case _:
            print("Opção inválida")

def exec_list_products():
    print(" PRODUTOS")

def exec_search_by_id():
    print(" PESQUISAR POR ID: ")

def exec_end():
    print(" O programa vai terminar...")
    sys.exit(0) #porque zero quer dizer que o programa foi executado corretamenta
                #É Preciso importar o módulo sys para que ele execute corretamente


if __name__== "__main__":


#def fun(): #definindo variaveis globais em Python
    #global y
    #y = 10

#Sempre importante que se limpe o ecrã




