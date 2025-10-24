#!/bin/bash

# Função para substituir os placeholders pelos valores das variáveis de ambiente.
# Será executada apenas na primeira execução (verifica o arquivo marcador).
_replaceBackendEnvVars() {
    echo "Buscando arquivos com valores para alterar...."

    # Encontra todos os arquivos que contêm os placeholders.
    FILES=$(grep -rl "postgres_host_a_ser_mudado\|porta_postgres_a_ser_mudada\|usuario_postgres_a_ser_mudado\|senha_postgres_a_ser_mudada\|nome_postgres_a_ser_mudado\|fuso_horario_a_ser_mudado\|jwt_secreto_a_ser_mudado\|jwt_refresh_secreto_a_ser_mudado\|porta_backend_a_ser_mudada\|porta_proxy_a_ser_mudada\|https://api.example.com\|https://app.example.com\|chrome_args_a_ser_mudado\|redis_uri_a_ser_mudado\|redis_limiter_max_a_ser_mudado\|redis_limiter_duracao_a_ser_mudada\|gerencianet_sandbox_a_ser_mudado\|gerencianet_client_id_a_ser_mudado\|gerencianet_client_secret_a_ser_mudado\|gerencianet_pix_cert_a_ser_mudado\|gerencianet_pix_key_a_ser_mudado\|user_limit_a_ser_mudado\|connections_limit_a_ser_mudado\|closed_send_by_me_a_ser_mudado\|company_name_a_ser_mudado\|mail_host_a_ser_mudado\|mail_user_a_ser_mudado\|mail_pass_a_ser_mudado\|mail_from_a_ser_mudado\|mail_port_a_ser_mudado" /usr/src/app)

    if [ -z "$FILES" ]; then
        echo "Nenhum arquivo com placeholders encontrado para substituir."
        return 0
    fi

    # Escapa caracteres especiais nas variáveis para uso seguro com o 'sed'.
    ESCAPED_DB_HOST=$(printf '%s\n' "$DB_HOST" | sed 's:[\\/&]:\\&:g')
    ESCAPED_DB_PORT=$(printf '%s\n' "$DB_PORT" | sed 's:[\\/&]:\\&:g')
    ESCAPED_DB_USER=$(printf '%s\n' "$DB_USER" | sed 's:[\\/&]:\\&:g')
    ESCAPED_DB_PASS=$(printf '%s\n' "$DB_PASS" | sed 's:[\\/&]:\\&:g')
    ESCAPED_DB_NAME=$(printf '%s\n' "$DB_NAME" | sed 's:[\\/&]:\\&:g')
    ESCAPED_TZ=$(printf '%s\n' "$TZ" | sed 's:[\\/&]:\\&:g')
    ESCAPED_JWT_SECRET=$(printf '%s\n' "$JWT_SECRET" | sed 's:[\\/&]:\\&:g')
    ESCAPED_JWT_REFRESH_SECRET=$(printf '%s\n' "$JWT_REFRESH_SECRET" | sed 's:[\\/&]:\\&:g')
    ESCAPED_PORT=$(printf '%s\n' "$PORT" | sed 's:[\\/&]:\\&:g')
    ESCAPED_PROXY_PORT=$(printf '%s\n' "$PROXY_PORT" | sed 's:[\\/&]:\\&:g')
    ESCAPED_BACKEND_URL=$(printf '%s\n' "$BACKEND_URL" | sed 's:[\\/&]:\\&:g')
    ESCAPED_FRONTEND_URL=$(printf '%s\n' "$FRONTEND_URL" | sed 's:[\\/&]:\\&:g')
    ESCAPED_CHROME_ARGS=$(printf '%s\n' "$CHROME_ARGS" | sed 's:[\\/&]:\\&:g')
    ESCAPED_REDIS_URI=$(printf '%s\n' "$REDIS_URI" | sed 's:[\\/&]:\\&:g')
    ESCAPED_REDIS_OPT_LIMITER_MAX=$(printf '%s\n' "$REDIS_OPT_LIMITER_MAX" | sed 's:[\\/&]:\\&:g')
    ESCAPED_REDIS_OPT_LIMITER_DURATION=$(printf '%s\n' "$REDIS_OPT_LIMITER_DURATION" | sed 's:[\\/&]:\\&:g')
    ESCAPED_GERENCIANET_SANDBOX=$(printf '%s\n' "$GERENCIANET_SANDBOX" | sed 's:[\\/&]:\\&:g')
    ESCAPED_GERENCIANET_CLIENT_ID=$(printf '%s\n' "$GERENCIANET_CLIENT_ID" | sed 's:[\\/&]:\\&:g')
    ESCAPED_GERENCIANET_CLIENT_SECRET=$(printf '%s\n' "$GERENCIANET_CLIENT_SECRET" | sed 's:[\\/&]:\\&:g')
    ESCAPED_GERENCIANET_PIX_CERT=$(printf '%s\n' "$GERENCIANET_PIX_CERT" | sed 's:[\\/&]:\\&:g')
    ESCAPED_GERENCIANET_PIX_KEY=$(printf '%s\n' "$GERENCIANET_PIX_KEY" | sed 's:[\\/&]:\\&:g')
    ESCAPED_USER_LIMIT=$(printf '%s\n' "$USER_LIMIT" | sed 's:[\\/&]:\\&:g')
    ESCAPED_CONNECTIONS_LIMIT=$(printf '%s\n' "$CONNECTIONS_LIMIT" | sed 's:[\\/&]:\\&:g')
    ESCAPED_CLOSED_SEND_BY_ME=$(printf '%s\n' "$CLOSED_SEND_BY_ME" | sed 's:[\\/&]:\\&:g')
    ESCAPED_COMPANY_NAME=$(printf '%s\n' "$COMPANY_NAME" | sed 's:[\\/&]:\\&:g')
    ESCAPED_MAIL_HOST=$(printf '%s\n' "$MAIL_HOST" | sed 's:[\\/&]:\\&:g')
    ESCAPED_MAIL_USER=$(printf '%s\n' "$MAIL_USER" | sed 's:[\\/&]:\\&:g')
    ESCAPED_MAIL_PASS=$(printf '%s\n' "$MAIL_PASS" | sed 's:[\\/&]:\\&:g')
    ESCAPED_MAIL_FROM=$(printf '%s\n' "$MAIL_FROM" | sed 's:[\\/&]:\\&:g')
    ESCAPED_MAIL_PORT=$(printf '%s\n' "$MAIL_PORT" | sed 's:[\\/&]:\\&:g')

    for FILE in $FILES; do
        echo "Modificando $FILE..."
        
        # Substitui os placeholders pelos valores escapados.
        sed -i "s/postgres_host_a_ser_mudado/${ESCAPED_DB_HOST}/g" "$FILE"
        sed -i "s/porta_postgres_a_ser_mudada/${ESCAPED_DB_PORT}/g" "$FILE"
        sed -i "s/usuario_postgres_a_ser_mudado/${ESCAPED_DB_USER}/g" "$FILE"
        sed -i "s/senha_postgres_a_ser_mudada/${ESCAPED_DB_PASS}/g" "$FILE"
        sed -i "s/nome_postgres_a_ser_mudado/${ESCAPED_DB_NAME}/g" "$FILE"
        sed -i "s/fuso_horario_a_ser_mudado/${ESCAPED_TZ}/g" "$FILE"
        sed -i "s/jwt_secreto_a_ser_mudado/${ESCAPED_JWT_SECRET}/g" "$FILE"
        sed -i "s/jwt_refresh_secreto_a_ser_mudado/${ESCAPED_JWT_REFRESH_SECRET}/g" "$FILE"
        sed -i "s/porta_backend_a_ser_mudada/${ESCAPED_PORT}/g" "$FILE"
        sed -i "s/porta_proxy_a_ser_mudada/${ESCAPED_PROXY_PORT}/g" "$FILE"
        sed -i "s|https://api.example.com|${ESCAPED_BACKEND_URL}|g" "$FILE"
        sed -i "s|https://app.example.com|${ESCAPED_FRONTEND_URL}|g" "$FILE"
        sed -i "s/chrome_args_a_ser_mudado/${ESCAPED_CHROME_ARGS}/g" "$FILE"
        sed -i "s/redis_uri_a_ser_mudado/${ESCAPED_REDIS_URI}/g" "$FILE"
        sed -i "s/redis_limiter_max_a_ser_mudado/${ESCAPED_REDIS_OPT_LIMITER_MAX}/g" "$FILE"
        sed -i "s/redis_limiter_duracao_a_ser_mudada/${ESCAPED_REDIS_OPT_LIMITER_DURATION}/g" "$FILE"
        sed -i "s/gerencianet_sandbox_a_ser_mudado/${ESCAPED_GERENCIANET_SANDBOX}/g" "$FILE"
        sed -i "s/gerencianet_client_id_a_ser_mudado/${ESCAPED_GERENCIANET_CLIENT_ID}/g" "$FILE"
        sed -i "s/gerencianet_client_secret_a_ser_mudado/${ESCAPED_GERENCIANET_CLIENT_SECRET}/g" "$FILE"
        sed -i "s/gerencianet_pix_cert_a_ser_mudado/${ESCAPED_GERENCIANET_PIX_CERT}/g" "$FILE"
        sed -i "s/gerencianet_pix_key_a_ser_mudado/${ESCAPED_GERENCIANET_PIX_KEY}/g" "$FILE"
        sed -i "s/user_limit_a_ser_mudado/${ESCAPED_USER_LIMIT}/g" "$FILE"
        sed -i "s/connections_limit_a_ser_mudado/${ESCAPED_CONNECTIONS_LIMIT}/g" "$FILE"
        sed -i "s/closed_send_by_me_a_ser_mudado/${ESCAPED_CLOSED_SEND_BY_ME}/g" "$FILE"
        sed -i "s/company_name_a_ser_mudado/${ESCAPED_COMPANY_NAME}/g" "$FILE"
        sed -i "s/mail_host_a_ser_mudado/${ESCAPED_MAIL_HOST}/g" "$FILE"
        sed -i "s/mail_user_a_ser_mudado/${ESCAPED_MAIL_USER}/g" "$FILE"
        sed -i "s/mail_pass_a_ser_mudado/${ESCAPED_MAIL_PASS}/g" "$FILE"
        sed -i "s/mail_from_a_ser_mudado/${ESCAPED_MAIL_FROM}/g" "$FILE"
        sed -i "s/mail_port_a_ser_mudada/${ESCAPED_MAIL_PORT}/g" "$FILE" # Note: Original file had a typo here, might want to check the placeholder in your code

        echo "$FILE modificado com sucesso."
    done

    return 0
}

