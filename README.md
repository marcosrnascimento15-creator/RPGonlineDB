# Banco de Dados — Jogo de RPG Online (`RPGonlineDB`)

Repositório referente à atividade de modelagem e implementação de banco de dados relacional para um sistema de jogo de RPG online utilizando linguagem DDL (Data Definition Language) no **MySQL**, com base no modelo lógico do projeto (`diagrama_jogo_RPG`).

## Estrutura do Modelo de Dados

O modelo contempla as seguintes entidades e relacionamentos:

* **`USUARIOS` (1:N com `PERSONAGENS`)**: armazena os dados de acesso dos jogadores (`UsuarioId`, `Email`, `Senha`).
* **`CLASSES` (1:N com `PERSONAGENS`)**: define as classes disponíveis no jogo (`ClasseId`, `Nome`, `Descricao`).
* **`HABILIDADES` (N:N com `CLASSES`)**: cataloga as habilidades (`HabilidadeId`, `Nome`).
* **`PERSONAGENS`**: representa os personagens criados pelos usuários, vinculando-os a um usuário e a uma classe (`PersonagemId`, `NomePersonagem`, `UsuarioId`, `ClasseId`).
* **`CLASSES_HABILIDADES`**: tabela associativa que resolve o relacionamento `N:N` entre `CLASSES` e `HABILIDADES`, utilizando chave primária composta (`ClasseId`, `HabilidadeId`) e chaves estrangeiras para ambas as tabelas.

## Processos Executados

1. **Análise do modelo e revisão do script inicial**: identificação de inconsistências no rascunho inicial (chaves estrangeiras mal agrupadas, referência incorreta em `FK_PERSONAGENS_3`, ausência de chave primária composta em `CLASSES_HABILIDADES`, divergência de nomes de colunas entre tabelas e uso de `CHAR` sem tamanho definido).
2. **Adaptação para MySQL**: após liberação do uso do MySQL, remoção do comando `GO` (específico do SQL Server/T-SQL) e adoção de ponto e vírgula (`;`) para encerrar as instruções.
3. **Execução e validação DDL**: recriação limpa do banco `JogoRPG` (`DROP DATABASE IF EXISTS JogoRPG;` / `CREATE DATABASE JogoRPG;` / `USE JogoRPG;`) e criação das tabelas respeitando a ordem de dependência das chaves estrangeiras.
4. **Versionamento e entrega**: salvamento do script final em `script_jogo_RPG-V3.sql` e publicação no repositório `RPGonlineDB` no GitHub para envio do link no AVA.

## Script SQL (`script_jogo_RPG-V3.sql`)

```sql
-- ============================================================================
-- Projeto: Banco de Dados - Jogo de RPG Online
-- SGBD: MySQL
-- Descrição: Script DDL para criação do banco de dados e tabelas com base no
--            diagrama lógico do projeto (diagrama_jogo_RPG).
-- ============================================================================

-- 1. Criação e seleção do Banco de Dados
DROP DATABASE IF EXISTS JogoRPG;
CREATE DATABASE JogoRPG;

USE JogoRPG;

-- 2. Criação das Tabelas Principais (Entidades independentes)

CREATE TABLE USUARIOS (
    UsuarioId INT PRIMARY KEY,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL
);

CREATE TABLE CLASSES (
    ClasseId INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255)
);

CREATE TABLE HABILIDADES (
    HabilidadeId INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- 3. Criação das Tabelas Dependentes e Associativas

-- Relacionamentos: USUARIOS (1:N) PERSONAGENS e CLASSES (1:N) PERSONAGENS
CREATE TABLE PERSONAGENS (
    PersonagemId INT PRIMARY KEY,
    NomePersonagem VARCHAR(100) NOT NULL,
    UsuarioId INT NOT NULL,
    ClasseId INT NOT NULL,
    CONSTRAINT FK_PERSONAGENS_USUARIOS
        FOREIGN KEY (UsuarioId) REFERENCES USUARIOS (UsuarioId),
    CONSTRAINT FK_PERSONAGENS_CLASSES
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId)
);

-- Relacionamento: CLASSES (N:N) HABILIDADES
CREATE TABLE CLASSES_HABILIDADES (
    ClasseId INT NOT NULL,
    HabilidadeId INT NOT NULL,
    CONSTRAINT PK_CLASSES_HABILIDADES
        PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT FK_CLASSES_HABILIDADES_CLASSES
        FOREIGN KEY (ClasseId) REFERENCES CLASSES (ClasseId),
    CONSTRAINT FK_CLASSES_HABILIDADES_HABILIDADES
        FOREIGN KEY (HabilidadeId) REFERENCES HABILIDADES (HabilidadeId)
);
