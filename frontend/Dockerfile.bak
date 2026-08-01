# Etapa de build: constrói a aplicação React
FROM node:22-alpine AS build-deps
WORKDIR /usr/src/app
COPY package*.json package-lock.json ./
RUN npm install
COPY . .

# Argumentos de build
ARG REACT_APP_BACKEND_URL=https://api.example.com
ARG REACT_APP_HOURS_CLOSE_TICKETS_AUTO=hours_ticket_close_auto

# Definir placeholders fixos durante o build
ENV REACT_APP_BACKEND_URL=${REACT_APP_BACKEND_URL}
ENV REACT_APP_HOURS_CLOSE_TICKETS_AUTO=${REACT_APP_HOURS_CLOSE_TICKETS_AUTO}

RUN npm run build

# Etapa final: serve a aplicação construída com um servidor Node.js/Express
FROM node:22-alpine
WORKDIR /usr/src/app
RUN apk add --no-cache jq nano
COPY --from=build-deps /usr/src/app/build ./build
COPY server.js ./
COPY add-env-vars.sh ./add-env-vars.sh
RUN chmod +x add-env-vars.sh
RUN npm install express@4.18.2
EXPOSE 3250

# Comando de inicialização do contêiner
# 1. Executa o script para substituir as variáveis de ambiente nos arquivos estáticos.
# 2. Inicia o servidor Express para servir os arquivos.
CMD ["sh", "-c", "sh ./add-env-vars.sh && node server.js"]