# Constrói a string de conexão com o banco de dados.
DB_URI="postgresql://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

# Função para rodar migrações do banco.
# Executa sempre para garantir que o schema do banco esteja sincronizado com o código.
_runMigrations() {
    echo "Executando migrações do banco de dados..."
    npx sequelize db:migrate
    echo "Migrações finalizadas."
}

# Função para popular o banco de dados com dados iniciais.
# Executa apenas uma vez, controlada pela existência da tabela 'SeedControl'.
_runSeed() {
    # Verifica se a tabela SeedControl existe para evitar executar o seed novamente.
    TABLE_EXISTS=$(psql ${DB_URI} -Atc "SELECT to_regclass('public.SeedControl');")

    if [ "$TABLE_EXISTS" = "seedcontrol" ]; then
        echo "Banco de dados já populado (seed). Pulando esta etapa."
    else
        echo "Populando (seeding) o banco de dados pela primeira vez..."
        npx sequelize db:seed:all
        psql ${DB_URI} -c "CREATE TABLE SeedControl (id SERIAL PRIMARY KEY, seed_name VARCHAR(255) NOT NULL, applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);"
        psql ${DB_URI} -c "INSERT INTO SeedControl (seed_name) VALUES ('initial_seed');"
        echo "Banco de dados populado com sucesso."
    fi
}

# --- Ponto de Entrada do Script ---
MARKER_FILE="/usr/src/app/.env_vars_applied"

if [ -f "$MARKER_FILE" ]; then
    echo "Variáveis de ambiente já foram aplicadas anteriormente. Pulando substituições."
else
    echo "Marca de substituição não encontrada. Executando substituições de placeholders..."
    if _replaceBackendEnvVars; then
        echo "Substituições concluídas com sucesso. Criando marcador para evitar nova substituição."
        date -u +"%Y-%m-%dT%H:%M:%SZ" > "$MARKER_FILE"
    else
        echo "Erro ao executar substituições. Abortando."
        exit 1
    fi
fi

# Executa migrações e seed conforme regras originais.
_runMigrations
_runSeed
