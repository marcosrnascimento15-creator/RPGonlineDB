# RPGOnlineDB

Script SQL com a estrutura de um banco de dados para um jogo de RPG online, desenvolvido em **SQL Server** como atividade da disciplina de Banco de Dados.

## Conteúdo do repositório

| Arquivo | Descrição |
|---|---|
| `rpg_online.sql` | Script DDL que cria o banco `RPGOnlineDB` e todas as tabelas |

## Modelo de dados

O banco possui cinco tabelas:

| Tabela | Descrição | Chave primária | Chaves estrangeiras |
|---|---|---|---|
| `Usuarios` | Contas dos jogadores | `UsuarioId` | - |
| `Classes` | Classes disponíveis no jogo (ex.: Guerreiro, Mago) | `ClasseId` | - |
| `Habilidades` | Habilidades que podem ser usadas no jogo | `HabilidadeId` | - |
| `Personagens` | Personagens criados pelos usuários | `PersonagemId` | `UsuarioId`, `ClasseId` |
| `Classes_Habilidades` | Tabela associativa entre classes e habilidades | (`ClasseId`, `HabilidadeId`) | `ClasseId`, `HabilidadeId` |

### Relacionamentos

- `Usuarios` 1:N `Personagens`: um usuário possui vários personagens.
- `Classes` 1:N `Personagens`: uma classe pertence a vários personagens.
- `Classes` N:N `Habilidades`: resolvido pela tabela `Classes_Habilidades`.

### Restrições aplicadas

- Chaves primárias com `IDENTITY` (autoincremento).
- `Email` de `Usuarios` com `NOT NULL` e `UNIQUE`.
- Nomes de `Classes` e `Habilidades` com `NOT NULL` e `UNIQUE`.
- Chaves estrangeiras com `FOREIGN KEY REFERENCES`.
- Chave primária composta em `Classes_Habilidades`.

## Como executar

1. Abra o **SQL Server Management Studio (SSMS)** e conecte-se ao servidor.
2. Clique em **Nova Consulta**.
3. Abra ou cole o conteúdo de `rpg_online.sql`.
4. Clique em **Executar** (ou pressione `F5`).
5. No Pesquisador de Objetos, atualize **Bancos de Dados** e confira as tabelas em `RPGOnlineDB > Tabelas`.

> Se o banco `RPGOnlineDB` já existir, o script retorna o erro 1801. Para recriá-lo do zero, execute antes `USE master` e `DROP DATABASE RPGOnlineDB`. Atenção: isso apaga todos os dados.

## Tecnologias

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Linguagem SQL (DDL)
