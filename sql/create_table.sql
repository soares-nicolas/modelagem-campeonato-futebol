CREATE TABLE campeonato (
    id_campeonato   SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    ano             INTEGER NOT NULL,
    data_inicio     DATE NOT NULL,
    data_fim        DATE,
    CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE time_futebol (
    id_time         SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    cidade          VARCHAR(100) NOT NULL,
    estado          CHAR(2) NOT NULL,
    ano_fundacao    INTEGER NOT NULL CHECK (ano_fundacao > 1800)
);

CREATE TABLE participacao (
    id_campeonato   INTEGER NOT NULL,
    id_time         INTEGER NOT NULL,
    data_inscricao  DATE NOT NULL,
    PRIMARY KEY (id_campeonato, id_time),
    FOREIGN KEY (id_campeonato) REFERENCES campeonato (id_campeonato),
    FOREIGN KEY (id_time) REFERENCES time_futebol (id_time)
);

CREATE TABLE jogador (
    id_jogador       SERIAL PRIMARY KEY,
    nome             VARCHAR(100) NOT NULL,
    data_nascimento  DATE NOT NULL,
    posicao          VARCHAR(30) NOT NULL,
    numero_camisa    INTEGER,
    id_time          INTEGER NOT NULL,
    FOREIGN KEY (id_time) REFERENCES time_futebol (id_time)
);

CREATE TABLE estadio (
    id_estadio      SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    cidade          VARCHAR(100) NOT NULL,
    capacidade      INTEGER NOT NULL CHECK (capacidade > 0)
);

CREATE TABLE partida (
    id_partida          SERIAL PRIMARY KEY,
    id_campeonato       INTEGER NOT NULL,
    id_time_mandante    INTEGER NOT NULL,
    id_time_visitante   INTEGER NOT NULL,
    id_estadio          INTEGER NOT NULL,
    data_partida        DATE NOT NULL,
    horario             TIME NOT NULL,
    gols_mandante       INTEGER NOT NULL DEFAULT 0 CHECK (gols_mandante >= 0),
    gols_visitante      INTEGER NOT NULL DEFAULT 0 CHECK (gols_visitante >= 0),
    FOREIGN KEY (id_campeonato) REFERENCES campeonato (id_campeonato),
    FOREIGN KEY (id_time_mandante) REFERENCES time_futebol (id_time),
    FOREIGN KEY (id_time_visitante) REFERENCES time_futebol (id_time),
    FOREIGN KEY (id_estadio) REFERENCES estadio (id_estadio),
    CHECK (id_time_mandante <> id_time_visitante)
);