NICOLAS BRUNO SOARES
n° matricula:12520512
Disciplina: Banco de dados
Professor: Anderson Costa
# Sistema de gerenciamento de campeonato de futebol

Modelagem e implementação em PostgreSQL para a atividade "Modelagem e Criação de Banco de Dados".

## Etapa 1 — Entidades, atributos e relacionamentos

| Entidade | Atributos (PK em negrito) |
|---|---|
| CAMPEONATO | **id_campeonato**, nome, ano, data_inicio, data_fim |
| TIME | **id_time**, nome, cidade, estado, ano_fundacao |
| JOGADOR | **id_jogador**, nome, data_nascimento, posicao, numero_camisa, id_time (FK) |
| ESTADIO | **id_estadio**, nome, cidade, capacidade |
| PARTIDA | **id_partida**, id_campeonato (FK), id_time_mandante (FK), id_time_visitante (FK), id_estadio (FK), data_partida, horario, gols_mandante, gols_visitante |
| PARTICIPACAO (associativa) | **id_campeonato (FK)**, **id_time (FK)**, data_inscricao |

**Relacionamentos:**

- `CAMPEONATO` e `TIME` se relacionam **N:N**: um time pode jogar vários campeonatos ao longo dos anos, e um campeonato reúne vários times. Como esse relacionamento tem um atributo próprio (`data_inscricao`), resolvi criar a entidade associativa `PARTICIPACAO`, com chave primária composta (`id_campeonato`, `id_time`).
- `TIME` → `JOGADOR` é **1:N**: cada jogador tem um único time por vez.
- `CAMPEONATO` → `PARTIDA` é **1:N**: toda partida pertence a um único campeonato.
- `TIME` → `PARTIDA` aparece **duas vezes** (mandante e visitante), por isso a tabela `partida` acaba tendo duas FKs diferentes apontando pra `time_futebol`.
- `ESTADIO` → `PARTIDA` é **1:N**: um estádio recebe várias partidas, mas cada partida acontece em um só estádio.

De todos esses, o único N:N é o de campeonato com time — o resto é sempre 1:N.

## Etapa 2 — MER

O diagrama entidade-relacionamento foi montado em cima da análise acima (entidades, atributos, PKs/FKs e cardinalidades)

## Etapas 3 e 4 — Modelo relacional e criação das tabelas

Está no arquivo `01_criacao_tabelas.sql`. Nele estão os `CREATE TABLE` de `campeonato`, `time_futebol`, `participacao`, `jogador`, `estadio` e `partida`, já com `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL` e `CHECK` definidos na própria criação.

## Etapa 5 — ALTER TABLE

Está no arquivo `02_alteracoes_alter_table.sql`. Tem 5 comandos `ALTER TABLE` (o mínimo pedido era 3), cada um com um comentário explicando o motivo: número de camisa único por time, faixa válida pro número de camisa, nome de time único, e uma coluna de status do campeonato adicionada depois, com seu `CHECK` correspondente.
