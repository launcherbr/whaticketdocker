# 🚀 Dockerize o **Whaticket**

### **Pré-requisitos**

Antes de começar, garanta que você tenha o seguinte:

  * Git instalado em sua máquina.
  * Docker e Docker Compose configurados.
  * Acesso ao Portainer.
-----

## ⚙️ Preparando o Ambiente e Construindo as Imagens

Siga os passos abaixo para preparar seu ambiente e criar as imagens Docker customizadas para o Whaticket.

#### 1\. Acesse o diretório `/opt`

```bash
cd /opt
```

#### 2\. Clone o repositório do Whaticket

Execute o comando a seguir. Será necessário informar seu usuário e token do GitHub.

```bash
git clone https://github.com/launcherbr/whaticketdocker.git whaticket
```

Serão solicitados o usuário e o token do GitHub, por se tratar de um repositório privado. Caso não tenha acesso, consulte o README disponível em https://github.com/launcherbr/whaticketsaas para instruções de como obtê-lo.

#### 3\. Acesse a pasta do projeto

```bash
cd /opt/whaticket
```

#### 4\. Construa as imagens Docker

Com os arquivos no lugar, execute o comando de build:

```bash
docker compose build
```

-----

## 🛠️ Configuração e Deploy via Portainer

### ⚠️ **ATENÇÃO: Configuração de Rede** ⚠️

Antes de criar a stack, é crucial configurar a rede no Portainer.

1️⃣ Acesse a aba **"Networks"** no menu lateral do Portainer.</br>
2️⃣ Clique em **"Add network"** e crie uma rede com o nome: **`whaticket`**.</br>
3️⃣ Se você utiliza o Traefik, vá até o container dele.</br>
4️⃣ Role até a seção **"Networks"** e adicione a rede **`whaticket`** que você acabou de criar.</br>
5️⃣ Salve e reinicie o container, se necessário.</br>

### Deploy da Stack

1️⃣ Abra o **Portainer** e vá até a aba **"Stacks"**.</br>
2️⃣ Clique em **"Add stack"** para criar uma nova stack.</br>
3️⃣ Cole o conteúdo do seu arquivo `docker-compose.yml` (ou um arquivo de exemplo como o `example-portainer.yml`) no editor web.</br>
4️⃣ Edite as **URLs**, **senhas** e outras variáveis de ambiente conforme a sua necessidade.</br>
5️⃣ Clique em **"Deploy the stack"** e aguarde o processo finalizar.</br>

-----

## 🌐 Acesso ao Whaticket

  * **URL Padrão de Acesso:** `https://seusubdominio.seudominio.com.br/login`</br>
  * **Usuário Padrão:** `admin@admin.com` </br>
  * **Senha Padrão:** `123456` </br>
