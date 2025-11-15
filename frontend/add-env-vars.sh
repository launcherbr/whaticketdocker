#!/bin/sh

# O script agora USA este marcador para rodar apenas uma vez.
MARKER_FILE="/usr/src/app/.env_vars_applied_frontend"

_replaceFrontendEnvVars() {
    echo "Buscando arquivos com valores para alterar..."
    # Debug - mostrar valores das variaveis
    echo "DEBUG: REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL"
    echo "DEBUG: REACT_APP_HOURS_CLOSE_TICKETS_AUTO=$REACT_APP_HOURS_CLOSE_TICKETS_AUTO"

    # Verificar se o diretorio existe
    if [ ! -d "/usr/src/app/build" ]; then
        echo "ERRO: Pasta /usr/src/app/build inexistente"
        return 1
    fi

    # Encontra todos os arquivos que contem as variaveis ou URLs especificas
    FILES=$(grep -rl "hours_ticket_close_auto\|https://api.example.com" /usr/src/app/build || true)

    if [ -z "$FILES" ]; then
        echo "Nenhum arquivo contendo as entradas especificas encontrado."
        # Isso nao e um erro fatal, permite que o script continue e crie o marcador
        return 0
    fi

    # Escapar caracteres especiais nas variaveis de ambiente (uma vez, fora do loop)
    ESCAPED_REACT_APP_HOURS_CLOSE_TICKETS_AUTO=$(printf '%s\n' "$REACT_APP_HOURS_CLOSE_TICKETS_AUTO" | sed 's:[\\/&]:\\&:g')
    ESCAPED_REACT_APP_BACKEND_URL=$(printf '%s\n' "$REACT_APP_BACKEND_URL" | sed 's:[\\/&]:\\&:g')

    for FILE in $FILES; do
        echo "Modificando $FILE..."

        # Substituir as variaveis e URLs nos arquivos
        sed -i "s/hours_ticket_close_auto/${ESCAPED_REACT_APP_HOURS_CLOSE_TICKETS_AUTO}/g" "$FILE"
        sed -i "s|https://api.example.com|${ESCAPED_REACT_APP_BACKEND_URL}|g" "$FILE"

        echo "$FILE modificado com sucesso."
    done

    # Retorna sucesso
    return 0
}

# --- Ponto de Entrada do Script ---
if [ -f "$MARKER_FILE" ]; then
    echo "Variaveis de ambiente do frontend ja foram aplicadas. Pulando substituicoes."
else
    echo "Marca de substituicao do frontend nao encontrada. Executando..."
    
    # Chama a funcao e verifica o status de saida
    if _replaceFrontendEnvVars; then
        echo "Substituicoes do frontend concluidas. Criando marcador."
        date -u +"%Y-%m-%dT%H:%M:%SZ" > "$MARKER_FILE"
    else
        echo "Erro ao executar substituicoes do frontend. Abortando."
        exit 1
    fi
fi