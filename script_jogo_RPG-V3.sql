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