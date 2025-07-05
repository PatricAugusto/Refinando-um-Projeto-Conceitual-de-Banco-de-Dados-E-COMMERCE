# Projeto Conceitual de Banco de Dados: E-commerce 🛍️

## 📄 Descrição do Projeto

Este repositório contém o modelo conceitual e lógico de um banco de dados relacional para uma aplicação de e-commerce. Desenvolvido no **MySQL Workbench**, o objetivo principal é demonstrar a estrutura de dados necessária para gerenciar **clientes (Pessoa Física e Jurídica), produtos, pedidos, métodos de pagamento e informações de entrega** em uma loja online.

O projeto foi construído com foco em **escalabilidade e organização**, abordando requisitos comuns de e-commerce, como:

- **Gerenciamento de Clientes**: Distinção entre Pessoas Físicas (PF) e Pessoas Jurídicas (PJ), garantindo exclusividade de tipo para cada cliente.
- **Múltiplos Endereços**: Capacidade de um cliente ter vários endereços (entrega, cobrança, etc.).
- **Flexibilidade de Pagamento**: Suporte para que clientes cadastrem múltiplas formas de pagamento e que os pedidos registrem o método utilizado.
- **Rastreamento de Entrega**: Detalhes completos sobre o status e código de rastreio de cada pedido.
- **Estrutura de Pedidos**: Detalhamento de itens de pedido para rastrear produtos e quantidades em cada compra.

---

## 🛠️ Tecnologias Utilizadas

- **MySQL Workbench**: Ferramenta visual para design, desenvolvimento e administração de bancos de dados MySQL.
- **MySQL**: Sistema de gerenciamento de banco de dados relacional (SGBD).
- **SQL**: Linguagem padrão para gerenciar e manipular bancos de dados relacionais.

---

## 🚀 Como Executar o Projeto

### 1. Pré-requisitos

Certifique-se de ter o seguinte software instalado em seu sistema:

- **MySQL Server**: O servidor de banco de dados MySQL.
- **MySQL Workbench**: A ferramenta visual para interagir com o MySQL.  
  👉 [Download MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

### 2. Clonar o Repositório

```bash
git clone https://github.com/SeuUsuario/ecommerce-database-model.git
cd ecommerce-database-model
```

> Lembre-se de substituir `SeuUsuario` pelo seu nome de usuário do GitHub e `ecommerce-database-model` pelo nome real do seu repositório.

### 3. Abrir o Modelo no MySQL Workbench

1. Abra o MySQL Workbench.
2. Vá em `File > Open Model...`.
3. Navegue até a pasta onde você clonou o repositório e selecione o arquivo `ecommerce_db_model.mwb`.

Você verá o diagrama **EER completo** do banco de dados, com todas as tabelas e relacionamentos.

### 4. Gerar e Executar o Script SQL (Engenharia Adiante)

1. No MySQL Workbench, com o modelo aberto, vá em `Database > Forward Engineer...`.
2. Siga as instruções do assistente (as configurações padrão geralmente são suficientes).
3. Na tela de conexão, selecione ou crie uma conexão para seu servidor MySQL local (geralmente `localhost:3306` com seu usuário e senha).
4. O Workbench gerará o script SQL.
5. Clique no ícone de **Execute SQL Script** (ícone de raio) para executar os comandos e criar o banco de dados.
6. Verifique o painel de *Output* na parte inferior para garantir que a execução foi bem-sucedida.

### 5. Verificar o Banco de Dados

Após a execução do script:

1. No painel `SCHEMAS` do MySQL Workbench, clique em **Refresh**.
2. Você deverá ver um novo schema com o nome do seu projeto (ex: `ecommerce_db`).
3. Expanda-o e depois expanda a seção `Tables` para visualizar todas as tabelas criadas.

---

## 📊 Estrutura do Banco de Dados

O modelo de dados é composto pelas seguintes tabelas principais:

- **Cliente**: `id_cliente`, `nome`, `email`, `telefone`, `tipo_cliente`.
- **Cliente_PF**: `id_cliente_pf`, `cpf`, `data_nascimento`.
- **Cliente_PJ**: `id_cliente_pj`, `cnpj`, `razao_social`, `nome_fantasia`.
- **Endereco**: `id_endereco`, `id_cliente`, `rua`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `cep`, `tipo_endereco`.
- **Produto**: `id_produto`, `nome_produto`, `descricao`, `preco`, `estoque`.
- **Pedido**: `id_pedido`, `id_cliente`, `data_pedido`, `status_pedido`, `valor_total`, `id_cliente_metodo_pagamento`.
- **Item_Pedido**: `id_item_pedido`, `id_pedido`, `id_produto`, `quantidade`, `preco_unitario`.
- **Metodo_Pagamento**: `id_metodo_pagamento`, `nome_metodo`, `descricao_metodo`.
- **Cliente_Metodo_Pagamento**: `id_cliente_metodo_pagamento`, `id_cliente`, `id_metodo_pagamento`, `token_cartao`, `bandeira_cartao`, `validade_cartao`, `padrao`.
- **Entrega**: `id_entrega`, `id_pedido`, `id_endereco`, `status_entrega`, `codigo_rastreio`, `data_estimada_entrega`, `data_real_entrega`.

---

## 🤝 Contribuição

Sinta-se à vontade para explorar o projeto. **Sugestões e melhorias são sempre bem-vindas!**  
Se quiser contribuir:

1. Faça um fork deste repositório.
2. Crie uma branch para sua feature (`git checkout -b nova-feature`).
3. Faça o commit (`git commit -m 'Adiciona nova feature'`).
4. Envie para o repositório remoto (`git push origin nova-feature`).
5. Abra um **Pull Request**.

---

📬 Dúvidas, sugestões ou feedback? Abra uma *issue* ou entre em contato!
