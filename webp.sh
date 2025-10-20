#!/bin/bash

# Script para converter TODOS os arquivos PNG em um diretório para WebP.

# --- Verificação de Dependências ---
if ! command -v cwebp &> /dev/null; then
    echo "Erro: 'cwebp' (parte do pacote 'webp') não está instalado."
    echo "Por favor, instale com: sudo apt install webp"
    exit 1
fi

# --- Verificação dos Argumentos ---
if [ -z "$1" ]; then
    echo "Uso: $0 <diretorio> [qualidade_ou_lossless]"
    echo ""
    echo "Exemplos:"
    echo "  $0 .              (Converte pasta atual, qualidade 90)"
    echo "  $0 . 80           (Converte pasta atual, qualidade 80)"
    echo "  $0 . lossless     (Converte pasta atual, modo lossless)"
    echo "  $0 /home/user/fotos 75"
    exit 1
fi

TARGET_DIR="$1"
MODO="$2"

# --- Validação do Diretório ---
if [ ! -d "$TARGET_DIR" ]; then
    echo "Erro: O diretório '$TARGET_DIR' não foi encontrado."
    exit 1
fi

# --- Definição dos Parâmetros de Conversão ---
PARAMS=""
if [ -z "$MODO" ]; then
    PARAMS="-q 90"
    echo "Modo: Padrão (Qualidade 90)"
elif [ "$MODO" == "lossless" ]; then
    PARAMS="-lossless"
    echo "Modo: Lossless (sem perdas)"
else
    PARAMS="-q $MODO"
    echo "Modo: Qualidade $MODO"
fi

echo "Iniciando conversão em '$TARGET_DIR'..."

# --- Loop de Conversão ---

# O 'find' procura os arquivos.
# -maxdepth 1: Procura apenas no diretório especificado, não em subpastas.
#              (Remova isso se quiser converter recursivamente).
# -iname "*.png": Procura por .png ou .PNG (ignora maiúsculas/minúsculas).
# O 'while read' permite ler nomes de arquivos com espaços.

find "$TARGET_DIR" -maxdepth 1 -iname "*.png" | while read -r png_file; do
    
    # Define o nome do arquivo de saída (substitui .png por .webp)
    # ${png_file%.*} remove a extensão a partir do último '.'
    output_file="${png_file%.*}.webp"

    # Verifica se o arquivo .webp já existe
    if [ -f "$output_file" ]; then
        echo "Ignorando (WebP já existe): $png_file"
        continue
    fi

    echo "Convertendo: $png_file"
    
    # Executa a conversão
    cwebp $PARAMS "$png_file" -o "$output_file"
    
    if [ $? -eq 0 ]; then
        echo "  -> Sucesso: $output_file"
        
        # --- OPÇÃO DE DELETAR O ORIGINAL ---
        # Descomente a linha abaixo (remova o '#') se você quiser
        # que o arquivo .png original seja deletado após a conversão.
        # CUIDADO: ISSO É IRREVERSÍVEL!
        #
        # rm "$png_file"
        
    else
        echo "  -> FALHA ao converter $png_file"
    fi
done

echo "Conversão em lote concluída."