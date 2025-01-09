from PIL import Image, ImageDraw

# Definir tamanhos das telas para cada densidade
tamanhos_telas = {
    "ldpi": (240, 320),      # Baixa densidade
    "mdpi": (320, 480),      # Densidade média
    "hdpi": (480, 800),      # Alta densidade
    "xhdpi": (720, 1280),    # Extra alta densidade
    "xxhdpi": (1080, 1920),  # Dupla extra alta densidade
    "xxxhdpi": (1440, 2560)  # Tripla extra alta densidade
}

# Função para criar uma imagem com gradiente
def criar_imagem_gradiente(largura, altura, caminho_saida):
    # Criar uma nova imagem com fundo inicial
    imagem = Image.new("RGB", (largura, altura), "#000000")
    draw = ImageDraw.Draw(imagem)

    # Criar um gradiente vertical de cinza escuro para cinza claro
    for y in range(altura):
        valor_cinza = int(30 + (225 * (y / altura)))  # Gradiente do cinza escuro (30) ao claro (255)
        draw.line((0, y, largura, y), fill=(valor_cinza, valor_cinza, valor_cinza))

    # Salvar a imagem no caminho de saída
    imagem.save(caminho_saida)
    print(f"Imagem salva: {caminho_saida}")

# Gerar imagens para todas as densidades de tela
for densidade, dimensoes in tamanhos_telas.items():
    largura, altura = dimensoes
    caminho_saida = f"gradiente_cinza_{densidade}.jpg"
    criar_imagem_gradiente(largura, altura, caminho_saida)

